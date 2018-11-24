runhaskell site.hs clean
runhaskell site.hs build
stack exec site rebuild
git add .
git commit -m "Rebuild"
git push
cp -R _site/*  ../edipofederle.github.io
cd ../edipofederle.github.io
git add .
git commit -m "New version"
git commit -m 'rebuild pages' --allow-empty
git push origin master
