# UICollectionView

## 官方文档

[链接](https://developer.apple.com/library/content/documentation/WindowsViews/Conceptual/CollectionViewPGforIOS/Introduction/Introduction.html#//apple_ref/doc/uid/TP40012334)

## 高级使用

[一篇较为详细的 UICollectionView 使用方法总结](http://www.jianshu.com/p/1228748c6719)

[用  UICollectionView 实现时间轴](http://www.jianshu.com/p/e10d95c676a8)

[悬浮Header](http://www.jianshu.com/p/1a8ba5fec807)

## 组成

![](https://ws3.sinaimg.cn/large/006tNc79ly1fjzkh22wy7j30sg0itdmi.jpg)

![](https://ws2.sinaimg.cn/large/006tNc79ly1fjzmhxe1qmj30m80akab7.jpg)

- 单元格（Cell）
- 节（Section）：行，由多个单元格组成
- 补充视图（SupplementaryView）：节的头（header）和脚（footer）上放置的视图
- 装饰视图：集合视图的背景

## 例图

![](https://ws4.sinaimg.cn/large/006tNc79ly1fjzn1avmm7j309d0gowgj.jpg)



## 使用步骤

#### 1.自定义单元格

- 继承 ```UICollectionViewCell```
- 重写``` initWithFrame:```方法，向 ```self.contentView```中添加视图

![](https://ws4.sinaimg.cn/large/006tNc79ly1fjzmmf8t90j31kw0w412g.jpg)

#### 2.创建 CollectionView

- 创建布局```UICollectionViewFlowLayout```，设置属性
- 根据布局创建```UICollectionView```，注册复用```Cell```，设置```dataSource```与```delegate```
- 实现```dataSource```与```delegate```方法

![](https://ws1.sinaimg.cn/large/006tNc79ly1fjzms2ghj4j31kw0t9guz.jpg)

![](https://ws2.sinaimg.cn/large/006tNc79ly1fjzmy3yflzj31kw136tir.jpg)

![](https://ws4.sinaimg.cn/large/006tNc79ly1fjzmzlqp9nj31kw099mzn.jpg)



