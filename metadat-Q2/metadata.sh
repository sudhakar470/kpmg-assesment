#!/bin/bash
metadata=$(curl -s http://169.254.169.254/latest/meta-data/)
for item in $metadata
do
    value=$(curl -s http://169.254.169.254/latest/meta-data/$item)
    echo "\"$item\": \"$value\","
done