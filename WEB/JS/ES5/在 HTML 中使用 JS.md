# 如何使用

通过<script>，嵌入 JS 代码或引入外部 JS 文件

```html
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <meta http-equiv="X-UA-Compatible" content="ie=edge">
</head>
<body>
</body>
<script>
  // 嵌入 JS 代码
</script>
<script src="./xxx.js"></script>	// 引入外部 JS 文件
</html>
```

# <script>标签特性

`type`：可选，默认是 `text/javascript`

`src`：可选，用于引入外部 JS 文件。**可跨域**（引入来自外部域的 JS 文件，或发送跨域请求）

`async`（异步加载）：可选，用于引入外部文件的情况

- 在解析文档的同时，下载 JS 文件，下载完立即执行。
- 如果有多个异步加载的文件，不能保证执行顺序，先下载完的先执行。
- 在执行期间，文档解析停止。

`defer`（延迟加载）：可选，用于引入外部文件的情况

- 在解析文档的同时，下载 JS 文件
- `defer`脚本会在文档渲染完毕后，`DOMContentLoaded`事件调用前执行。
- 如果有多个延迟加载的文件，能保证按照顺序执行

> `DOMContentLoaded`（IE9+）
>
> 当初始的 **HTML** 文档被解析和完全加载完成之后，`DOMContentLoaded`事件在文档根元素（`document`）上触发，而无需等待外部资源(CSS文件、图像、JS 文件)加载完成。
>
> ```
> <script>
>   document.addEventListener("DOMContentLoaded", function(event) {
>       console.log("DOM fully loaded and parsed");
>   });
>   // 这个脚本执行完，才会触发 DOMContentLoaded
> </script>
> 
> ```

> `load`
>
> HTML 文档解析和加载完成，并且所有外部资源都加载完成后，在`window`对象上触发`load`。
>
> ```
> <script>
>   window.addEventListener("load", function(event) {
>     console.log("All resources finished loading!");
>   });
> </script>
> ```

# 使用方式

下载和执行脚本是阻塞操作，文档解析和渲染会停止。所以<script>比较合理的使用方式有两种：

- 在<body>底部，放置<script>。保证文档解析完，再下载和执行脚本
- 在<script>中，添加‘defer’或'async'关键字，在解析文档的同时，下载脚本
  - 如果脚本代码依赖于 DOM，或其他脚本，使用`defer`
  - 如果脚本代码不依赖与 DOM，或其他脚本，使用`async`

