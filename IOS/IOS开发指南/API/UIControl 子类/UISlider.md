# 概述

![](https://ws4.sinaimg.cn/large/006tKfTcly1fjx16c5mlrj30hy02ot8h.jpg)

![](https://ws3.sinaimg.cn/large/006tKfTcly1fjx1aqo54sj306t06owek.jpg)

# 使用

- 创建

```objective-c
CGFloat sliderWidth = 300;
CGFloat sliderHeight = 31; // UISlider 默认高度31
CGFloat sliderdTopView = 298;
UISlider *slider = [[UISlider alloc] initWithFrame:CGRectMake((screen.size.width - sliderWidth)/2 , sliderdTopView, sliderWidth, sliderHeight)]; 

slider.minimumValue = 0.0f;
slider.maximumValue = 100.0f;
slider.value = 50.00f;
```

- 查看当前进度值

```objective-c
int progressAsInt = (int)(slider.value)
```

- 事件处理（UIControlEventValueChanged）

```objective-c
addTarget:action:forControlEvents:
```

