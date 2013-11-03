#!/bin/bash

# download the trending repos from github then
# show the mean commit message size

temp_dir=/tmp
github_url="https://github.com"
trending_url="/trending?since="
trending_class="repository-name"
path=$(pwd)
commit_measurer="git-mean-commit-message-bytes"
how_many_commits=200

if [ "$1" == "" ]; then
	trending_since="monthly"
else
	trending_since=$1
fi

for repo in $(\
	curl "$github_url$trending_url$trending_since" 2>/dev/null \
	| grep $trending_class \
	| awk -F'"' "{ print \$2 }"
); do
	cd $temp_dir;
	git clone $github_url$repo.git &>/dev/null;
	dirs=(${repo//\// });
	cd_to=${dirs[${#dirs[@]} - 1]}
	cd $cd_to;
	git pull &>/dev/null;
	bytes=$($path/$commit_measurer $how_many_commits | grep '>ALL')
	echo $repo ---$bytes
done;
