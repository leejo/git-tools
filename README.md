# git-tools

These used to be in my code repo (now private) so have moved them here for
access by those who might want to use/contribute

## all_status

show all status of repos in ~/working

## git-dir-blame

like blame but for a directory (since git doesn't track dirs)

## git-loc

totals for author additions/removals

## git-mean-commit-message-bytes

show the mean commit message length for each author

## git-publish-branch

easy publish/revoke of branches to the remote

## git-tidy-up

run remote prune origin, gc, and fsck

## git-wtf

show state of branches: merged, not merged, local, remote

## github_trending_repo_cmb.sh

grabs the trending repos from github and then runs prints out the mean commit
bytes for each, so you can see how poor most people's commit messages are

## reveal_gh-pages

exports a markdown reveal.js presentation to a static ("static") site and
creates a gh-pages branch for easy upload to github pages

## timesheet

shows you work done in ~/working for past day (default) or weekend (pass "we")
or week (pass "week")

## vimrc_split_commit_message_with_diff

a little bit of vim config that will split the diff of what you are
committing with the commit message in your editor (vim, obviously) so
you can remind yourself of the change(s) to write a better commit message
