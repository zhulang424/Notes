merge 和 rebase 的区别？

merge 是合并分支，rebase 是在另一个分支上，重新应用当前分支的提交历史

# GIT 简介

## GIT 是什么

GIT 是一个版本控制系统，保存了文本文件每次**修改后的快照**



## 安装 GIT

### MAC

安装 Xcode，Xcode集成了Git，不过默认没有安装，你需要运行Xcode，选择菜单“Xcode”->“Preferences”，在弹出窗口中找到“Downloads”，选择“Command Line Tools”，点“Install”就可以完成安装了。

### WINDOWS

在Windows上使用Git，可以从Git官网直接下载安装程序，然后按默认选项安装即可。

安装完成后，在开始菜单里找到“Git”->“Git Bash”，蹦出一个类似命令行窗口的东西，就说明Git安装成功！



## GIT 原理

- 工作区：一个本地目录
- 版本库（.git）
  - 暂存区（stage）：文件修改后，通过 `git add`命令，将修改后的快照添加到暂存区，用于未来`commit`
  - 分支：
  - `HEAD`：当前版本



## 工作流程

- 创建 GIT 仓库：`git init`、`git clone`
- 修改文件
- 将修改添加到暂存区：`git add`

![](https://cdn.liaoxuefeng.com/cdn/files/attachments/001384907720458e56751df1c474485b697575073c40ae9000/0)

- 多次修改，多次`git add`（每次修改后，必须`git add`保存到暂存区）
- 将暂存区的内容提交到本地仓库，暂存区清空：`git commit`（`commit`的时候，只提交暂存区的内容，未添加到暂存区的修改不会被提交）

![](https://cdn.liaoxuefeng.com/cdn/files/attachments/0013849077337835a877df2d26742b88dd7f56a6ace3ecf000/0)



# GIT 命令

## 创建 GIT 仓库

- 在当前目录中，创建本地仓库：`git init`
- 在当前目录中，从远程仓库克隆出一个本地仓库：`git clone <repository>`

```shell
$ git init
Initialized empty Git repository in /Users/michael/learngit/.git/
```



## 关联远程仓库

在本地仓库下运行命令：`git remote add <remoteName> <repository>`

```shell
$ git remote add origin git@github.com:michaelliao/learngit.git
// 一般远程仓库名称都设置成 'origin'
```



## 创建+切换到本地分支

`git checkout -b "<branch>"`

## 删除本地分支

`git branch-d <branch>`，该命令在被删除分支存在没有合并到当前分支的内容是，会报错，要强制删除的话，使用`git branch -D <branch>`

## 查看 GIT 仓库状态

`git status`

```shell
$ git status
On branch master
Changes not staged for commit:
  (use "git add <file>..." to update what will be committed)	
  (use "git checkout -- <file>..." to discard changes in working directory)

    modified:   readme.txt

no changes added to commit (use "git add" and/or "git commit -a")

// git add <file>	将修改添加到暂存区
// git checkout -- <file>	 放弃修改
```

## 查看改动

- 比较工作区和暂存区：`git diff`
- 比较暂存区和本地仓库：`git diff --cached`
- 比较工作区和本地仓库：`git diff HEAD`



## 将修改添加到暂存区

`git add xxx`

```shell
$ git add readme.txt	// 正常情况下，没有任何提示
```



## 取消修改

### 取消工作区的修改

`git checkout -- <file>`

> 命令`git checkout -- readme.txt`意思就是，把`readme.txt`文件在工作区的修改全部撤销，这里有两种情况：
>
> - `readme.txt`自修改后还没有被放到暂存区，现在，撤销修改就回到和版本库一模一样的状态；
> - `readme.txt`已经添加到暂存区后，又作了修改，现在，撤销修改就回到添加到暂存区后的状态。
>
> 总之，就是让这个文件回到最近一次`git commit`或`git add`时的状态。

> 如果没有`--`，就变成了切换分支的命令

### 取消暂存区的修改

- 将暂存区的修改撤销，放回工作区：`git reset HEAD <file>`
- 将工作区的修改撤销，回到最近一个版本：`git checkout -- <file>`

```shell
$ git reset HEAD readme.txt
Unstaged changes after reset:
M    readme.txt
```

```shell
$ git checkout -- readme.txt
```

### 取消某次提交

- 只提交到本地分支：版本回退
- 推送到了远程分支：



## 删除文件

### 将文件从工作区移除，同时从版本库移除

- 首先删除文件：`rm <file>`
- 查看版本库状态：`git status`
- 将文件从版本库移除：`git rm <file>` / `git add <file>`
- 提交修改：`git commit -m <descritpion>`

```shell
$ rm test.txt

$ git status
On branch master
Changes not staged for commit:
  (use "git add/rm <file>..." to update what will be committed)
  (use "git checkout -- <file>..." to discard changes in working directory)

    deleted:    test.txt

no changes added to commit (use "git add" and/or "git commit -a")

$ git rm test.txt
rm 'test.txt'

$ git commit -m "remove test.txt"
[master d46f35e] remove test.txt
 1 file changed, 1 deletion(-)
 delete mode 100644 test.txt
```

### 只将文件从版本库移除，仍保留在工作区

- `git rm <file>` / 将文件名添加到 `.gitignore`文件中
- 提交修改：`git commit -m <description>`

### 删错了

- 取消工作区修改：`git checkout -- <file>`









## 文件对比

### 查看某个文件的修改内容

`git diff <file>`

```shell
$ git diff readme.txt 
diff --git a/readme.txt b/readme.txt
index 46d49bf..9247db6 100644
--- a/readme.txt
+++ b/readme.txt
@@ -1,2 +1,2 @@
-Git is a version control system.
+Git is a distributed version control system.
 Git is free software.
```

### 查看工作区和版本库最新版本的区别

``git diff HEAD -- [文件名]`



## 提交到本地分支

`git commit -m 'description'`

```shell
$ git commit -m "add distributed"
[master e475afc] add distributed
 1 file changed, 1 insertion(+), 1 deletion(-)
 
 // master 表示将暂存区内容提交到 master 分支
```



## 查看提交历史

`git log`、`git log --pretty=online`

```shell
$ git log
commit 1094adb7b9b3807259d8cb349e7df1d4d6477073 (HEAD -> master)
Author: Michael Liao <askxuefeng@gmail.com>
Date:   Fri May 18 21:06:15 2018 +0800

    append GPL

commit e475afc93c209a690c39c13a46716e8fa000c366
Author: Michael Liao <askxuefeng@gmail.com>
Date:   Fri May 18 21:03:36 2018 +0800

    add distributed

commit eaadf4e385e865d25c48e7ca9c8395c3f7dfaef0
Author: Michael Liao <askxuefeng@gmail.com>
Date:   Fri May 18 20:59:18 2018 +0800

    wrote a readme file

// HEAD 指向当前分支，当前分支指向最新提交
// master 表示当前所在分支
```

```shell
$ git log --pretty=oneline
1094adb7b9b3807259d8cb349e7df1d4d6477073 (HEAD -> master) append GPL
e475afc93c209a690c39c13a46716e8fa000c366 add distributed
eaadf4e385e865d25c48e7ca9c8395c3f7dfaef0 wrote a readme file
```



## 推送到远程分支

将本地分支的内容推送到远程分支（远程分支不存在时创建远程分支）：

- 第一次推送：`$ git push -u <remote> <local-branch>:<remote-branch>`
- 非第一次推送：`$ git push <remote> <local-branch>:<remote-branch>`

```shell
$ git push -u origin master
Counting objects: 20, done.
Delta compression using up to 4 threads.
Compressing objects: 100% (15/15), done.
Writing objects: 100% (20/20), 1.64 KiB | 560.00 KiB/s, done.
Total 20 (delta 5), reused 0 (delta 0)
remote: Resolving deltas: 100% (5/5), done.
To github.com:michaelliao/learngit.git
 * [new branch]      master -> master
Branch 'master' set up to track remote branch 'master' from 'origin'.

// `-u` 将本地分支 master 与远程分支 master 进行关联
```

将本地分支推送到远程

## 查看命令历史

`git reflog`

```shell
$ git reflog
e475afc HEAD@{1}: reset: moving to HEAD^
1094adb (HEAD -> master) HEAD@{2}: commit: append GPL
e475afc HEAD@{3}: commit: add distributed
eaadf4e HEAD@{4}: commit (initial): wrote a readme file
```



## 版本回退

`git reset --hard [commit id]`

`git reset --hard HEAD^`

```shell
$ git reset --hard HEAD^
HEAD is now at e475afc add distributed
```

```shell
$ git reset --hard 1094a
HEAD is now at 83b0afe append GPL
```



# GIT 使用

## 创建仓库

### 先创建远程仓库，然后克隆到本地

- 创建远程仓库
- 在本地目录中，`git clone <repository>`

### 先创建本地仓库，然后与远程仓库关联

- 在本地某个目录中，创建本地仓库：`git init`
- 创建远程仓库
- 将本地仓库与远程仓库关联：`git remote add <remoteName> <repository>`



## fork后的仓库如何与原仓库同步

第一次

- 进入从fork仓库clone下来的目录中
- 在本地添加远程目录（原仓库）`git remote add <repo-name> <repo-address>`
- 查看远程目录：`git remote -v`
- 抓取原仓库的版本：`git fetch <remote-name>`
- 切换到master分支（本地分支，基于fork仓库的master分支）：`git checkout master`
- 合并原仓库的master分支：`git merge <remote-name>/master`
- 将本地master分支推送到fork仓库的master分支：`git push`

之后

`git pull <remote-name> master`

![20180614163016948.png](https://i.loli.net/2018/07/31/5b6066147d0f3.png)

## 管理分支

### 分支简介

分支就像平行宇宙，分支之间互相不干扰

`HEAD`指向当前分支，当前分支指向最新提交

![](https://cdn.liaoxuefeng.com/cdn/files/attachments/0013849087937492135fbf4bbd24dfcbc18349a8a59d36d000/0)







## 正常使用

- 修改文件

- 查看仓库状态：`git status` 
- 将修改添加到暂存区：`git add .`  / `git add <file>`
-  将暂存区内容提交到本地分支：`git commit -m 'description'`



## 版本回退

### 回退原理

让`HEAD`指针指向某个之前的版本

> Git在内部有个指向当前版本的`HEAD`指针，当你回退版本的时候，Git仅仅是把HEAD从前一个版本，指向了后面某个版本
>
> ![](https://cdn.liaoxuefeng.com/cdn/files/attachments/001384907584977fc9d4b96c99f4b5f8e448fbd8589d0b2000/0)
>
> 
>
> ![](https://cdn.liaoxuefeng.com/cdn/files/attachments/001384907594057a873c79f14184b45a1a66b1509f90b7a000/0)

### 回退准备

GIT 要知道目标版本的 `commit id`

- 用`HEAD`指定前多少个版本
  - 当前版本，`HEAD`表示当前版本
  - `HEAD^`表示上个版本
  - `HEAD^^`表示上上个版本
  - `HEAD~100`表示前100个版本
- 直接使用某个版本的`commit id`
  - 通过`git log`查看提交历史，获得`commit id`
  - 通过`git reflog`查看命令历史，获得`commit id`

```shell
$ git log
commit 1094adb7b9b3807259d8cb349e7df1d4d6477073 (HEAD -> master)
Author: Michael Liao <askxuefeng@gmail.com>
Date:   Fri May 18 21:06:15 2018 +0800

    append GPL

commit e475afc93c209a690c39c13a46716e8fa000c366
Author: Michael Liao <askxuefeng@gmail.com>
Date:   Fri May 18 21:03:36 2018 +0800

    add distributed

commit eaadf4e385e865d25c48e7ca9c8395c3f7dfaef0
Author: Michael Liao <askxuefeng@gmail.com>
Date:   Fri May 18 20:59:18 2018 +0800

    wrote a readme file

// HEAD 表示当前版本
// master 表示当前所在分支
```

```shell
$ git reflog
e475afc HEAD@{1}: reset: moving to HEAD^
1094adb (HEAD -> master) HEAD@{2}: commit: append GPL
e475afc HEAD@{3}: commit: add distributed
eaadf4e HEAD@{4}: commit (initial): wrote a readme file
```

### 开始回退

#### 回退到某个版本

`git reset --hard [commit id]`  / `git reset --hard HEAD^`

```
$ git reset --hard HEAD^
HEAD is now at e475afc add distributed
```

```bash
$ git reset --hard 1094a
HEAD is now at 83b0afe append GPL
```

#### 回退之后，再回到原来的新版本

**必须要找到原来版本的 `commit id`**

- 命令行窗口没关掉：往上翻，找到原来版本的`commit id`，然后`git reset --hard [commit id]`
- 命令行窗口关掉了，使用`git reflog`查看命令历史，找到 `commit id`，然后`git reset --hard [commit id]`

```shell
$ git reflog
e475afc HEAD@{1}: reset: moving to HEAD^
1094adb (HEAD -> master) HEAD@{2}: commit: append GPL
e475afc HEAD@{3}: commit: add distributed
eaadf4e HEAD@{4}: commit (initial): wrote a readme file
```

# GIT 杂症

Windos环境下，`git add <file>`的时候报错，提示`warning: LF will be replaced by CRLF in package.json. The file will have its`

问题原因：不同系统下，行尾结束符（line ending）不同：Windows是`CRLF`（回车换行），Linux是`LF`（换行）。文件在Windows环境下编辑，而在`git bash`中，是Linux环境，所以行尾结束符不同。而 GIT 有一个设置项`core.autocrlf`负责处理行尾结束符，这个设置项默认是true，进行行尾结束符的替换，所以 GIT 会报错，提示行尾结束符会发生变化

解决方法：`git config --global core.autocrlf false`，不转换line endings，保持文本原来的样子

