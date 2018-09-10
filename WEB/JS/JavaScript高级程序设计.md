# 基本概念

## 语法

### 区分大小写

ECMAScript 中的一切都区分大小写（变量、函数、操作符）

### 标识符

- 第一个字符 : 字母、下划线（_）、美元符号（$）
- 其他字符 : 字母、数字、下划线（_）、美元符号（$）
- 驼峰格式

### 注释

```javascript
// 单行注释

/*
 * 多行注释
 *
 */
```

## 变量

- ECMAScript 中变量是松散类型（可以保存任何类型数据）
- 先定义后使用，使用未定义的变量会导致报错
- 只定义未初始化的变量（```var item;```），值为```undefined```
- 使用``` var``` 定义的变量，是当前作用域中的局部变量
- 不使用 ```var``` 可以直接定义全局变量

```javascript
var item;	// 值为 undefined

var item1 = "";

var item2 = "",
    item3 = "",
    item4 = "";

function test(){
    var item5 = "";	// 局部变量 , 函数执行结束后被销毁
    item6 = ""；	   // 全局变量
}
```

基本类型都有什么？

> - Undefined
> - Null
> - Boolean
> - Number
> - String

引用类型有什么？

> - Object

基本类型变量在哪？

> 栈

引用类型变量保存在哪？

> 堆

能给基本类型添加属性么？

> 不可以。给基本类型添加属性不会报错，但是无法访问到该属性

两个基本类型变量赋值原理？

> 值复制

两个引用类型变量赋值原理？

> 值复制
>
> 不过因为引用类型变量本质上是一个指针，所以赋值的过程是传递指针，两个变量会指向堆中同一个对象

## 操作符

(p36)

### 布尔操作符

- 与（&&）
- 或（||）
  - 两个操作数都是有效对象时（非 null），返回第一个操作数，否则返回第二个操作数
- 非（！）
  - 操作数是对象时，先将操作数转换为布尔值，再求反

### 关系操作符

- (<)，(<=)，(>)，(>=)
- 比较字符串时，比较的是对应位置字符的字符编码
- 任何操作数与``` NaN``` 比较都返回``` false```

### 相等操作符

- 相等和不相等 : ```==```和```！=```进行类型转换
- 全等和不全等 : ```===```和```！==```不进行类型转换
- **建议使用```===```和```！==```**

## 语句

（p54）

### ```if``` / ```while``` / ```do-while``` / ```for```

### ```for in``` 

- 枚举对象属性

- 如果对象值是 ```null```和``` undefined``` ，不执行循环，所以遍历属性之前先判断对象是不是``` null```/```undefined```

- ```javascript
  for(var propName in window){
      alert(propName);
  }
  ```

### ```with``` 

- 指定一个对象作为作用域
- 因为延长了作用域链，造成了更多的开销，所以**不建议使用**

### ```switch``` 

- ```case``` 比较时内部使用```===```，不会进行类型转换

- 省略``` break``` 可以合并执行

- ```javascript
  switch(num){
      case 10:
          alert("10");
          break;
      case 20:
          alert("20");	// 合并两种情况的执行代码(省略 break)
      case 30:
          alert("30");
          break;
      default:
          alert("unknown");
  }
  ```

- 条件语句中，如果传入非 Boolean 值，会使用 ```Boolean()```进行类型转换**（建议直接放入布尔值，不要进行自动类型转换）**

# 垃圾回收

JavaScript 中的内存管理机制？

> JavaScript 中有垃圾回收机制，执行环境自动管理内存

垃圾回收机制的原理？

> 找到不在使用的变量，释放其占用的内存。垃圾回收会周期性进行这一操作

垃圾回收机制的种类？

