#!/bin/bash

if [ -d "./.deploy_git" ]; then
  echo "Removing .deploy_git folder..."
  rm -rf ./.deploy_git
  echo "Folder removed."
fi

# Initialize target with currently deployed files
git clone --depth 1 --branch=master https://github.com/nealajpatel/code-trails-blog.git .deploy_git

cd .deploy_git

# Remove all files before they get copied from ../public/
# so git can track files that were removed in the last commit
find . \(-path ./.git -o -path ./.circleci \) -prune -o -exec rm -rf {} \; 2> /dev/null

git clone https://github.com/Chorer/hexo-theme-PureBlue.git themes/

cd ../

if [ ! -d "./public" ]; then
  hexo generate
fi

# Run deployment
hexo deploy
