# 安装Node.js + npm

去Node.js 官网下载 pkg，并安装

# 使用

## 安装模块

```shell
npm install <moduleName>	// 开发环境的依赖
npm install --save <moduleName>		// 生产环境的依赖
npm install -g <moduleName>			// 全局模块
```

## 查看模块

```shell
npm list	// 查看模块
npm list -global	// 查看全局模块
npm list --depth=0 -global	// 查看全局一级模块，在/usr/local/lib/node_modules目录下，可以直接去目录删除
```

## 删除模块

```shell
npm uninstall <moduleName>
npm uninstall -g <moduleName>
```

## 使用淘宝镜像源

``` shell
npm install -g nrm	// 安装nrm
nrm ls				// 查看源列表
nrm use taobao		// 使用淘宝镜像
```

