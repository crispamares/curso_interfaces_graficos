#!/bin/bash

BASEDIR=`pwd` 

#
# Find a supradirectory with pandoc & reveal resource dir 
#
while :
do
    if [[ `pwd` == / ]]; then
	echo "No rsc dir founded"
	exit
    else
	if [[ -e "rsc"  && -e "rsc/build.sh" ]]; then
	    RSC=`pwd`/rsc
	    break
	fi

	cd ..
    fi
done

cd $BASEDIR

#
# Build the slides
#

for i in `ls *.md`; do
    name=`basename $i .md`;
    pandoc -t revealjs -V revealjs-url:$RSC/reveal.js -s $i -V transition="linear" -V theme="simple" --smart -c $RSC/style.css --template=$RSC/template.revealjs -o $name.html;
#    pandoc -s $i -t beamer --template=../rsc/default.beamer -o $name.pdf -V graphics;
done