> - 标记清除（IE、Chrome、Safari、Opera、FireFox）
>   - 对象有两种状态
>     - “进入环境”
>     - “离开环境”
>   - 垃圾回收机制先给所有对象都打上回收标记，然后跟踪每个对象的状态，将在环境中的对象或被环境中对象引用的对象的标记去掉，给离开环境的对象添加标记。然后一段时间后，释放带标记的对象的内存
> - 引用计数
>   - 跟踪每个对象被引用的次数，每被引用一次，引用计数加一，取消引用，引用计数减一。引用计数归零的时候，代表可以被垃圾回收机制回收了
>   - 循环引用会导致内存泄露，改变的方法是解除引用（手动）
>   - IE8中 DOM 对象和 BOM 对象都以 COM（使用 C++实现，Component Object Model） 对象形式实现，而 COM 对象的垃圾回收机制是引用计数，所以在 IE8中，使用 DOM 对象和 BOM 对象容易产生循环引用而导致内存泄露。IE9修复了这个问题，将 BOM 对象和 DOM 对象换成了 JavaScript 对象

如何优化内存管理？

> 全局变量或全局变量的属性如果不再使用，将其赋值```null```来解除引用，以便垃圾回收机制下次执行的时候及时回收内存



# BOM

## window

window 既是访问浏览器的接口，也是 Global 对象（全局作用域）

全局变量不能使用 delete 删除，但是 window 对象定义的属性可以

检测某个全局变量是否存在：window.varName

### 框架

<frame>标签引用的某个页面

浏览器窗口也是框架，只不过是最外层框架

每个框架都有自己的 window 对象

访问其他框架的方式

- top（指向最外层框架，也就是当前标签页/浏览器窗口）
- parent（指向上级框架，如果没有框架，等于 top，指向 window）
- self（当前框架）

因为每个框架都有自己的 window 对象，因为构造函数都是 Function 类型的实例，所有每个框架都有一套自己的原生类型构造函数（Object、Function、Array 等），互相之间不相等。所以使用 instanceof 操作符检测跨框架传递的对象是会出现问题

### 窗口位置

没有办法跨浏览器，获得浏览器窗口相对于屏幕的坐标

没有办法跨浏览器，精准移动浏览器窗口

### 窗口大小

没有办法跨浏览器，精准调整浏览器窗口大小

获取 viewport 大小

兼容桌面和移动：document.documentElement.clientWidth/Height

移动设备可见区域大小:window.innerWidth/Height

### 打开窗口

window.open()

- 参数
  - url（字符串）
  - 目标窗口（字符串）
    - 可以是自定义名称
    - _self
    - _parent
    - _top
    - _blank（新标签页）
  - 窗口特性（字符串）
  - 是否替换历史纪录（布尔）
- 返回
  - 新窗口的引用

第一个参数和第二个参数常用

第三个参数在要打开一个非默认设置浏览器窗口时使用

第四个参数只在不打开新窗口时使用

如果只传入第一个参数，默认在新标签页打开

```javascript
// 在当前页打开 url
window.open('https://www.baidu.com','_self')
window.open('https://www.baidu.com','_parent')
window.open('https://www.baidu.com','_top')

// 在新标签页打开 url
window.open('https://www.baidu.com','_blank')

// 打开不带地址栏的标签页
window.open('https://www.baidu.com','_blank','location=false')
```

- 后续使用
  - 有些浏览器不允许对主窗口调整位置、大小，但是可以对弹出窗口进行调整
  - 通过窗口引用可以关闭窗口
  - 新创建的窗口（window）对象有一个属性 opener 指向打开它的窗口

```javascript
// 打开不带地址栏的标签页
var newWindow = window.open('https://www.baidu.com','newWindow','location=false')
newWindow.resizeTo(100,100)
newWindow.moveTo(100,100)
newWindow.close()
```

