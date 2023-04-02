#!/bin/bash

get_value() {
    # parse arguments
    local object=$1
    local key=$2

    # split key into array of keys
    IFS="/" read -ra keys <<< "$key"

    # get value corresponding to each key
    local value="$object"
    for k in "${keys[@]}"; do
        value=$(echo "$value" | jq -r ".$k")
        if [ "$value" = "null" ]; then
            echo "Error: key '$key' not found in object" >&2
            exit 1
        fi
    done

    echo "$value"
}
