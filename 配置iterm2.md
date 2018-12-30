![](https://ws2.sinaimg.cn/large/006tNbRwly1fyo56koutej31c00u0qv9.jpg)

# 设置窗口打开关闭快捷键

![](https://ws1.sinaimg.cn/large/006tNbRwly1fyo4jelgc7j31h80t611s.jpg)

# 设置打开时窗口位置

![](https://ws2.sinaimg.cn/large/006tNbRwly1fyo4qfbomyj31810u07d6.jpg)
![](https://ws3.sinaimg.cn/large/006tNbRwly1fyo4qf3ou7j31fa0sijys.jpg)

# 设置窗口透明度

![](https://ws4.sinaimg.cn/large/006tNbRwly1fyo4rf69moj31f40sg7bh.jpg)



# 设置配色方案

- 下载[solarized](http://ethanschoonover.com/solarized)，并解压
- 导入配色方案

![](https://ws4.sinaimg.cn/large/006tNbRwly1fyo4nlwp1qj316n0u01ap.jpg)

# 安装 oh-my-zsh

[oh-my-zsh](https://github.com/robbyrussell/oh-my-zsh)

# 配置主题

```shell
vi ~/.zshrc
```

- 将zsh主题修改为“agnoster”：`ZSH_THEME="agnoster"` 
- 下载所需字体： [Meslo](https://github.com/powerline/fonts/blob/master/Meslo%20Slashed/Meslo%20LG%20M%20Regular%20for%20Powerline.ttf) ，点击`view raw`
- 安装字体到系统字体册
- 在`iterm2`中选择该字体

![](https://ws4.sinaimg.cn/large/006tNbRwly1fyo4xtpmcxj31c80u0tgl.jpg)

# 配置自动提示与命令补全

下载自动补全插件

```shell
git clone git://github.com/zsh-users/zsh-autosuggestions $ZSH_CUSTOM/plugins/zsh-autosuggestions
```

修改`.zshrc`：将`plugin=(git)`改为`plugins=(zsh-autosuggestions git)`

```shell
vim .zshrc
```

修改补全字体颜色：`ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=10'`

```shell
vim ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
```

# 配置语法高亮

安装 zsh-syntax-highlighting 插件

```shell
brew install zsh-syntax-highlighting
```

修改`.zshrc`：在最后一行插入`source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh`

```shell
vim .zshrc
```

重新加载`.zshrc`

```shell
source ~/.zshrc
```

# 扩展

1. iTerm2 默认使用dash改用zsh解决方法：`chsh -s /bin/zsh`
2. iTerm2 zsh切换回原来的dash：`chsh -s /bin/bash`
3. 卸载`oh my zsh`，在命令行输入：`uninstall_oh_my_zsh`
4. 路径前缀的XX@XX太长，缩短问题：

编辑`~/.oh-my-zsh/themes/agnoster.zsh-theme`主体文件，将里面的`build_prompt`下的`prompt_context`字段在前面加`#`注释掉即可