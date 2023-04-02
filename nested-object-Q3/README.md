# Pre-requuisites
1. jq

This script uses JQ tool (command line JSON tool) to extract the value corresponding to each key in the given key path. It splits the key path into an array of keys, and iteratively extracts the value corresponding to each key until the final value is reached.

If the final value is null, the function prints an error message to standard error and exits with a non-zero status.

Here is an example on how to use the function 

`object='{ "a": { "b": { "c": "d" } } }'
key='a/b/c'
value=$(get_value "$object" "$key")
echo "$value"  # prints "d"

object='{ "x": { "y": { "z": "a" } } }'
key='x/y/z'
value=$(get_value "$object" "$key")
echo "$value"  # prints "a"`
