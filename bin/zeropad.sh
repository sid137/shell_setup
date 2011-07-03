#!/bin/bash

# Zeropad the numerical part of filenames.  Call by
# zeropad.sh filename number
# where number is the number of digits in the number.  Defaults to 3
# To rename a directory of files, try
# for i in *.png;do mv $i `./zeropad.sh $i number`; done
# Set format to default with 3 spaces, if unspecified
spaces=${2-3}
fmt="%0"$spaces"d"
num=`expr match "$1" '[^0-9]*\([0-9]\+\).*'`
paddednum=`printf "%03d" $num`
echo ${1/$num/$paddednum}
