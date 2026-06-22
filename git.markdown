---

layout: home
title: Git
permalink: /git/
nav_order: 3

---
# [**1. Git**](downloads/git.pdf)

<hr style="height: 3px; background-color: black; border: none;"><br>

## **Git Repository**
Git uses sub-directory .git to store the repository 
Inside .git there are:
- **Objects**
    - **Blobs** are files
        - no file names, permissions, links, etc.
    - **Trees** are list of files: directory
        - model the file system
        - this is where: file names, permissions, links, etc. live
        - trees can also point to other trees to store subdirectories
    - **Commits** are snapshots in time
        - represents the state of the working directory at a particular time
        - has a list of parent commits
        - stores meta info: author, committer, message, etc.
        - points to a tree that represents the file structure at the time of the commit
- **Refs** are pointers
    - **Branches**
        - branches provide dynamic pointers to the commits we care about
        - contain hex strings referencing the Object ID of a commit
    - **Tags** are static heads, always point to same location
        - tags provide static pointers to historic commits
        - contain hex strings referencing the Object ID of a commit

### **Inside a Git Repository**
![insideGitRepository](images/insideGit.png)
After some commits:
![afterCommits](images/afterCommits.png)

- HEAD: special file points to current ref, usually a branch, can be specific commit
- refs: simply pters to commits 
- objects: each obj is 20 byte SHA1 hash of object contents- stored 40 char hex string
    - stored compressed so can't read directly

### **Git Commands inside Repository**
![commandsForList](images/moreCommands.png)

```shell
# list all objects, types, sizes & list all objects and names are joined
join <(git cat-file --batch-all-objects --batch-check | sort) <(git rev-list --all --objects | sort) | column -t

join <(git cat-file --batch-all-objects --batch-check | sort) <(git rev-list --all --objects | sort) | grep 'blob' | cut -d' ' -f4 | sort | uniq -c | sort -n

cat .git/HEAD
```

<hr style="height: 3px; background-color: black; border: none;"><br>

## **Git Commands**
- The BIG 7:
    - `git init [<name>]` or `git clone <URI>`
    - `git status`
    - `git add <file>`...
    - `git commit [-m "<message>"]`
    - `git pull`
    - `git push`
- The others:
    - `git branch <branch>`
    - `git checkout <branch>`
    - `git fetch`
    - `git log`
    - `git stash`
    - `git cherry-pick`
    - `git bisect`
    - `git blame`
    - `git ls-files`

## **Other commands**
- cmp: compare two files byte by byte
- stat: display file status
    - `stat -c %s colours.csv` gets file size
- cat -A: can look at invisible chars
- pigz: compresses files
- md5sum, sha1sum, ...: hashing algs