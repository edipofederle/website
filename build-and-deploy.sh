stack build
stack exec site clean
stack exec site build
git add .
git commit -m "Rebuild"
git push
cp -R _site/*  ../edipofederle.github.io
cd ../edipofederle.github.io
git add .
git commit -m "New version"
git commit -m 'rebuild pages' --allow-empty
git push origin master