- 注意

  - 在 chrome 中，将 window.opener 设置为 null，表示在单独的进程中运行新标签页，新标签页无法与打开它的标签页进行通信

  - 浏览器会内置或者通过插件阻止弹出窗口，所以应该使用 window.open()前需要进行检测，代码如下

  - ```javascript
    // 如果浏览器阻止弹出窗口，window.open()返回 null
    // 如果浏览器插件阻止弹出窗口，window.open()会报错
    var blocked = false
    try{
        var newWindow = window.open('https://www.baidu.com','newWindow','_blank')
        if(newWindow === null){
            blocked = true
        }
    } catch(error){
        blocked = true
    }
    ```

### 定时器

window 对象有 setTimeout()、setInterval()

setTimeout()

- 参数
  - 执行代码
  - 延迟时间（毫秒）
- 返回
  - 定时器 id（可以用来取消定时器）
- 注意
  - 不要给第一个参数传递代码字符串，会造成双重解析（解析器解析setTimeout()的时候，再创建一个字符串解析器），导致开销增大
  - 方法只是在一段时间后将代码添加到 JS 的任务队列中，并不代表马上会执行（JS 是单线程执行，按照添加到任务队列的顺序执行代码。如果任务队列这是空的，那么马上执行；如果任务队列不是，等前面的代码执行完才回执行）
- 取消定时器
  - clearTimeout(id)

```javascript
var id = setTimeout(function(){
	// 匿名函数中,this 指向全局对象(window)
    alert('hello')
},100)
clearTimeout(id)
```

setInterval()

不建议使用，建议用 setTimeout 进行模拟

- 任务队列中只允许存在一个定时器代码，如果上一个定时器还没有执行，下一个就添加到任务队列中，那么会被忽略
- 如果执行代码花费时间接近延迟时间，可能出现扎堆执行的情况（上一个还没执行完，下一个已经开始执行）

### 对话框

- alert()
- prompt()
  - 参数：字符串
  - 返回
    - true：点击 ok
    - false：点击 cancel 或 x 按钮

打开对话框是阻塞操作

## location

window 对象的属性，用来操作 URL

### 属性

- hash
  - 返回 URL 中的 hash，如果不包含，返回空字符串
  - ```'#contents'```
- host
  - 返回服务器名称和端口号
  - ```'www.baidu.com:80'```
- hostname
  - 返回服务器名称不带端口号
  - ```'www.baidu.com'```
- href
  - 返回完整的 URL，location 的 toString()也返回这个值
  - ```'https://www.baidu.com'```
- pathname
  - 返回 URL 中的目录
  - ```'/sdf/sdfsdf'```
- port
  - 返回端口号
  - ```'8080'```
- protocol
  - 返回协议
  - ```'https:'```
- search
  - 返回查询字符串
  - ```'?name=sdf'```

解析查询字符串

先去掉问号（返回从索引1开始到结尾的新数组）

以&分割数组，获得每一个键值对

以=分割键值对，拿到 key 和 value

### 页面跳转

location.assign(url)：打开新 URL 并生成历史纪录

location.replace(url)：打开新 URL 不生成历史纪录

修改 location 的属性：例如 location.href，会自动调用 location.assign()

### 重新加载

location.reload(boolean)

- true：强制从服务器加载
- 不传参数：可能从缓存也可能从服务器加载

## navigator

包含浏览器信息（略，p210）

### 插件检测

IE 和其他浏览器检测方式不同，插件名称也不同

```javascript
	// 非 IE
    function hasPlugin(name){
      navigator.plugins.refresh() // 刷新插件
      name = name.toLowerCase()
      var length = navigator.plugins.length
      for(var i = 0;i < length;i++){
        if(navigator.plugins[i].name.toLowerCase.indexOf(name) > -1){
          return true
        }
      }
      return false
    }
    // IE
    function hasIEPlugin(name){
      navigator.plugins.refresh() // 刷新插件
      try {
        new ActiveXObject(name)
        return true
      } catch (error) {
        return false
      }
    }


    // 兼容版检测 Flash
    function hasFlash(){
      var result = hasPlugin('Flash')
      if(!result){
        result = hasIEPlugin('ShockwaveFlash.ShockwaveFlash')
      }
      return result
    }
```

