# Git

## Add git bash helpers 'auto-completion' and 'git-prompt'

```
git clone https://github.com/git/git
cd git
git version -> git version 2.34.1
git checkout tags/v2.34.1
cd contrib/completion/
cp git-completion.bash ~./.git-completion.bash
cp git-prompt.sh ~./.git-prompt.sh
```

add the following lines to ~./.bashrc

```
source ~/.git-completion.bash
source ~/.git-prompt.sh
export GIT_PS1_SHOWDIRTYSTATE=1
export GIT_PS1_SHOWUPSTREAM="auto"
PS1='\[\e[93m\]\u\[\e[36m\]@\[\e[93m\]\h \[\e[0m\][ \[\e[32m\]\W\[\e[0m\] ]\[\e[95m\](\_\_git_ps1 " (%s)")\[\e[0m\] \$ '
```

## Set up SSH authentication with GitHub

Create an ssh key pair and copy the content of the public key to github:

- Cat out the key and copy to clipboard: `cat ~/.ssh/id_ed25519.pub`
- Paste clipboard to: https://github.com/settings/keys

## List & Set up configurations

```
git config --list --show-origin

git config --global user.name Thomas Grusz
git config --global user.email thomas.grusz@protonmail.com
git config --global core.editor vim
git config --global init.defaultBranch main
git config --global color.status auto
git config --global color.branch auto
git config --global color.interactive auto
git config --global color.diff auto
```

## Aliases

```
git config —-global alias.a 'commit -a -m'
git config —-global alias.ac ‘!git add -A && git commit -m’
git config --global alias.l='log --oneline -n 5'
git config --global alias.ll='log --oneline --all --graph'
git config --global alias.s 'status'
git config --global alias.b 'branch'
```

Alias for pruning and deleting dead upstream branches:

```
git config —-global alias.pruneupstream ‘!git remote update —prune && git branch -vv | awk “/: gone]{print $1} | xargs git branch -d’
```

## Remote repos

```
git remote
git remote -v
git remote add SHORTNAME URL
git remote remove SHORTNAME
git remote rename ORIGIN SOURCE
git remote show ORIGIN
```

When using SSH to push to github, make sure 'SSH' is the protocol defined for exchange with the remote repo.
Check with: `git remote -v`

The output should be:

```
origin git@github.com:thomasgrusz/test.git (fetch)
origin git@github.com:thomasgrusz/test.git (push)
```

not

```
origin https://github.com/thomasgrusz/test.git (fetch)
origin https://github.com/thomasgrusz/test.git (push)
```

To enable SSH pushing to GitHub set the remote like this:

```
git remote set-url origin git@github.com:thomasgrusz/test.git

    #or using the -u shortcut

git remote -u origin git@github.com:thomasgrusz/test.git
```

## Logging

```
git log
git log -2

git log -p
#add patch info

git log BRANCH
git log —-oneline --all —-graph

git log --pretty="format:%H %cn"
# custom logging with hash and committer name

git log -S “javascript”
# find commit where "javascript" was added

git reflog
# show git command history

git show
# shows blobs, trees, tags and commits
```

## Interact with remote repo

```
git clone URL
# clone a repo (only master branch)

git fetch origin master
# fetch changes from remote into local master tracking branch, but don't merge

git pull origin master
# pull changes from remote repo "origin" into local master branch

git push -u origin master
# push local commits on master to remote 'origin' and set upstream tracking (-u) - after this command, simply use "git push" or "git pull" or "git fetch"

git push origin —-delete BRANCH
# delete remote BRANCH

git push --force-with-lease
# Usually, "git push" refuses to update a remote ref that is not an ancestor of the local ref used to overwrite it. This option can override this restriction. "git push" fails otherwise. e.g. used to push a rebased master branch to a remote.
```

## Work on a local repo

```
git add .
# add all changes (new, deleted, modified) in current folder

git add -A
# add all changes (new, deleted, modified) in entire repo

# in git 2.x both '.' and '-A' stage deleted files, in git v1.x ' .' does not remove deleted files

git add -u
# stage modified and deleted files only, no new, untracked ones
```

```
git add -p
# interactively chose patches for staging
```

```
git rm file
# remove file from filesystem (!) and stage this change for commit
# this only works if file is not modified or staged, in that case use -f for force

git rm --cached file
# keep the file in the filesystem, but remove from tracking
# the changes in the working tree will be kept in the local, real filesystem
# and the file will be deleted in the remote repo

git rm --dry-run file
# use a dry run for SAFETY!

git clean
# remove files from filesystem that are not tracked (use -x to include ignored files to be removed, e.g. build products in .gitignore)
```

```
git commit -m “Message”
git commit -m "Message" --dry-run

git commit -a -m “Message”
# add modified and deleted files & commit, untracked files are not affected

git commit --amend
# change last commit message (via editor)
```

```
git diff
# compares working tree with index

git diff HEAD
# compares working tree with last commit

git diff —staged
# compares index with last commit

git diff-tree COMMIT-HASH
# display list of files added or modified in COMMIT-HASH, i.e. if only one commit is given, it is compared to its parent. with 2 commits, the comparison is between those 2 commits.

git diff --name-only HEAD HEAD~1 display list of files added or modified in last commit compared to parent commit
```

git restore file copies index to worktree (i.e. destroys current work on file)
git checkout file same as 'git restore file'

git reset file unstage a file (copy HEAD to index)
git restore --staged file unstage a file

git reset --hard file set worktree and index back to HEAD

