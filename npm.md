# 安装Node.js + npm

去Node.js 官网下载 pkg，并安装

# 安装模块

```shell
npm install <moduleName>	// 开发环境的依赖
npm install --save <moduleName>		// 生产环境的依赖
npm install -g <moduleName>			// 全局模块
```

# 查看模块

```shell
npm list	// 查看模块
npm list -global	// 查看全局模块
npm list --depth=0 -global	// 查看全局一级模块，在/usr/local/lib/node_modules目录下，可以直接去目录删除
```

# 删除模块

```shell
npm uninstall <moduleName>
npm uninstall -g <moduleName>
```

# 使用淘宝镜像源

``` shell
npm install -g nrm	// 安装nrm
nrm ls				// 查看源列表
nrm use taobao		// 使用淘宝镜像
```

# 使用N管理Node版本

```shell
sudo npm cache clean -f // 清除npm缓存

sudo npm i -g n		// 安装 n 模块
n					// 切换node版本
n stable			// 安装最新稳定版本node
n latest 			// 安装最新版node
n lts				// 安装最新LTS版本node
n rm x.x.x			// 删除指定版本node
n prune				// 删除除当前版本外所有版本node
```

