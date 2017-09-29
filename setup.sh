#!/bin/bash

c_type="local"

case $1 in
	global)
		c_type="--global"
	;;
	system)
		c_type="--system"
	;;
	*)
		c_type="--local"
	;;
esac

# Rename old aliases
eval "git config $c_type --rename-section alias 'alias-old'"
eval "git config $c_type --rename-section alias.undo 'alias-old.undo'"
eval "git config $c_type --rename-section alias.branches 'alias-old.branches'"

# Basics
eval "git config $c_type alias.st 'status'"
eval "git config $c_type alias.s 'status -s'"
eval "git config $c_type alias.f 'fetch'"
eval "git config $c_type alias.p 'pull'"

# Logging
eval "git config $c_type alias.lol 'log --oneline --decorate --graph --abbrev-commit --all'"
eval "git config $c_type alias.lines 'log --oneline --decorate'"
eval "git config $c_type alias.logfile 'log --follow'"

# Alterations
eval "git config $c_type alias.undo.soft 'reset --soft HEAD^'"
eval "git config $c_type alias.undo.hard 'reset --hard HEAD^'"

# Branches
eval "git config $c_type alias.branches.unmerged 'branch --no-merged'"
eval "git config $c_type alias.branches.merged 'branch --merged'"

# Utils
eval "git config $c_type alias.pullr 'pull --rebase'"
eval "git config $c_type alias.visual '!gitk'"


echo "The aliases has been included in '$c_type' config. All the old aliases are new within 'alias-old'"
