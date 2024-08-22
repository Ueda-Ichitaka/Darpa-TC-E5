#!/bin/bash

cd /home/riru/APT-Hunter
source apthunter/bin/activate


# $1 performer
# $2 filename
# $3 files lower boundary
# $4 files upper boundary
# $5 convert to csv
convert() {

    consumer_home=/home/riru/Engagement5/Tools/ta3-java-consumer/tc-bbn-kafka
    data_path=/home/riru/Engagement5/Data
    performer=$1 #cadets
    filename=$2  #ta1-cadets-1-e5-official-2.bin

    cd "$data_path/$performer"

    for f in $filename.*.gz
    do

        if [ ! -f "${f%.*}" ]
        then
            echo ""
            echo "starting to decompress $f ..."
            gunzip -c "$f" > ./"${f%.*}"
            echo "done unzipping $f , continuing with the next one..."
            echo ""
        else
            echo ""
            echo "File $filename already decompressed, skipping..."
            echo ""
        fi
    done

    cd $consumer_home

    echo "now converting binaries to json"

    if [ ! -f "$data_path/$performer/$filename.json.2" ]
    then
        ./json_consumer.sh "$data_path/$performer/$filename"
    else
        echo ""
        echo "File $filename already converted, skipping..."
        echo ""
    fi

    for i in $(seq $3 $4)
    do
        if [ ! -f "$data_path/$performer/$filename.$i.json.2" ]
        then
            echo ""
            echo -e "consuming file $filename.$i to json"
            ./json_consumer.sh "$data_path/$performer/$filename.$i"
            echo ""
        else
            echo ""
            echo "File $filename.$i already converted, skipping..."
            echo ""
        fi
    done


    for j in *.json*
    do
        mv $j $data_path/$performer/$j
        if [ $5 -eq 1 ]
        then
            echo ""
            echo "starting to convert $f to csv now..."
            cat "$data_path/$j" | jsoncsv | mkexcel > $data_path/$performer/"${j%}".csv
            echo "file $j completed!"
            echo ""
        fi
    done



}

convert "trace" "ta1-trace-2-e5-official-1.bin" "1" "190" "0"
