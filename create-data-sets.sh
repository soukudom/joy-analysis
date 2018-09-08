#!/bin/bash


joy_dir="joy-data"
data_set_dir="data-sets"
joy="../joy/sleuth"

echo $joy_dir
echo $data_set_dir

for f in $joy_dir/*
do
 echo "Processing $f .." 
 filename=$(basename -- "$f")
 extension="${filename##*.}"
 name="${filename%.*}"
$joy $f --where "da=192.168.3.213 | sa=192.168.3.213" --select "ip,pr,sa,da,sp,dp,byte_dist,packets,total_entropy,byte_dist_mean,entropy" > "$data_set_dir/$name.json"
done


#../joy/sleuth joy-data/ikea-capture-app-change-color.gz --where "da=192.168.3.213 | sa=192.168.3.213" --select "ip,pr,sa,da,sp,dp,byte_dist,packets,total_entropy,byte_dist_mean,entropy" | less
