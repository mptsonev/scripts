if ! git status | grep -q "nothing to commit"
then
	echo "Working directory not clean, check git status before cherry-picking:"
	git status
	exit 0
fi

git pull --rebase

rel_branch=$1

if [[ $# -eq 0 ]] ; then
    rel_branch=$(git for-each-ref --sort='-authordate' --format='%(refname:short)' | grep REL | head -1 | cut -d "/" -f 2)
    echo "No release branch specified, inferring last known branch: $rel_branch"
fi

if [[ $rel_branch != *"REL."* ]]; then
  echo \"$rel_branch\" "Not valid release branch, e.g. REL.24.1"
  exit 0
fi


if ! git branch -r | grep -q $rel_branch
then
	echo "Branch" $rel_branch "not recognised"
	exit 0
fi

git checkout origin/$rel_branch
last_commit_id=$(git log -1 --author=krasimir | grep commit | cut -d " " -f 2)
echo "Porting $last_commit_id"
git checkout master
git cherry-pick $last_commit_id
git push