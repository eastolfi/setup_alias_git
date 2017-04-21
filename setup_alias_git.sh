#!/bin/bash
git config --local --rename-section alias 'alias-old'

git config --local alias.lol 'log --oneline --decorate --graph --abbrev-commit --all'
git config --local alias.st 'status'
git config --local alias.lines 'log --oneline --decorate'
git config --local alias.undo-soft 'reset --soft HEAD^'
git config --local alias.undo-hard 'reset --hard HEAD^'
git config --local alias.s 'status -s'
git config --local alias.pullr 'pull --rebase'
git config --local alias.pending-branches 'branch --no-merged'
git config --local alias.merged-branches 'branch --merged'
git config --local alias.f 'fetch'

echo "The aliases has been included. All the old aliases are new within 'alias-old'"