### 注册处理程序

RSS

```navigator.registerContentHandler('application/rss+xml','http://www.somereader.com?feed=%s','some reader')```

邮件

```navigator.registerProtocolHandler('mailto','http://www.somemail.com?cmd=%s','some mail client')```

%s 表示原始请求

## screen

显示器信息（略，p214）

## history

历史纪录跳转

go()、back()、forward()

```javascript
history.go(-1)		// 后退
history.go(1)		// 前进
history.go(2)		// 前进两页
history.go('some page')		// 跳转到历史纪录中包含该字符串的最近位置
```

# 客户端检测

先开发通用方案，然后针对特定浏览器开发增强方案

能力检测

检测某个方法是否可以使用

不能通过能力检测确定浏览器，不够严谨

typeof xxx === 'function'

怪癖检测

知道某种浏览器存在某个 bug，直接检查这个 bug 是否存在来确定浏览器

用户代理检测

通过代理字符串（navigator.userAgent）确定浏览器

确定引擎比确定浏览器更重要，因为 api 定义在引擎中

引擎和浏览器

gecko-firefox

webkit-safari,chrome,移动设备浏览器（IOS\ANDROID）

presto-opera

IE-IE

检查引擎

先检查 opera，因为opera 会将代理字符串伪装成其他浏览器。window.opera 对象

再检查 webkit。在代理字符串中查询 AppleWebKit 

再检查 KHTML，在代理字符串中查询 KHTML

再检查 Gecko，在代理字符串中查询 Gecko

最后 IE，在代理字符串中查询 MSIE

检查浏览器

 检查用户代理字符串

检查平台

检查 navigator.platform 中的数据

检测优先级：能力检测>怪癖检测>用户代理检测

# Canvas

兼容性？

> - 2D 上下文、文本
>   - IE9+以及其他所有浏览器（包括 webkit）
> - 3D 上下文
>   - 几乎不支持

如何使用？

> - 在 DOM 结构中添加<canvas>标签，并设置 width、height 特性、设置标签中间的文字（作为替代文本）
> - 在 JS 中获取 canvas 元素的引用
> - 检查 getContext 方法是否存在，如果存在，调用 getContext('2d')方法获取 2D 上下文对象
> - 使用 2D 上下文对象进行绘制

<canvas>中的坐标系？

> 原点在左上角，向右为 X 正轴，向下为 Y 正轴

## 填充和描边

fillStyle

strokeStyle

一旦设置这两个属性，所有填充和描边都操作都使用属性指定的样式，直到重新设置这两个属性

```javascript
var canvas = document.getElementById('canvas)
if(canvas.getContext){
    var context = canvas.getContext('2d')
    context.fillStyle = #ff0000
    context.strokeStyle = 'red'
}
```



## 绘制矩形

 矩形是唯一一种可以直接绘制的形状

fillRect()：填充一个矩形，填充颜色由 fillStyle 指定

strokeRect()：描边一个矩形，描边颜色由 strokeStyle 指定

clearRect()：清除矩形区域

参数：X 坐标，Y 坐标，宽、高

```javascript
var canvas = document.getElementById('canvas)
if(canvas.getContext){
    var context = canvas.getContext('2d')
    context.fillStyle = #ff0000
    context.strokeStyle = 'red'
    
    context.fillRect(0,0,100,100)
    context.strokeRect(150,150,100,100)
    context.clearRect(0,0,100,100)
}
```

## 绘制路径

p449

- beginPath()
- 绘制路径
- 连接路径/填充路径/路径描边/使用路径进行剪切

## 绘制文本

p451

如何绘制文本？

> 设置文本属性：font,textAlign,textBaseline
>
> 设置颜色属性：fillStyle，strokeStyle
>
> filleText()
>
> strokeText()
>
> 参数：文本字符串，X 坐标，Y 坐标，最大像素宽度（可选）
>
> ```
> context.font = 'bold 14px Arial'
> context.textAlign = 'center'
> context.textBaseline = 'middle'
> context.fillText('12',100,20)
> ```

