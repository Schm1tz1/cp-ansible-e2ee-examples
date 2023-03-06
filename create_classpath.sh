#!/usr/bin/env bash

input_dir="e2ee-2.0.9-cp7.3"

e2ee_dirs=$(find $input_dir/* -type d | sed "s/$input_dir/\/opt\/e2ee/g")
tmp_classpath=''

for i in $e2ee_dirs; do
    tmp_classpath=$tmp_classpath:$i/*
done

classpath=${tmp_classpath:1}
echo "# Add this to your hosts.yml"
echo "kafka_connect_service_environment_overrides:"
echo "  CLASSPATH: \"$classpath\""
