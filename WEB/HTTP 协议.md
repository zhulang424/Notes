# HTTP是什么

HTTP，超文本传输协议，是客户端和服务端之间的通信规则

HTTP 是一个应用层协议，由请求和响应构成

HTTP 默认端口号80

# HTTP 特点

**简单快速**

> HTTP 协议简单，浏览器向服务器发送请求时，只需要发送请求方法和路径，传输速度快

**灵活**

> HTTP 协议允许传输任意类型数据，由 content-type 标注

**无状态**

> HTTP 协议对于事务处理没有记忆能力

**无连接、持久连接**

> HTTP 0.9、1.0 使用非持久连接，每次发送请求打开一个新连接，服务器响应后，连接断开
>
> HTTP 1.1 使用持久连接，连接持续有效，服务器响应后，连接不断开，避免重新建立连接

# HTTP 工作流程

- 浏览器与服务器建立连接
- 发送请求
- 响应
- 断开连接

# HTTP 报文组成

## **请求报文**

**请求行**

> - 请求方法
> - 请求地址（URL）
> - HTTP 协议版本

**请求头部**

> 一堆 key-value，常见的有 cookie，origin、cache-control等

**空行**

> 用来分割请求头部和请求体

**请求体**

> POST 请求携带的参数

## **响应报文**

**状态行**

> - HTTP 协议版本
> - 状态码
> - 状态消息

**响应头**

> 一堆键值对，常见的有：access-control-allow-origin、set-cookie、e-tag、last-modified

**空行**

**响应体**

> 服务器返回的信息

# 请求方法

- GET：请求数据
- POST：发送数据



- HEAD：获取报头
- PUT：更新数据
- DELETE：删除资源

# GET 和 POST 区别

- GET 请求参数放在 URL 中，POST 请求参数放在请求体中
  - URL 有长度限制，所以 GET 请求参数有长度限制
  - GET 请求数据参数会保留在浏览器历史记录中，POST 请求不会
  - GET 请求参数是明文
- GET 在浏览器回退时是安全的，POST 在回退时会再次提交请求
- GET 请求会被浏览器缓存，POST 请求不会，除非手动设置

# 状态码

- 1xx：指示信息--表示请求已接收，继续处理
- 2xx：成功--表示请求已被成功接收、理解、接受
- 3xx：重定向--要完成请求必须进行更进一步的操作
- 4xx：客户端错误--请求有语法错误或请求无法实现
- 5xx：服务器端错误--服务器未能实现合法的请求

> **常见状态码**
>
> - 200 OK：请求成功
> - 301 Moved Permanently：永久重定向
> - 302 Found：临时重定向
> - 304 Not Modified：没有发生变化，使用原来的缓存
> - 403 Forbidden：资源禁止被访问
> - 404 Not Found：资源不存在

# PUT 和 POST 区别

> PUT 是幂等的，POST 不是

什么是幂等？

一个操作，执行多次，结果是一样的，就是幂等

什么时候用 PUT，什么时候用 POST？

取决于想要达到什么结果，如果想要每次提交产生不同的结果，用 POST；如果想要每次提交产生相同的结果，后一次请求只是覆盖前一次请求，用 PUT

# 管道化

基于持久连接（HTTP 1.1），客户端打包发送多个请求一次性发送，服务端打包多个响应一次性返回

# HTTPS

在 HTTP 基础上建立 SSL 加密层，使用 SSL 证书对数据进行加密

默认端口 443