如何确定文本大小？

> measureText()

## 变换

## 绘制图像

drawImage()

## 阴影

## 渐变

## 模式

使用重复的图像来填充或描边

## 处理图像（像素级）

getImageData()

## 透明度

## 图形重合方式

## WebGL（3d 上下文）





# 拖放

## 原生拖放（IE10+）

### 拖放事件

> 拖动时（在被拖动元素上触发）
>
> - dragstart
>   - 开始拖动时触发
> - drag
>   - 拖动时持续触发
> - dragend
>   - 拖动结束时触发

> 放置时（在放置目标上触发）
>
> - dragenter
>   - 拖动元素进入放置目标内触发
> - dragover
>   - 拖动元素在放置目标内移动时持续触发
> - dragleave/drop
>   - dragleave：拖动时，拖动元素离开放置目标时触发
>   - drop：拖动结束时，拖动元素在放置目标内触发

### 定义放置目标

元素默认不允许放置，也就是不会触发 drop 事件，需要手动设置

如何定义放置目标？

> - 监听指定元素的 dragenter 和 dragover 事件，在事件处理程序中阻止默认行为，这个目标就成为可放置目标
> - 为了兼容 firefox，还要监听 drop 事件，并阻止默认行为（因为 firefox 的拖动默认是打开拖动元素的 URL）
>
> ```javascript
>     // 定义放置目标
>     EventUtil.addHandler(window,'load',function(event){
>       var dropTarget = document.getElementById('dropTarget')
>       EventUtil.addHandler(dropTarget,'dragenter',function(event){
>         event = EventUtil.getEvent(event)
>         EventUtil.preventDefault(event)
>       })
>       EventUtil.addHandler(dropTarget,'dragover',function(event){
>         event = EventUtil.getEvent(event)
>         EventUtil.preventDefault(event)
>       })
>       EventUtil.addHandler(dropTarget,'drop',function(event){
>         event = EventUtil.getEvent(event)
>         EventUtil.preventDefault(event)
>       })
>     })
> ```

### 数据传递

dataTransfer 对象

> 拖放事件处理程序中，event 对象的属性，用于传递字符串

dataTransfer 对象的方法？

> - getData(dataType)
>   - 参数
>     - 数据类型（text/URL）
>   - 只能在 drop 事件处理程序中调用
> - setData(dataType,message)
>   - 参数
>     - 数据类型（text/URL）
>     - 字符串
>   - 在 dragstart 事件处理程序中手动调用，或浏览器自动调用
> - clearData(dataType)
>   - 参数
>     - 数据类型（text/URL）
>   - 清除指定格式数据

dataTransfer 对象的属性？

> dropEffect
>
> - 表示放置目标接受哪种放置行为（只影响光标的显示符号，没有真正的效果）
> - 必须在 dragenter 事件处理程序中设置
>
> - none
>   - 不能将拖动元素放在这里（除文本框外，所有元素默认值）
> - move
>   - 应该将拖动元素移动到放置目标
> - copy
>   - 应该将拖动元素复制到放置目标
> - link
>   - 放置目标打开拖动元素（要求拖动元素是一个链接，有 URL）

> effectAllowed
>
> - 表示拖动元素允许哪种放置行为
> - 必须在 dragstart 事件处理程序中设置
> - uninitialized
>   - 没有设置放置行为
> - none
>   - 不允许放置行为
> - copy
>   - 只允许 copy 放置行为
> - link
>   - 只允许 link 放置行为
> - move
>   - 只允许 move 放置行为
> - copyLink
>   - 允许 copy、link 放置行为
> - copyMove
>   - 允许 copy、move 放置行为
> - linkMove
>   - 允许 link、move 放置行为
> - all
>   - 允许所有放置行为

