#!/bin/bash
FOLDER='FluidR3_GM(2)'
FILES="./${FOLDER}/*"
for f in $FILES
do
  echo "Processing ${f} file..."
  INSTRUMENT=`echo $f | grep -o -P '(?<=\)/).*(?=\-)'`
  
  if [ ! -d "./${FOLDER}/${INSTRUMENT}" ]; then
    echo 'mkdir "./${FOLDER}/${INSTRUMENT}"'
    mkdir "./${FOLDER}/${INSTRUMENT}"
  fi
  
  if [ ! -d $f ]; then
	var=`awk '/^".*":.*$/{print $i}' $f`
	for i in $var
	do
	tempname=`echo $i | grep -oP -m 1 '"\K[^":]+' | head -1`
	if [ $tempname = "data" ]; then
	  echo "./${FOLDER}/${INSTRUMENT}/${filename}.json"
	  echo '{"note":' > "./${FOLDER}/${INSTRUMENT}/${filename}.json"
	  echo ${i%?} >> "./${FOLDER}/${INSTRUMENT}/${filename}.json"
	  echo "}" >> "./${FOLDER}/${INSTRUMENT}/${filename}.json"
	  #remove whitespace
	  tr -d ' \t\n\r\f' <"./${FOLDER}/${INSTRUMENT}/${filename}.json" >"./temp"
	  cat "./temp" > "./${FOLDER}/${INSTRUMENT}/${filename}.json"
	else
	  filename=$tempname
	  #echo $filename
	fi
	done
  fi
done
rm "./temp"
