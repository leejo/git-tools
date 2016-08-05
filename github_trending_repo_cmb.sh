#!/bin/bash

#set -x
set -e
set -u 

# download the trending repos from github then
# show the mean commit message size

temp_dir=/tmp
github_url="https://github.com"
trending_url="/trending?since="
trending_class="repo-list-name"
commit_measurer=$(dirname "$0")"/git-mean-commit-message-bytes"
how_many_commits=200
trending_since="monthly"

echo $commit_measurer;
exit;

for repo in $(\
	curl "$github_url$trending_url$trending_since" 2>/dev/null \
	| grep -A1 $trending_class \
	| grep href \
	| awk -F'"' "{ print \$2 }"
); do
	cd $temp_dir;
	dirs=(${repo//\// });
	cd_to=${dirs[${#dirs[@]} - 1]}
	if [ ! -e $cd_to ]; then
		git clone $github_url$repo.git &>/dev/null;
	fi
	cd $cd_to;
	git pull &>/dev/null;
	bytes=$($commit_measurer $how_many_commits | grep '>ALL')
	echo $repo ---$bytes
done;
