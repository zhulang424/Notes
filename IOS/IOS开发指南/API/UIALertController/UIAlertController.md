# UIAlertController

## 摘要

- 只能在 IOS8之后使用
- 只能通过纯代码实现
- 可以实现警告框（Alert）和操作表（ActionSheet）
- 不仅可以添加按钮，还可以添加文本框和自定义视图
- 响应事件通过闭包完成，而不是委托
- 点击按钮，执行完闭包后，AlertView自动消失

## 警告框（Alert）

![](https://ws1.sinaimg.cn/large/006tKfTcly1fjxxfzrfwrj306s0dcweg.jpg)

#### 摘要

- 一个或两个按钮，超过两个应使用操作表（ActionSheet）
- **模态：不关闭不能进行别的操作**

#### 使用场景

- 应用不能继续进行：无法完成某些操作时，弹出一个警告，只需一个按钮
- 询问另外的解决方案：两个按钮’
- 询问对操作的授权：两个按钮

#### 使用

![](https://ws2.sinaimg.cn/large/006tKfTcly1fjxxx4wr0jj31f60n4gmx.jpg)

![](https://ws3.sinaimg.cn/large/006tKfTcly1fjxxarmwhgj30m8031aa4.jpg)

------

## 操作表（ActionSheet）

![](https://ws2.sinaimg.cn/large/006tKfTcly1fjxy6k97ldj306s0dct8p.jpg)

#### 摘要

- 提供多于两个选择的按钮
- iphone 下，从屏幕底部滑出，取消按钮在最下方，如果有破坏性操作，会被放在最上方，并且文字标注红色
- ipad 下，以气泡的形式弹出，箭头是浮动层的 Anchor Poine（锚点），没有取消按钮

#### 使用

![](https://ws4.sinaimg.cn/large/006tKfTcly1fjxxwyuiolj317k0wognq.jpg)

#### 设置浮动层Anchor Poine（锚点）

通过 ```UIAlertController``` 的 ```popoverPresentationController``` 的以下三个属性之一：

- ```barButtonItem```：指定一个导航栏按钮（UIBarButtonItem）作为锚点
- ```sourceView```：指定一个视图（UIView）作为锚点
- ```sourceRect```：指定一个区域（CGRect）作为锚点