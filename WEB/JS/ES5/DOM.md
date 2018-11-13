**对文档做的修改，以及对样式的修改都会立即呈现出来**

# 节点类型

## Node 类型

所有节点类型都继承自 Node 类型，所以所有节点都有 Node类型的属性和方法

### 获取节点信息

> - ```node.nodeType```
> - ```node.nodeName```
> - ```node.nodeValue```

### 节点关系

访问子节点
> - ```node.childNodes```：所有子节点（包括文本节点，实时更新），返回一个 NodeList 对象（类数组对象）
> - ```node.children```：所有元素子节点（不包括文本节点）

> - ```node.fistChild```：第一个子节点
> - ```node.lastChild```：最后一个子节点
> - ```node.firstElementChild```（IE9+）:第一个元素子节点
> - ```node.lastElementChild```（IE9+）：最后一个元素子节点

> - ```node.hasChildNodes()```：检查是否存在子节点

访问父节点

> ```node.parentNode```

访问兄弟节点

> - ```node.previousSibling```
> - ```node.nextSibling```

> - ```node.previousElementSibling```（IE9+）
> - ```node.nextElementSibling```（IE9+）

访问文档节点

> ```node.ownerDocument```：文档节点（Document 节点）（每个节点只能存在于一个文档中）

### 操作子节点

插入节点

> ```node.appendChild(anotherNode)```
> - 添加节点到 childNodes 末尾并返回，同时更新节点关系
> - 如果节点已经存在于 DOM 结构中，这个方法起到移动节点位置的作用（每个节点在 DOM 结构中只能存在一个）

> ```insertBefore()```
>
> - 插入节点到某节点之前并返回

替换节点

> ```replaceChild()```
>
> - 替换节点并返回，包括节点的关系指针（parentNode、childNodes 等）

移除节点

> ```removeChild()```
>
> - 移除节点并返回

### 操作节点本身

复制节点

> ```node.cloneNode()```
>
> - 参数：boolean（可选）
>   - 不传入参数，浅复制（只复制节点本身）
>   - 传入 true，深复制（复制节点+子节点）
> - 返回：节点副本
> - 注意：先移除事件处理程序再进行复制（因为在 IE 中，会复制节点的事件处理程序；在其他浏览器，不会复制事件处理程序）

## Document 类型

文档节点（html节点的父节点），document 对象的引用类型

浏览器中的 document 对象是 window 对象的属性，可以作为全局变量访问

只有一个子节点<html>

