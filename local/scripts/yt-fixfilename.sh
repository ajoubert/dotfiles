#/bin/bash

echo "replacing all underscores in filenames"
find $1 -name "* *.mp3" -type f -print0 | \
  while read -d $'\0' f; do 
 	mv -v "$f" "${f// /_}"; 
done

echo "replacing all spaces in filenames"
for f in `find`; do mv -v "$f" "`echo $f | tr '[A-Z]' '[a-z]'`"; done

echo "Done!"
