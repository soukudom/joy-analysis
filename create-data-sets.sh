#!/bin/bash


src_joy_dir="joy-data"
dst_data_set_dir="data-sets"
joy="../joy/sleuth"

echo $src_joy_dir
echo $dst_data_set_dir

for dir in $src_joy_dir/*
do
 dir_name=$(basename -- "$dir")
 for f in $dir/*
 do
  echo "Processing $f .." 
  filename=$(basename -- "$f")
  extension="${filename##*.}"
  name="${filename%.*}"
 $joy $f --where "da=192.168.3.213 | sa=192.168.3.213" > "$dst_data_set_dir/$dir_name/$name.json"
 done
done


#../joy/sleuth joy-data/ikea-capture-app-change-color.gz --where "da=192.168.3.213 | sa=192.168.3.213" --select "ip,pr,sa,da,sp,dp,byte_dist,packets,total_entropy,byte_dist_mean,entropy" | less
