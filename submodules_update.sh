git submodule foreach git pull origin master
git add .
git commit -m "Update submodules"
git pull --rebase
git push