#!/bin/bash

print_dash() {
	printf -- '-%0.s' {1..25}
	echo
}

print_grieg() {
	cat $directory/grieg.txt
}

read -p "Input the name of the file to be processed: " filename

directory=~/bashscript/

if [ -d "$directory" ]; then
	rm -Rf $directory
	mkdir $directory
	cp edvard.txt $directory
	mv $directory/edvard.txt $directory/grieg.txt
else 
	mkdir $directory
	cp edvard.txt $directory
	mv $directory/edvard.txt $directory/grieg.txt
fi

echo "Reading file: " $filename

print_dash

cat edvard.txt

print_dash

printf '6m0\nw\nq\n' | ed -s $directory/grieg.txt
print_grieg

print_dash

(tail -n+2 | sort -t "," -k3,3) < $directory/grieg.txt

print_dash

grep "Stage" $directory/grieg.txt

print_dash
