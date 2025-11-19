#!/bin/sh
#
# rebase and perltidy at the same time, or just tidy HEAD
#
# Usage:
#   ./rebase_tidy.sh # tidy Perl code in HEAD
#   git rebase -i $sha --exec ./rebase_tidy.sh # tidy during a rebase
#
# tidying during a rebase *may* cause conflicts, and if so you need to
# walk the tree *backwards* to how rebase normally works. to do that
# ensure you are up to date with main:
#
#   git rebase main
#
# then:
#
#   for sha in $(git log --oneline ...main | awk '{print $1}');
#      do
#          git rebase -i $sha^1 -X theirs --exec ../rebase_tidy.sh || break;
#   done
#

# determine the commit currently being applied - rebase should
# set $GIT_COMMIT otherwise we need to figure it out
sha="${GIT_COMMIT:-$(git rev-parse HEAD)}"

# files changed in the commit are...
files=$(git diff-tree --no-commit-id --name-only -r "$sha")

# exit early if no files
[ -z "$files" ] && exit 0

tidy() {
    echo "Running perltidy on changed files in $sha"

    for source_file in $files
    do
        if [ -e $source_file ]; then
            has_perl=$( file -b -n $source_file | grep -c 'Perl' );
            if [ $has_perl -eq "1" ]; then
                perltidy $source_file;
                mv $source_file.tdy $source_file;
            fi
        fi
    done
}

# run perltidy
tidy

git add .
git commit --amend --no-edit
