# 概述

IOS8发布的新 WEB 视图，用于替换 UIWebView，解决了 UIWebView 内存占用大和加载速度慢的问题

# 功能

- 显示 HTML
- 解析 CSS
- 执行 JavaScript

# 使用 Web 构建界面的优势

- 提供丰富的界面布局
- 显示多行不同风格的文本
- 显示图片
- 播放音频、视频

# 使用（只能纯代码使用）

## 加载本地 HTML 代码

采用同步方式，数据来源于本地文件或硬编码的 HTML 字符串

```objective-c
- loadHTMLString:baseURL: 
// 设定主页文件的基本路径，通过 HTML 字符串加载主页数据
```

```objective-c
- loadData:MIMEType:characterEncodingName:baseURL:
// 指定 MIME 类型、编码集、NSData 对象，加载一个主页数据，并设定主页文件的基本路径
```

**注：如果加载 HTML 字符串，```baseURL```为 ```nil```。如果加载本地 HTML文件，```baseURL```为存放 HTML 文件的目录。**

>baseURL是HTML字符串中引用到资源的查找路径，相当于HTML的<base>标签的作用，定义页面中所有链接的默认地址。
>
>当HTML中没有引用外部资源时，可以指定为nil。
>
>若引用了外部资源（除了html代码以外，界面中所有的图片，链接都属于外部资源），一般情况下使用mainBundle的路径即可。
>
>在实际操作中，常常会出现「文本显示正常，图片无法显示」等情况，若HTML文本中引用外部资源都是使用相对路径，则出现这种问题的原因一般都是baseURL参数错误

## 加载网络资源

采用异步加载方式

```objective-c
- loadRequest:
// 设定 NSURLRequest 对象，该对象在构建时遵守某种协议(协议名称不可省略)
// 例如：
// HTTP 协议：http://www.sina.com.cn
// 文件传输协议：file://localhost/Users/.../index.html
```

## 委托

- WKNavigationDelegate：加载过程方法

```objective-c
// 开始加载时调用
-(void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation  
  
// 当内容开始返回时调用
-(void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation 
  
// 加载完成之后调用
-(void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation 

// 加载失败时调用
-(void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error 
```

- WKUIDelegate：界面显示方法