#!/bin/bash

# ============= Functions =============

usage() {
    	echo "Usage:"
    	echo "  $0 -t <tag_name>    # Create tag"
    	echo "  $0 -l               # List tags"
    	echo "  $0 -d <tag_name>    # Delete tag"
    	exit 1
}

create_tag() {
    	local tag=$1
    	if [ -z "$tag" ]; then
        	echo "Error: tag name required"
        	usage
    	fi
    	echo "Creating tag '$tag'..."
    	git tag "$tag"
}

list_tags() {
    	echo "Listing tags..."
    	git tag
}

delete_tag() {
    	local tag=$1
    	if [ -z "$tag" ]; then
        	echo "Error: tag name required"
        	usage
    	fi
    	echo "Deleting tag '$tag'..."
    	git tag -d "$tag"
}

# ============= Main =============

if [ $# -eq 0 ]; then
    usage
fi

case $1 in
    -t)
        tag=$2
        create_tag "$tag"
        ;;

    -l)
        list_tags
        ;;

    -d)
        tag=$2
        delete_tag "$tag"
        ;;

    *)
        usage
        ;;
esac
