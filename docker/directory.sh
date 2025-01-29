#!/bin/sh

set -evx

# blow away any old repo copy in pod
rm -Rf ds2002-directory/

# pull in the repo
git clone https://$PAT@github.com/uvasds-systems/ds2002-directory
cd ds2002-directory/people/

# Blow away the README and rebuild
touch README.md

# Get total entry count
COUNT=`ls -al | wc -l`
COUNT=$((COUNT - 4))

# readme boilerplate
echo "# ds2002-directory" > README.md
echo " " >> README.md
echo "A people directory for DS2002 \($COUNT people\)" >> README.md
echo " " >> README.md

# fetch name of each person and set up tree
for dir in */; do
    if [ -d "$dir" ]; then
        NAME=`head -1 $dir/README.md | sed -e 's/#//g;'`
        plaindir=${dir%/}
        echo "- **$plaindir** - [$NAME](people/$dir)" >> README.md
    fi
done

# move file to base dir and follow it
mv README.md ../README.md
cd ..

# perform global git setup things
git config --global user.email "nem2p@virginia.edu"
git config --global user.name "N Magee"

# determine if there's anything to commit+push
# --porcelain gives clean machine-readable output
if [ -z "$(git status --porcelain)" ]; then 
# if [ $(git status --porcelain) == "" ]; then
  echo "Working tree clean. Stop"
  exit 0
else
  echo "Working tree has changes"
  git commit -am "updated directory via merge"
  git push origin main
  exit 0
fi
