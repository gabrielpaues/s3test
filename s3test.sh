#!/bin/bash
BUCKETNAME=s3test-$RANDOM
END=1
#Generate the testfiles

for x in $(seq 1 $END);
do 
    dd if=/dev/zero of=4G-$x bs=1 count=1 seek=4294967295
#    dd if=/dev/zero of=4G-$x bs=1 count=1 seek=4294967
done
s3cmd mb s3://$BUCKETNAME


time (
for x in 4G-*;
do
    s3cmd --no-progress put $x s3://$BUCKETNAME &
done
wait
)
s3cmd del --recursive --force s3://$BUCKETNAME

for x in $(seq 1 $END);
do 
    rm 4G-$x 
done
