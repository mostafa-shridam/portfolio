git init
git add .
git commit -m "Remove push_web file from web folder"
git branch -M gh-pages
git remote add origin https://github.com/mostafa-shridam/portfolio.git
git push -u origin gh-pages --force  