![](https://ws2.sinaimg.cn/large/006tNc79gy1fswojj3oi3j30sg0lcgmh.jpg)

### 访问节点

<html>

> ```document.documentElement```
>
> - ```document.childNodes[0]```
> - ```document.children[0]```
> - ```document.firstChild```
> - ```document.lastChild``` 

<body>

> ```document.body```

<title>

> ```document.title```（可读可写）

访问表单集合

> ```document.forms```
>
> - 返回 Nodelist，包含所有<form>节点

访问图片集合

> ```document.images```
>
> - 返回 Nodelist，包含所有<image>节点

访问连接集合

> ```document.links```
>
> - 返回 Nodelist，包含所有带 href 特性的<a>节点

### 访问 URL

> ```document.url```：页面完整 URL（只读）
>
> ```document.domain```：域名（可读可写，通过设置该属性，可以实现与不同子域通信）
>
> ```document.referrer```：链接到当前页面的页面的 URL（只读）

### 查找节点

> ```document.getElementById()```
> - 根据 id 特性查找某个节点，找不到返回 null
> - 如果有 id 相同的情况，只返回第一个节点
>
> ```document.getElementsByTagName() / node.getElementsByTagName()```
>
> - 查找某个标签名的所有节点，返回 NodeList
> - 传入*，返回的 NodeList 包含所有节点
> - 可以在元素节点上调用，只查询该元素节点的子节点
>
> ```document.getElementsByName()```
>
> - 根据 name 特性查找所有节点，返回 NodeList（用来查找表单节点）

> ```document.getElementsByClassName```【IE9+】
>
> - 根据类名查询，返回 NodeList

> ```document.querySelector() / node.querySelector()```【IE9+】
>
> -  CSS 查询，返回第一个匹配的节点，如果找不到，返回 Null
> - 可以在元素节点上调用，只查询该元素节点的子节点
>
> ```document.querySelectorAll() / node.querySelectorAll()```【IE9+】
>
> - CSS 查询，返回 NodeList，包含所有匹配节点，如果找不到 NodeList 是空的
> - 可以在元素节点上调用，只查询该元素节点的子节点
>
> ```javascript
> 	var body = document.querySelector('body')
>     var myDiv = document.querySelector('#myDiv')
>     var selected = document.querySelector('.selected')
>     var img = document.body.querySelector('img.button') // 在元素节点上调用，只查询其后代节点
> ```

### 创建节点

创建元素节点

> ```document.createElement(elementName)```

创建文本节点

> ```document.createTextNode(text)```

创建文档片段

> ```document.createDocumentFragment()```

```javascript
var elementNode = document.createElement('div')
var textNode = document.createTextNode('hello')
elementNode.appendChild(textNode)
document.body.appendChild(elementNode)
```

### 访问文档加载状态

> ```document.readyState```
>
> - loading
> - complete

```javascript
if(document.readyState === 'complete'){
    
}
```

### 文档写入

> - document.open()：打开输出流
> - document.write()：将传入字符串写入文档，原文档被覆盖
> - document.writeln()：在末尾添加 \n 
> - document.close()：关闭输出流

## Element 类型

元素节点

### 访问标签名

```elementNode.tagName```

### 访问特性

通过属性访问特性（一般情况下，都用该方式访问特性）

> ```elementNode.id```
>
> - 标签 id（可读可写）

> ```elementNode.className```
>
> - 类名字符串
> - 可读可写，修改后，如果关联了新样式，会立即呈现出来变化

> ```elementNode.style```
>
> - 样式对象，通过该对象的属性可以修改样式
> - 只能访问到内联样式，**无法访问到外部样式表中的样式**

> ```elementNode.onXxx```
>
> - 事件处理程序

> ```elementNode.attributes```
>
> - 返回 NodeList（类数组对象，用[]访问成员），包含所有特性

通过方法访问特性（访问自定义特性）
> - ```elementNode.getAttribute()```
> - ```elementNode.setAttribute()```：特性不存在时，创建该特性
> - ```elementNode.removeAttribute()```

### 创建元素节点

```document.createElement()```

## Text 类型

文本节点

- 文本节点是元素节点的子节点，通过 childNodes[0]或 firstChild 访问
- 文本节点的 parentNode 指向元素节点
- 每个元素节点最多只能有一个文本节点

属性

- 访问文本（字符串会被HTML 编码）
  - textNode.nodeValue
  - textNode.data

创建文本节点

document.createTextNode()

## DocumentFragment 类型

是什么？

> 文档片段，储存元素节点的容器

有什么用？

> 要插入多个元素节点时，可以使用文档片段保存节点，然后将节点统一插入文档，减少 dom 操作的次数，提升性能

> 注
>
> - 将文档片段插入文档，是将文档片段的所有子节点插入文档
> - 如果将节点添加到文档片段中，该节点会从文档中移除

创建文档片段

document.createDocumentFragment()

```javascript
	var div1 = document.createElement('div')
    var div2 = document.createElement('div')
    var div3 = document.createElement('div')

    var fragment = document.createDocumentFragment()
    fragment.appendChild(div1)
    fragment.appendChild(div2)
    fragment.appendChild(div3)

    document.body.appendChild(fragment)
```

# 查找节点

> ```document.getElementById()```
>
> - 根据 id 特性查找某个节点，找不到返回 null
> - 如果有 id 相同的情况，只返回第一个

> ```document.getElementsByTagName()```
>
> - 查找某个标签名的所有节点，返回 NodeList
> - 传入*，返回的 NodeList 包含所有节点
> - 可以在元素节点上调用，只查询该元素节点的子节点

> ```document.getElementsByName()```
>
> - 根据 name 特性查找表单节点，返回 NodeList

> ```document.getElementsByClassName()```【IE9+】
>
> - 根据类名查询，返回 NodeList

> ```document.querySelector()```【IE9+】
>
> -  CSS 查询，返回第一个匹配的节点，如果找不到，返回 Null
> - 可以在元素节点上调用，只查询该元素节点的子节点

> ```document.querySelectorAll()```【IE9+】
>
> - CSS 查询，返回 NodeList，包含所有匹配节点，如果找不到 NodeList 是空的
> - 可以在元素节点上调用，只查询该元素节点的子节点

# 访问节点

子节点

> ```node.childNodes```
>
> - 返回 NodeList，包含所有子节点（包括文本节点）

> ```node.children```
>
> - 返回 NodeList，包含所有元素子节点（忽略文本节点）

> ```node.firstChild```、```node.lastChild```
>
> - 返回首个、末个子节点（包括文本节点）

> ```node.firstElementChild```、```node.lastElementChild```
>
> - 返回首个、末个元素子节点（忽略文本节点）

父节点

> ```node.parentNode```

兄弟节点

> ```node.previousSibling```、```node.nextSibling```
>
> - 返回上一个、下一个同级节点（父节点必须一致）（包含文本节点）

> ```node.previousElementSibling```、```node.nextElementSibling```
>
> - 返回上一个、下一个同级元素节点（父节点必须一致）（忽略文本节点）

文本节点

> ```elementNode.firstChild```
>
> ```elementNode.childNodes[0]```

html 节点

> ```document.documentElement```

body 节点

> ```document.body```

title 节点

> ```document.title```

# 创建节点

创建元素节点

> ```document.createElement('nodeType')```

创建文本节点

> ```document.createTextNode('text')```

创建文档片段

> ```document.createDocumentFragment()```

```javascript
var element = document.createElement('div')
var textNode = document.createTextNode('hello')
element.appendChild(textNode)
document.body.appendChild(element)
```

# 操作节点【父元素】

插入节点

> ```elementNode.appendChild(newNode)```
>
> - 将节点插入到 childNodes 最后
> - 如果节点已经存在于文档中，则会导致节点移动

> ```elementNode.insertBefore(newNode,someNode)```
>
> - 将 newNode 插入到子节点 someNode 之前
> - 如果 someNode 是 null，执行与 ```dom.appendChild(newNode)```相同操作

删除节点

> ```elementNode.removeChild(node)```
>
> - 从子节点中移除某节点，并返回

替换节点

> ```elementNode.replaceChild(newNode,someNode)```
>
> - 使用某节点替换某个子节点，并返回
> - 同时更新节点关系

> ```elementNode.innerHTML = 'htmlString'```
>
> -  使用 html 文本替换所有子元素

> ```elementNode.outerHTML = 'htmlString'```
>
> - 使用 html 文本替换该元素+所有子元素

**替换节点之前一定要先移除节点上的事件处理程序**

> - 如果直接替换，节点和事件处理程序的内存不会被回收，造成内存泄露

复制节点

> ```node.cloneNode(boolean)```
>
> - true：深复制（复制节点以及所有子节点）
> - false：浅复制（复制节点本身）

# 判断关系

> ```node.contains(someNode)```【IE9+】

> ```node.compareDocumentPosition(someNode)```（IE9+）
>
> - 1：无关（给定节点不在当前文档中）
> - 2：在参考节点之前
> - 4：在参考节点之后
> - 8：包含
> - 16：被包含

# 比较节点

> ```node.isEqualNode(someNode)```
>
> - 相同类型，相同特性，childNodes 也相同，返回 true

# 修改内容

找到文本节点，并进行修改

> - ```elementNode.firstChild.nodeValue = 'xxx'```
> - ```elementNode.firstChild.data = 'xxx'```

innerHTML

> 使用文本节点，替换掉该元素节点所有子节点
>
> ```elementNode.innerHTML = 'xxx'```

textContent【IE9+】

> ```javascript
> let text = element.textContent;
> element.textContent = "this is some sample text";
> ```

# 访问属性

> ```node.id```、```node.className```、```node.style```、```node.onxxx```

> ```node.getAttribute('attributeName')```、```node.setAttribute('attributeName',value)```

> ```node.attributes```

# 访问样式【修改立即生效】

## 位置

> 元素在父元素中位置（```elementNode.offsetParent```）
>
> - ```elementNode.offsetLeft```
> - ```elementNode.offsetTop```

> 元素在文档中位置
>
> ```javascript
> function getElementLeft(element){
>       var result = element.offsetLeft
>       var parent = element.offsetParent
>       while(parent !== null){
>         result += parent.offsetLeft
>         parent = parent.offsetParent
>       }
>       return result
>     }
> ```

> 带滚动内容的元素，其内容的滚动位置（内容被盖住了多少）
>
> - ```element.scrollTop```
> - ```element.scrollLeft```

> 元素在视口（viewport）中位置【IE9+】
>
> ![](https://images0.cnblogs.com/blog2015/678562/201504/262132219001037.jpg)
>
> ```javascript
> let clientOffset = elementNode.getBoundingClientRect();
> clientOffset.top
> clientOffset.bottom
> clientOffset.left
> clientOffset.right
> ```

## 大小

> 内容+内边距+边框+滚动条
>
> - ```elementNode.offsetWidth```
> - ```elementNOde.offsetHeight```

> 内容+内边距
>
> - ```elementNode.clientWidth```
> - ```elementNode.clientHeight```

> 包含滚动情况下，元素内容总尺寸
>
> - ```elementNode.scrollWidth```
> - ```elementNode.scrollHeight```

> 确定文档总高度（html 元素滚动大小）：取 HTML 元素的 scrollHeight 和 clientHeight 的最大值
>
> ```javascript
> var docWidth = Math.max(document.documentElement.clientWidth,document.documentElement.scrollWidth)
> var docHeight = Math.max(document.documentElement.clientHeight,document.documentElement.scrollHeight)
> ```

## 样式

> 访问内联样式
>
> ```elementNode.style.xxx```

> 访问所有规则层叠后呈现的样式
>
> - ```window.getComputedStyle(element).xxx```
> - ```elementNode.currentStyle.xxx```【IE】

> ```javascript
>     var div = document.getElementById('myDiv')
>     var computedStyle = null
>     if(typeof window.getComputedStyle === 'function'){
>       computedStyle = window.getComputedStyle(div,null)
>     } else {
>       computedStyle = div.currentStyle  // 兼容 IE
>     }
>     alert(computedStyle.width)
> ```

# 访问窗口

> ```javascript
> var parentWindow = document.defaultView || document.parentWindow
> ```

# 页面滚动

> ```elementNode.scrollIntoView()```
>
> - true：元素顶部与浏览器顶部平行
> - false：元素底部与浏览器底部平行

> 修改```document.body.scrollTop/scrollLeft```

> ```window.scrollTo(x,y)```
>
> ```window.scrollBy(x,y)```

# 管理焦点

找到焦点元素

> ```document.activeElement```
>
> - 文档加载刚刚完成时，指向 document.body
> - 文档加载期间，指向 null

使某元素拥有焦点

> ```elementNode.focus()```

判断某元素是否拥有焦点

> ```elementNode.hasFocus()```

# 动态脚本

在某一时刻，通过向 dom 结构中插入<script>标签来插入 js代码

将<script>标签插入 dom 结构后，开始下载

下载完成会触发 xxx 事件

```javascript
	function loadScript(url) {
      var script = document.createElement('script')
      script.type = 'text/javascript'
      script.src = url
      document.body.appendChild(script)
    }

    function loadScriptString(code){
      var script = document.createElement('script')
      try {
        script.appendChild(document.createTextNode(code))
      } catch (error) {
        script.text = code
      }
      document.body.appendChild(script)
    }
```

# 动态样式

在某一时刻，通过向 dom 结构中插入<link>、<style>标签来插入样式

将标签插入 dom 结构后，开始下载

下载完成会触发 xxx 事件

```javascript
	function loadStyle(url){
      var link = document.createElement('link')
      link.rel = 'stylesheet'
      link.type = 'text/css'
      link.href = url
      var head = document.getElementsByTagName('head')[0]
      head.appendChild(link)
    }

    function loadStyleString(css){
      var style = document.createElement('style')
      try {
        style.appendChild(document.createTextNode(css))
      } catch (error) {
        style.styleSheet.cssText = css
      }
      var head = document.getElementsByTagName('head')[0]
      head.appendChild(style)
    }
// 注意
// 使用 styleSheet.cssText 时，再次赋值或者赋值空字符串可能导致 IE 崩溃
```

# 性能问题

DOM 操作比非 DOM 操作开销更大，为什么？

> - DOM 操作要遍历文档
> - DOM 操作可能导致 reflow 和 repaint



访问 NodeList 的情况

- 所有节点访问 childNodes 属性、children 属性
- 元素节点访问 attributes 属性
- document.getElementsByTagName()
- document.forms
- document.images
- document.links

访问 NodeList 的原理

每次访问 NodeList 时，都对文档进行一次查询

所以无论何时访问 NodeList，结果都是最新的

DOM 操作是 js 中开销最大的部分，而访问 NodeList 的开销尤其大，**所以要尽可能减少 DOM 操作和访问 NodeList**

