#!/bin/bash

input_list = $1

while read input; do
	./urlhaus host $input >> bulk_lookup_out.txt
done < $input_list
