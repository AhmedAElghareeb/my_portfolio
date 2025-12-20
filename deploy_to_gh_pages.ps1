# Deploy to GitHub Pages

# Navigate to build output
cd build\web

# Initialize a new git repo
git init
git branch -m main

# Connect to remote
git remote add origin https://github.com/AhmedAElghareeb/my_portfolio.git

# Track changes
git add .
git commit -m "Deploy to GitHub Pages"

# Force push to gh-pages branch
# This overwrites the history of gh-pages to just this commit (which is what we want for a build artifact)
git push -u -f origin main:gh-pages

Write-Host "Deployed successfully to https://AhmedAElghareeb.github.io/my_portfolio/"
