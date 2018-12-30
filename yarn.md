# 从 npm 迁移

- 删除`package-lock.json`
- 删除`node_modules`文件夹
- 执行`yarn`

# 安装

```shell
brew install yarn
```

# 升级

```shell
brew upgrade yarn
```

# 初始化新项目

```shell
yarn init		# 创建 package.json
```

# 添加依赖

```shell
yarn add [package]			# npm install --save	安装到 dependencies
yarn add --dev [package]	# npm install --save-dev	安装到 devDependencies
yarn add [package]@version
```

# 升级依赖

```shell
yarn upgrade [package]
yarn upgrade [package]@version
yarn upgrade	# rm -rf node_modules && npm install
```

# 移除依赖

```shell
yarn remove [package]
```

# 安装全部依赖

```shell
yarn / yarn install		# npm install
yarn install --force	# npm rebuild 强制重新下载所有包
```

# 运行脚本

```shell
yarn run [script]
yarn run	# 列出所有可执行脚本
yarn run env	# 列出所有可用环境变量
```

# 查看安装的包

```shell
yarn list
yarn list --depth=0
```

# 检查过时的依赖

```shell
yarn outdated
yarn outdated [package]
```

# 更新过时依赖

```shell
yarn upgrade-interactive
yarn upgrade-interactive --latest
```



# 全局使用

```shell
yarn global list
yarn global add [package]
yarn global upgrade [package]
yarn global remove [package]
```

# 管理缓存

```shell
yarn cache --list	# 列出所有缓存的包
yarn cache --pattern [pattern]		# 列出指定正则匹配的包
yarn cache dir	# 打印 yarn 的全局缓存位置
yarn cache clean	# 清除全局缓存，下次运行 yarn 时补充
```

# 验证依赖

```shell
yarn check		# 验证 package.json 与 yarn.lock 是否匹配
```

# 管理配置

```shell
yarn config list	# 查看 yarn 配置
yarn config set [key] [value]	# 修改配置项 key 为 value
yarn config get [key]	# 查看配置项 key
yarn config delete [key]	# 删除配置项 key
```

# 高级用法

```shell
yarn import		# 根据 node_modules 生成 yarn.lock
```



# 使用方法

```shell
yarn check
yarn 
yarn run serve
```

