#!/bin/bash
# Joy tool requests sudo to run -> run this script with sudo permission


src_joy_dir="wireshark-pcaps"
dst_data_set_dir="joy-data"

echo $src_joy_dir
echo $dst_data_set_dir

for dir in $src_joy_dir/*
do
 dir_name=$(basename -- "$dir")
 for f in $dir/*
 do
  filename=$(basename -- "$f")
  echo "Processing $filename .." 
  #extension="${filename##*.}"
  name="${filename%.*}"
  
  joy bidir=1 http=1 dns=1 tls=1 dist=1 entropy=1 exe=1 idp=5 hd=1 wht=1 dhcp=1 payload=1 ppi=1 output=$dst_data_set_dir/$dir_name/$name.gz $f
 done
done
