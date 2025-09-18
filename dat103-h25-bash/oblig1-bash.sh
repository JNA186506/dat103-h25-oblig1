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

(tail -n+2 | sort -t "," -k3,3) <$directory/grieg.txt

print_dash

grep "Stage" $directory/grieg.txt

print_dash

awk -F ',' '$3 >= 1870 { print $0 }' $directory/grieg.txt

print_dash

touch $directory/vocal.txt | grep 'Vocal' edvard.txt > $directory/vocal.txt
cat $directory/vocal.txt

print_dash

touch $directory/piano.txt | grep 'Piano' edvard.txt > $directory/piano.txt
cat $directory/piano.txt

print_dash

echo $heltall

for file in ~/bashscript/*
do
	heltall=($(wc -l $file))
	if [ $heltall -lt 3 ]; then
		for i in $(seq 1 $heltall);
		do
			cp $file ${file%%.*}-$i.txt
		done
	fi
done

wc ~/bashscript/*

print_dash
