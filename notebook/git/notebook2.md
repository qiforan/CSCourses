# Git的常见操作

- 合并最近两次提交为一次

```shell
# HEAD回退两次，但工作区和index不变
git reset --soft HEAD^^
# 重新提交
git commit -m "commit"
```

- 删除仓库里的文件(包括index)但工作区保留，即从仓库里移除不该提交的文件

```shell
# 不再追踪某个文件
git rm --cached <file>
# 再加入.gitignore
```

- 使用`https`与远程仓库交互时又不想每次都输入密码

```shell
# 创建文件存储第一次输入的GIT用户名和密码
git config credential.helper store
```
