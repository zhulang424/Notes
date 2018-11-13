# 常用命令

## 查看当前目录

```shell
pwd
```

## 安装软件

```shell
sudo apt-get install <soft>
```

## 用编辑器打开

```shell
vim <fileName>
```

## 新建文件夹

```shell
mkdir <dirName>
```

## 新建文件

```shell
touch <fileName>
```

## 编辑文件

```shell
vi <fileName>
vim <fileName>
```

# 修改命令行前缀

```shell
$ sudo vim /etc/bashrc
```

修改 PS1 变量（将原来的注释掉）

```shell
# PS1='\h:\W \u\$ '
PS1='[\A] \w $'

# \A: 以24小时制, HH:MM 的格式显示当前时间
# \w: 显示 current working directory
# \h表示本地主机名 
# \u表示用户名 
# $表示符号$ 
```