如何在拖放时进行数据传递？

> 自动
>
> - 拖动文本框中的文本时，浏览器自动调用 setData()，将文本以 text 格式，保存在 dataTransfer 对象中
> - 拖动链接或图像时，浏览器自动调用setData()，将文本以 URL 格式，保存在 dataTransfer 对象中
> - 在 drop 事件处理程序中，从 dataTransfer 对象获取数据

> 手动
>
> - 在被拖动目标的 dragstart 事件处理程序中，使用 dataTransfer 对象，调用 setData()保存数据
> - 在放置目标的 drop 事件处理程序中，使用 dataTransfer 对象，调用 get

可拖动元素？

> 默认情况下，图像、链接、文本可拖动

> - 可以设置元素的 draggable 属性，让元素可拖动/禁止拖动（IE10+以及其他所有浏览器）
>   - 为了兼容 firefox，需要监听 dragstart，在 dataTransfer 对象中保存一些信息
> - 监听 mousedown 事件，在事件处理程序中，调用 dragDrop()，可以让所有元素可拖动（IE9-）

## 自定义拖放

> - 给支持拖放的元素，添加 draggable 类
> - 在 document 上监听 mousedown，mousemove,mouseup 事件
> - 在 mousedown 事件处理程序中，检查 event.target 是否有 draggalble 类，如果有，将其作为拖放对象
> - 在 mousemove 事件处理程序中，修改拖放对象的位置
> - 在 mouseup 事件处理程序中，释放拖放对象

> 简单版本
>
> ```javascript
>     var dragManager = (function(){
>       var dragTarget = null,
>           diffX = 0,
>           diffY = 0
>       function handleDrag(event){
>         event = EventUtil.getEvent(event)
>         var target = EventUtil.getTarget(event)
>         switch(event.type){
>           case 'mousedown':
>             if(target.className.indexOf('draggable')){
>               dragTarget = target
>               diffX = event.clientX - dragTarget.offsetLeft
>               diffY = event.clientY - dragTarget.offsetTop
>             }
>             break
>           case 'mousemove':
>             if(dragTarget){
>               dragTarget.style.left = (event.clientX - diffX) + 'px'
>               dragTarget.style.top = (event.clientY - diffY) + 'px'
>             }
>             break
>           case 'mouseup':
>             if(dragTarget){
>               dragTarget = null
>             }
>         }
>       }
>       return {
>         enable:function(){
>           EventUtil.addHandler(document,'mousedown',handleDrag)
>           EventUtil.addHandler(document,'mousemove',handleDrag)
>           EventUtil.addHandler(document,'mouseup',handleDrag)
>         },
>         disable:function(){
>           EventUtil.removeHandler(document,'mousedown',handleDrag)
>           EventUtil.removeHandler(document,'mousemove',handleDrag)
>           EventUtil.removeHandler(document,'mouseup',handleDrag)
>         }
>       }
>     })()
> ```

