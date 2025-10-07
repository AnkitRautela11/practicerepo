#!/bin/bash

# ============= Functions =============

usage() {
	echo "Usage:"
    	echo "  $0 -l                              # List branches"
    	echo "  $0 -b <branch_name>                # Create branch"
    	echo "  $0 -d <branch_name>                # Delete branch"
    	echo "  $0 -m -1 <branch1> -2 <branch2>    # Merge branch1 into branch2"
    	echo "  $0 -r -1 <branch1> -2 <branch2>    # Rebase branch1 onto branch2"
    	exit 1
}

list_branches() {
    	echo "Listing branches..."
    	git branch
}

create_branch() {
    	local branch=$1
    	if [ -z "$branch" ]; then
        	echo "Error: branch name required"
        	usage
    	fi
    	echo "Creating branch '$branch'..."
    	git branch "$branch"
}

delete_branch() {
    	local branch=$1
    	if [ -z "$branch" ]; then
        	echo "Error: branch name required"
        	usage
    	fi
    	echo "Deleting branch '$branch'..."
    	git branch -d "$branch"
}

merge_branches() {
    	local branch1=$1
    	local branch2=$2
    	echo "Merging $branch1 into $branch2..."
    	git checkout "$branch2" && git merge "$branch1"
}

rebase_branches() {
    	local branch1=$1
    	local branch2=$2
    	echo "Rebasing $branch1 onto $branch2..."
    	git checkout "$branch1" && git rebase "$branch2"
}

# ============= Main =============

if [ $# -eq 0 ]; then
    	usage
fi

case $1 in
    -l)
        list_branches
        ;;

    -b)
        create_branch "$2"
        ;;

    -d)
        delete_branch "$2"
        ;;

    -m)
        if [ "$2" != "-1" ] || [ "$4" != "-2" ]; then
            echo "Error: Invalid merge syntax"
            usage
        fi
        merge_branches "$3" "$5"
        ;;

    -r)
        if [ "$2" != "-1" ] || [ "$4" != "-2" ]; then
            echo "Error: Invalid rebase syntax"
            usage
        fi
        rebase_branches "$3" "$5"
        ;;

    *)
        usage
        ;;
esac
