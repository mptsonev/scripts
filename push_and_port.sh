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

git pull --rebase
git push
git checkout origin/$rel_branch
git cherry-pick master
git push origin HEAD:$rel_branch
git checkout master