> 自定义事件版本
>
> ```javascript
>     // 自定义事件
>     function EventTarget(){
>       this.handlers = {}
>     }
>     EventTarget.prototype.addHandler = function(eventType,handler){
>       if(typeof this.handlers[eventType] === 'undefined'){
>         this.handlers[eventType] = []
>       }
>       this.handlers[eventType].push(handler)
>     }
>     EventTarget.prototype.fire = function(event){
>       if(!event.target){
>         event.target = this
>       }
>       if(typeof this.handlers[event.type] === 'array'){
>         var handlers = this.handlers[event.type]
>         for(var i = 0,len = handlers.length; i < len; i++){
>           handlers[i](event)
>         }
>       }
>     }
>     EventTarget.prototype.removeHandler = function(eventType,handler){
>       if(typeof this.handlers[eventType] === 'array'){
>         var handlers = this.handlers[eventType]
>         for(var i = 0,len = handlers.length; i < len; i++){
>           if(handlers[i] === handler){
>             break
>           }
>         }
>         handlers.splice(i,1)
>       }
>     }  
>     
>     // 自定义拖放
> 	  var dragManager = (function(){
>       var dragTarget = null,
>           diffX = 0,
>           diffY = 0,
>           eventTarget = new EventTarget()
>       function handleDrag(event){
>         event = EventUtil.getEvent(event)
>         var target = EventUtil.getTarget(event)
>         switch(event.type){
>           case 'mousedown':
>             if(target.className.indexOf('draggable')){
>               dragTarget = target
>               diffX = event.clientX - dragTarget.offsetLeft
>               diffY = event.clientY - dragTarget.offsetTop
>               eventTarget.fire({
>                 type:'dragstart',
>                 target:dragTarget,
>                 x:event.clientX,
>                 y:event.clientY
>               })
>             }
>             break
>           case 'mousemove':
>             if(dragTarget){
>               dragTarget.style.left = (event.clientX - diffX) + 'px'
>               dragTarget.style.top = (event.clientY - diffY) + 'px'
>               eventTarget.fire({
>                 type:'drag',
>                 target:dragTarget,
>                 x:event.clientX,
>                 y:event.clientY
>               })
>             }
>             break
>           case 'mouseup':
>             if(dragTarget){
>               eventTarget.fire({
>                 type:'dragend',
>                 target:dragTarget,
>                 x:event.clientX,
>                 y:event.clientY
>               })
>               dragTarget = null
>             }
>         }
>       }
>       eventTarget.enableDrag = function(){
>           EventUtil.addHandler(document,'mousedown',handleDrag)
>           EventUtil.addHandler(document,'mousemove',handleDrag)
>           EventUtil.addHandler(document,'mouseup',handleDrag)
>         }
>       eventTarget.disableDrag = function(){
>           EventUtil.removeHandler(document,'mousedown',handleDrag)
>           EventUtil.removeHandler(document,'mousemove',handleDrag)
>           EventUtil.removeHandler(document,'mouseup',handleDrag)
>         }
>       return eventTarget
>     })()
>     dragManager.addHandler('dragstart',function(event){
>       // do some
>     })
>     dragManager.addHandler('drag',function(event){
>       // do some
>     })
>     dragManager.addHandler('dragend',function(event){
>       // do some
>     })
> ```
>
> 

# 视频音频

<video><audio>（IE9+以及所有其他浏览器）

p486



# 错误处理

## try-catch-finally

```javascript
try{
	// 可能发生错误的代码
} catch (error){
    // 处理错误的代码
    alert(error.message)	// 错误描述，唯一所有浏览器都支持的属性
} 

try{
    
} catch (error){
    
} finally {
    // 一定会执行的代码快
    // 会导致 try-catch 中的 return 语句失效
}
```

## 错误类型

- Error
  - 错误的基类型
  - 用于抛出自定义错误
- EvalError
  - eval()函数抛出的异常（没有把 eval()当成函数使用时）
- SytaxError
  - eval()中，出现语法错误
- RangeError
  - 数值超出范围（例如：定义数组时，指定了数组不支持的长度-20）
- ReferenceError
  - 访问没有声明的变量
-  TypeError
  - 访问不存在的方法
- URIError
  - 使用 encodeURI()、decodeURI()出现格式错误

如何判断错误类型？

> if(error instanceof XxxError)

## 抛出错误

```javascript
throw new Error('error message')
```

通过 throw 抛出错误后，代码会立即停止执行

浏览器会像处理自己生成的错误一样，处理这个错误

也可以使用 RangeError，ReferenceError，TypeError

在某种已知的情况发生时（例如：传入参数类型不正确），抛出自定义错误，可以减少调试成本

## 何时捕获？何时抛出？

只捕获确切知道该如何处理的错误，避免浏览器以默认方式处理

需要为错误提供具体信息时，手动抛出错误

## 错误事件

