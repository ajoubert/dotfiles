#/bin/bash

OUTPUT=$(find ${VIM_CONFIG}/plugged_overwrite/ -maxdepth 5 -type f,l)

for FILE in $OUTPUT
do
  if [[ $FILE != *"$1"* ]];
  then
    echo "Overwrite not specified as input, ignoring ${FILE}"
    continue
  fi

  echo "Overwrite ${FILE} matches input ${1}!"

  RELATIVE=$(realpath -s --relative-to="${VIM_CONFIG}/plugged_overwrite" $FILE)
  TARGET="${VIM_CONFIG}/plugged/${RELATIVE}"
  if [ -f "$TARGET" ];
  then
    cat "$FILE" >> "$TARGET";
  else
    echo "File has no equivalent: ${FILE}"
  fi
done
