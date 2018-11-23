stack exec site rebuild
git add .
git commit -m "Rebuild"
git push
cp -R _site/*  ../edipofederle.github.io
cd ../edipofederle.github.io
git add .
git commit -m "New version"
git push