> 全局 try-catch
>
> 任何没有被 try-catch 捕捉的错误，都会触发 window 对象的 error 事件
>
> 在 window 对象上添加 error 事件处理程序只能使用 DOM0 级方法（.onerror）
>
> ```javascript
> window.onerror = function(message){		// message 唯一有用参数
>     alert(message)
>     return false	// 阻止浏览器默认报告错误行为
> }
> ```

> 图像 error 事件
>
> 图像加载失败会触发 error 事件，并且在事件处理程序中，无法重新下载（下载过程已经结束）
>
> ```javascript
> var image = new Image()
> EventUtil.addHandler(image,'load',function(event){
>     alert('image loaded)
> })
> EventUtil.addHandler(image,'error',function(event){
>     alert('image not loaded')
> })
> image.src = 'sdf.gif'	// 指定不存在的文件
> ```

## 常见错误避免

> 类型转换
>
> - 使用全等和不全等
> - 避免在流控制语句（例如：if 语句）中使用非布尔值

> 数据类型错误
>
> - 对参数进行类型检测
>   - 基本类型使用 typeof
>   - 引用类型使用 instanceof
> - 对参数进行能力检测
>   - typeof xxx.xxx === 'function'

> 通信错误
>
> - 查询字符串要用 encodeURIComponent() 进行编码

## 处理错误思路

对可能出错的代码使用 try-catch 包装，在 catch里进行错误处理，避免错误影响用户体验









# Geolocation（IE9+）

- getCurrentPosition()
- watchPosition()

# File API（IE10+）



# 提高可读性

> - 四个空格的缩进
>
> - 多写注释
>
>   - 函数
>   - 算法
>   - hack
>
> - 给变量和函数使用有意义的名字
>
>   - 变量名使用名词
>   - 函数名以动词开始
>
> - 变量初始化时，指定变量类型
>
>   - ```javascript
>     var found = false
>     var person = null
>     var name = ''
>     var count = -1
>     ```
>
> - 松散耦合：节省调试时间、降低维护难度
>
>   - HTML 和 JS 解耦
>     - 所有 js 代码都通过外部文件加载
>     - 不要在JS 中创建元素，应该在 HTML 中创建好，然后隐藏，需要时显示
>   - HTML 和 CSS 解耦
>     - 所有 CSS 都通过外部文件加载
>   - JS 和 CSS 解耦
>     - 不要直接在 JS 中修改样式，应该先在 CSS 中定义好类，在 JS 中修改类名
>   - 应用逻辑和事件处理程序解耦
>     - 事件处理程序应该负责从事件对象中获取数据，然后传递给应用逻辑函数
>     - 事件处理程序不要直接传递 event 对象，要传递 event 对象中的数据

# 共同开发注意

> 尊重对象所有权（不是自己负责创建或者维护的对象，不能进行修改）
>
> - 不能创建实例或原型属性
> - 不能创建实例或原型方法
> - 不能重写已定义方法

> 避免使用全局变量和函数
>
> - 可以创建一个全局变量，将其他变量和函数包含其中
> - 使用命名空间
>
> ```javascript
> // 全局变量
> var global = {}
> // 命名空间
> global.zwq = {}
> ```

> 避免与 null 比较
>
> - 引用类型，使用 instanceof 确定
> - 基本类型，使用 typeof 确定
> - 能力检测，使用 typeof xxx === 'function'

> 使用常量
>
> ```javascript
> var Constants = {
>     INVALID_VALUE_MSG:'invalid value!',
>     INVALID_VALUE_URL:'/errors/invalid.php'
> }
> ```

# 常用

创建节点的方法

> - createElement()->appendChild()
> - innerHTML

类型检测

> - 基本类型：typeof
> - 引用类型：instanceof

获取原型

> - ```object.__proto__（chrome，firefox，safari）```
> - Object.getPrototypeOf()（IE9+）

获取构造函数

> - object.constructor（原型属性）
> - Object.prototype.toString.call()