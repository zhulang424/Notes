# 了解 Vue

Vue.js 是一个 MVVM 框架，核心思想是**数据驱动**、**组件化**

# MVVM

![](https://ws4.sinaimg.cn/large/006tNc79gy1ft4mmdkgg0j30sg0lc0t6.jpg)

Model：数据，对应 JS 对象

View：视图，对应 DOM 节点

ViewModel：Model 和 View 的中间件，负责对 Model 和 View 进行监听。当 ViewModel 监听到 Model 发生变化时，将数据同步到 View；监听到 View 的数据发生变化时，将变化同步到 Model。

Model 和 View 完全隔离，通过 ViewModel 进行通信

# 数据驱动

Vue 实现了 MVVM 设计模式中的 ViewModel，负责数据的同步

当数据发生变化后，Vue 自动更新 DOM；当修改表单中的数据时，Vue 自动将修改同步给数据。

## 优点

使开发人员可以将注意力集中在操作数据，而不是繁琐且重复的操作 DOM

## 原理

Vue 实现了双向绑定

### 主流实现双向绑定的方式

脏值检查：定时检测数据变动，来决定是否更新视图。Angular.js 使用该方法，在触发某些事件（DOM 事件、XHR 响应事件等）的情况下，进行脏值检查

数据劫持：通过 Object.defineProperty()定义访问器属性，在setter 中监听数据变动。

### Vue 实现双向绑定的方式

#### Model -》 View

数据劫持+观察者模式。创建 vue 实例时，通过 Object.defineProperty()将 data() 中的数据属性转换成访问器属性，也就是添加 getter 和 setter，在 set方法中，就可以监听到数据变化，然后通知 Watcher 进行更新

#### View-》Model

只有在操作表单元素时才会出现这种情况，而表单元素值发生变化时会触发 input 事件，可以在回调中通知 Model 进行数据更新

#### 源码解析

![](https://images2015.cnblogs.com/blog/938664/201705/938664-20170522225458132-1434604303.png)

Observer：监听器，通过 Object.defineProperty()实现对数据的监听，发生变动时，通知 Dep 进行 update

Compiler：解析器，解析指令，初始化视图（将模板中的变量替换成数据），给每个有指令的节点创建 Watcher 并绑定视图更新的回调函数

Watcher：订阅者，Compiler 和 Observer 之间的桥梁，实例化时，向 Dep 中添加自己；接收到 Dep 的通知后，触发绑定的视图更新回调函数

Dep：订阅器，维护了一个 Watcher 数组，接受到 Observer 的通知后，通知每个 Watcher 进行 update

# 组件化

什么是组件？

自定义的 html 元素，封装了可重用的 html 代码

Vue 如何实现组件化？

每个 Vue 实例都是一个组件，有自己独有的 html,css,javascript，挂载到某一个节点上

可以通过全局注册、局部注册的方式对 Vue 组件进行复用，也可以使用单文件组件的方式，通过局部注册使用

如何使用组件化？

创建组件：Vue.extend()

注册组件：全局注册（Vue.component()）、局部注册（import 导入，然后在 Vue 实例 option 对象的 components 属性中添加导入的组件）

使用组件

# 生命周期

![](https://ws4.sinaimg.cn/large/006tKfTcgy1ft5r67eaiaj30sg0lcn19.jpg)

虚拟 dom 是啥？

> 用 JS 对象模拟真正的 dom 结构，可以提升性能
>
> 操作 dom 的开销很大，而直接操作 JS 对象开销小很多，所以用 JS 对象模拟 dom 结构，然后操作先应用到虚拟 dom 上，根据虚拟 dom 再操作真正的 DOM
>
> ```javascript
> let virtualNode = {
>     tag:'div',
>     attributes:{
>         id:'myDiv'
>     },
>     children:[
>         
>     ]
> }
> ```



# 使用

data()为什么是个方法？

每个 Vue 实例都是一个组件，在组件复用时，如果不用 data()方法，数据就被共享了