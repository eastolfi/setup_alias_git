#!/bin/bash

c_type="--local"

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

ALIASES=($(git config $c_type -l --name-only | grep alias))
length=${#ALIASES[@]}

if [ $length -gt 0 ]; then
	echo "This aliases will be deleted : "
	for ((i = 0; i != length; i++)); do
		echo "${ALIASES[i]}"
	done
	read -p 'Are you sure that is you want ? (y/n) ' checkin
	if [ "$checkin" = "n" ]; then
		echo "Nothing changed"
		exit 0
	else
		ALIASES_SUBSECTION=($(git config $c_type --list --name-only | grep -oE "alias\.[a-zA-Z]*\." | grep -oE "alias\.[a-zA-z]*" | sort -u))
		length_subsection=${#ALIASES_SUBSECTION[@]}

		eval `git config $c_type --remove-section 'alias'`
		for ((i = 0; i != length_subsection; i++)); do
			eval `git config $c_type --remove-section "${ALIASES_SUBSECTION[i]}"`
		done

		echo "All aliases deleted now time to create new aliases"
	fi
fi

# Basics
eval `git config $c_type alias.st 'status'`
eval `git config $c_type alias.s 'status -s'`
eval `git config $c_type alias.f 'fetch'`
eval `git config $c_type alias.p 'pull'`
eval `git config $c_type alias.cp 'cherry-pick'`
eval `git config $c_type alias.co 'checkout'`

eval `git config $c_type alias.aa '!git add -u && git add . && git s'`
eval `git config $c_type alias.cm '!f() { git commit -m "$1"; }; f'`
eval `git config $c_type alias.ca 'commit --amend --no-edit'`
eval `git config $c_type alias.cma '!f() { git commit -m "$1" --author="$2" <"$3">; }; f'`
eval `git config $c_type alias.ri '!f() { git rebase -i HEAD~${1}; }; f'`

# Logging
eval `git config $c_type alias.lol 'log --oneline --decorate --graph --abbrev-commit --all'`
eval `git config $c_type alias.lines 'log --oneline --decorate'`
eval `git config $c_type alias.logfile 'log --follow'`

# Alterations
eval `git config $c_type alias.undo.soft 'reset --soft HEAD^'`
eval `git config $c_type alias.undo.hard 'reset --hard HEAD^'`
eval `git config $c_type alias.undo.first 'update-ref -d HEAD'`

# Branches
eval `git config $c_type alias.branches.unmerged 'branch --no-merged'`
eval `git config $c_type alias.branches.merged 'branch --merged'`
eval `git config $c_type alias.branches.prune 'remote prune origin'`
eval `git config $c_type alias.branches.clean '!git branch --merged | grep -v "\\*\\|master\\|develop" | xargs -n 1 git branch -d'`
eval `git config $c_type alias.branches.list '!git for-each-ref --sort="-authordate" --format="%(authordate)%09%(objectname:short)%09%(refname)" refs/heads | sed -e "s-refs/heads/--"'`

# Utils
eval `git config $c_type alias.pullr 'pull --rebase'`
eval `git config $c_type alias.visual '!gitk'`
eval `git config $c_type alias.fst '!git fetch && git status'`
eval `git config $c_type alias.conf 'config -l'`
eval `git config $c_type alias.alias '!git config -l | grep alias | cut -c 7-'`

# Fun
eval `git config $c_type alias.fun.random '!f() { git commit -m "$(echo $(curl -s http://whatthecommit.com/index.txt))"; }; f'`
eval `git config $c_type alias.fun.topcommiters '!f() { git shortlog -sne --no-merges | head -n${1:-10}; }; f'`

# Initialization
# Use it as git init.user "Username" "email"
eval `git config $c_type alias.init.user '!f() { git config --local user.name "$1" && git config --local user.email "$2"; }; f'`

# patching
eval `git config $c_type alias.patch.stash '!f() { git show -p stash@{"$1"} > "$2.patch"; }; f'`

echo "The aliases has been included in '$c_type' config."
