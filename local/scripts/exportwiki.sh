#/bin/bash
if [ ! -x $(command -v lowdown) ];
then
  echo "lowdown is required to export the wiki, please install it first"
  exit 1
fi

WIKI_FOLDER="$HOME/.vimwiki/wiki"
HTML_FOLDER="$HOME/.vimwiki/html"

find $WIKI_FOLDER -type f -iname "*.md" | while read file
do
  ## First let's trim off the path
  filename=$(sed -r "s/^${WIKI_FOLDER//\//\\/}\///" <<< $file)

  ## Then we remove the extension
  noext=$(sed -r "s/.md//" <<< $filename)

  ## Now let's get the right html path
  target_html="${HTML_FOLDER}/${noext}.html"

  ## Let's create the folder if required
  target_folder=$(dirname $target_html)
  mkdir -p $target_folder

  lowdown -s $file > $target_html

  ## Attempt to correct links to have the html extension, pretty hacky...
  sed -i -r -e 's|(href=")([a-zA-z/-]+)(">)|\1\2.html\3|g' $target_html
done