git reset --hard origin/master delete all changes on the local master branch to match exactly what is on the remote tracking branch branch. consider running 'git fetch origin master' first.
git switch -C <branch> <starting point> If <branch> exists, move the branchpointer to <starting point>, otherwise create a new branch starting at <starting point>. This can be used to move the branch pointer to an existing commit ahead, after an unwanted hard reset (above).

---

git reset --hard HEAD~5 reset current branch's HEAD, index and working tree back five commits and ...
git merge --squash HEAD@{1} squash prior commits into a single commit.

---

git revert COMMIT-ID undo this commit with new commit
git revert HEAD undo last commit with a new commit

## Stash - shorterm saving of worktree & index

git stash [push] stash working directory and index
git stash push —keep-index stash worktree but keep index
git stash pop get stashed changes back into worktree
git stash apply same as pop, but keep stash entry
git stash drop remove last stash entry
git stash list list all stash entries
git stash branch BRANCH restore stashed work to a new branch
git stash show -p stash@{1} show details of 2nd last stash entry

## Branches

git merge BRANCH merge BRANCH into active branch
git merge —-squash BRANCH merge BRANCH into a single commit on current branch
git branch show local branches
git branch -a show local and remote tracking branches
git branch --merged show branches merged into active branch (does not work with squash-merged branches)
git branch --no-merged list unmerged branches
git branch -m new-name change name of active branch
git show-ref --head find HEAD of branches and tags

git switch BRANCH switch to BRANCH; if BRANCH is a remote one, it will be cloned locally
git switch -c BRANCH create new BRANCH and switch to it
git checkout BRANCH the same as switch
git checkout -b BRANCH the same as switch -c
git checkout -C BRANCH <start> move branch pointer of existing branch to <start>

git subtree split --prefix=dist -b publish_on_github_branch create/update new branch from one folder "dist"

## Tags

git tag list tags alphabetically
git show v1.4 show details of tag
git tag -l "v1.8.5\*" look at tags of 1.8.5 series
git tag -a v1.4 -m "my 1.4" add an annotated tag
git tag v1.4-lw create a lightweight tag (i.e. without the -a option)
git push origin TAGNAME push TAGNAME to remote
git push origin --tags push all remaining tags to remote (both lightweight and annotated)
git push origin --follow-tags push all remaining annotated tags to remote (no lightweight)
git tag -d v1.4 delete a tag delete tag
git push origin --delete TAG delete a remote tag

## Rebase

git rebase master rebase active branch on master
git rebase -i start interactive rebase and e.g. use squash to meld with previous commit, this way there is fine-grained control over which commits to squashed (cf. git merge --squashed)
git rebase -i fixup like squash, i.e. meld with previous commit, but only keeps the message of the previous commit.

git cherry-pick COMMIT-ID new commit based on the provided COMMIT-ID

## Find bad commit - bisect

git bisect start start bisect to find bad commit
git bisect bad bad commit (latest if left blank)
git bisect good 48c86d6 commit without bug —-> git grabs commit in middle, we test and if bug still there, run:
git bisect bad —-> git grabs commit in middle, we test and if bug not present run:
git bisect good REPEAT until narrowed down to the exact commit that causes the bug.

## More detailed explanations

git reset
sets the branch pointer to a commit, that HEAD also points to the "--mixed" switch is the default, leaving the working directory intact, just restoring the index the "--soft" switch leaves the working directory AND the index intact the "--hard" switch sets the working tree, index and branch pointer to HEAD or a specified commit

git checkout
sets the HEAD pointer to a commit (HEAD is the default if "git checkout" is ran without arguments, i.e. checks out a branch or creates a new branch with the "-b" switch or copies the index to the working tree if used with a path or copies HEAD to working directory AND index if used like this "git checkout HEAD -- file"

git restore file
sets the working-tree to the indexif combined with the --staged switch (-S), the index is restored from HEADif both the --staged (-S) and the --worktree (-W) switches are used there needs to be a source, i.e. --source HEAD (default) to restore both index and working-tree

## git checkout vs. git restore / git switch (git version >=2.23)

git checkout
this command can be running "safe" or "unsafe", clobbering your files, depending on the situation. newer versions of git (>= 2.23) warn from an ambiguous situation, older versions of git do not. be safe/clear and use the new "git swich" and "git restore" commands.

git restore
this is the "unsafe" part of "git checkout", checking out other commits (working tree and index)

git switch
this is the "safe" part of of "git checkout", to switch and create new branches

## Mischellaneous

git config --global rerere.enabled true
enable "reuse recorded resolution" functionality, to autosolve recurring merge conflicts. use "git rerere status" for more info on the merge conflict. run "git rerere diff" to show the current state of the resolution.

git prune
prune all unreachable objects from the object database (users should use "git gc", i.e. garbage collect, which in turn calls git prune.

man gitglosary display git terms with explanation

Stuff to check out:
git hooks and CI/CD
pre-commit hook -> tests
pre-receive hook

## Git in a nutshell

### Object types:

- blob
- commit
- tree
- tag

### blob

- smallest unit - represents file content
- each version of a file is a blob
- identified by a SHA-1 hash
- referenced by tree objects

### tree

- represents a directory in git (at one point in time)
- contains references to blobs and other trees (subdirectories)
- maps file names to SHA-1 hashes of blobs or to other subtrees

### commit

- snapshot of repository
- each commit hat metadata lik
  - author
  - message
  - timestamp
  - reference to root tree object
- commits are chronologically linked lists

### Tag

- tags are references to specific commits
- human readable marks for milestones like a release
- immutable
