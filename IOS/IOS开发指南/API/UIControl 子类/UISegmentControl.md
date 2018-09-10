# 概述

可由多段构成，每段相当于一个独立按钮

![](https://ws4.sinaimg.cn/large/006tKfTcly1fjx0nzs2nfj30fs04i742.jpg)

![](https://ws1.sinaimg.cn/large/006tKfTcly1fjx19zrnd8j306z06ojrh.jpg)

# 使用

- 创建

```objective-c
NSArray* segments = @[@"Left", @"Right"];
UISegmentedControl *segmentedControl = [[UISegmentedControl alloc] initWithItems:segments];
```

- 查看选中

```objective-c
NSInteger selectedIndex = segmentedControl.selectedSegmentIndex;
```

- 事件处理(UIControlEventValueChanged)

```
addTarget:action:forControlEvents: 
```

------

# 