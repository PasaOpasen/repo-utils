#
# tags current commit and pushes it to repo
#
# usage: 
#   bash tag-version.sh tag
#

set -e

cd ../

tag=$1
if [ -z "$tag" ]
then
    echo "Will use version from version.txt as a tag"
    tag="$(cat version.txt)"
fi

git tag $tag
git push $tag

