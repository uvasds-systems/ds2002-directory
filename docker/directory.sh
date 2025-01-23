#!/bin/sh

set -evx

rm -Rf ds2002-directory/

git clone https://$PAT@github.com/uvasds-systems/ds2002-directory
cd ds2002-directory/people/

# Blow away the README and rebuild
touch README.md

# readme boilerplate
echo "# ds2002-directory" > README.md
echo " " >> README.md
echo "A people directory for DS2002" >> README.md
echo " " >> README.md

# fetch name of each person and set up tree
for dir in */; do
    if [ -d "$dir" ]; then
        NAME=`head -1 $dir/README.md | sed -e 's/#//g;'`
        plaindir=${dir%/}
        echo "- **$plaindir** - [$NAME](people/$dir)" >> README.md
    fi
done

# move to base dir
mv README.md ../README.md

cd ..

git config --global user.email "nem2p@virginia.edu"
git config --global user.name "N Magee"
git commit -am "updated directory via merge"
git push origin main
