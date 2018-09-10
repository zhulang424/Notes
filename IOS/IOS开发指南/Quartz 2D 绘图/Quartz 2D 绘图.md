# IOS 中绘图技术

- UIKit：高级别图形接口，API 基于 OC，能够访问绘图、动画、字体、图片等
- Quartz 2D：IOS 和 MacOS 环境下的2D 绘图引擎，也被称为 Core Graphics，API 接口基于 C，设计内容包括：基于路径的绘图，透明度绘图、遮阴影、透明层、颜色管理、抗锯齿渲染、生成 PDF 以及 PDF 元数据相关处理
- Core Animation：动画技术，也属于绘图技术
- OpenGL ES：OpenGL 针对嵌入式设备的简化版本，可以绘制高性能2D 和3D 图形

------

# 绘图技术基础

## 概述

- 无论哪种绘图技术，绘制都发生在 UIView 区域内
- 默认视图的绘制工作由 IOS 系统自动处理，自定义视图必须重写 drawRect:方法

## 视图绘制周期

- 在 IOS 中绘制时，首先为需要绘制的视图或视图的部分区域设置一个需要绘制的标志，在事件循环的每一轮中，绘图引擎会检查是否有需要更新的内容，如果有，就调用视图的 drawRect:方法绘制
- 一旦 drawRect:方法被调用，就可以使用任何的 UIKit、Quratz 2D、OpenGL ES 等技术对视图的内容进行绘制
- 在绘图过程中，除了调用 drawRect:方法外，还会调用 setNeedsDisplay（重新绘制整个视图） 和 setNeedsDisplayInRect:（重新绘制视图的部分区域），原则上，尽量不要重新绘制整个视图，减少开销
- 触发视图重新绘制的动作：
  - 遮挡视图被移动或删除
  - 视图的 hidden 属性设置为 false，视图从隐藏变为可见
  - 视图滚出屏幕，再重新回到屏幕
  - 显示调用 setNeedsDisplay 和 setNeedsDisplayInRect:

## 填充屏幕

- 创建 UIView 子类，重写 drawRect:方法

```objective-c
#import "MyView.h"
@implementation MyView
- (void)drawRect:(CGRect)rect {
    // 设置填充颜色，此时并未绘制
    [[UIColor grayColor] setFill];
    // 按照颜色填充矩形
    UIRectFill(rect);
}
@end
```

- 用创建的子类替换视图控制器的默认视图

```objective-c
    //创建根视图控制器
    ViewController* rootViewController = [[ViewController alloc] init];
    //创建自定义视图
    MyView* view = [[MyView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    //用自定义视图替换默认视图
    rootViewController.view = view;
```

## 描边（绘制矩形边框）

```objective-c
- (void)drawRect:(CGRect)rect {
    // 设置描边颜色
    [[UIColor whiteColor] setStroke];
    // 设置图形 Frame
    CGRect frame = CGRectMake(20, 30, 100, 300);
    // 绘制矩形边框
    UIRectFrame(frame);
}
```

## 绘制图像

绘制效果与使用标准控件 UIImageView 一样，使用 UIImage 实现：

- ```drawAtPoint:```：在指定的点，按照图片原尺寸，绘制图片。如图片大小超过屏幕，则超过的部分无法显示
- ```drawInRect:```：在指定矩形内绘制图片，会对图片进行缩放
- ```drawAsPatternInRect:```：在指定矩形内，按照图片原尺寸，平铺绘制图片。如果图片大小超出指定矩形，则与```drawAtPoint:``` 类似，如果图片大小小于指定矩形，就有平铺效果

```objective-c
- (void)drawRect:(CGRect)rect { 
    // 初始化图片
    UIImage* image = [UIImage imageNamed:@"dog"];
    // 设置一个rect矩形区域
    CGRect imageRect = CGRectMake(0, 40, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.width);
    // 绘制图片
    [image drawInRect:imageRect];
//    [image drawAtPoint:CGPointMake(0, 40)];
//    [image drawAsPatternInRect:CGRectMake(0, 0, 320, 400)];
}
```

## 绘制文本

绘制效果与使用标准控件 UILabel 一样，使用 NSString（NSStringDrawing）实现：

- ```drawAtPoint:withAttributes:```：在指定点绘制富文本
- ```drawInRect:withAttributes:```：在指定矩形内绘制富文本

```objective-c
- (void)drawRect:(CGRect)rect {
    // 初始化字符串
    NSString *title = @"我的小狗";
    // 设置字符串字体
    UIFont *font = [UIFont systemFontOfSize:28];
    NSDictionary *attr = @{NSFontAttributeName:font};
    // 根据字体获得字符串大小
    CGSize size = [title sizeWithAttributes:attr];
    // 水平居中时x轴坐标
    CGFloat xpos = [[UIScreen mainScreen] bounds].size.width / 2 - size.width / 2;
    // 绘制字符串
    [title drawAtPoint:CGPointMake(xpos, 20) withAttributes:attr];
    //CGRect stringRect = CGRectMake(xpos, 60, 100, 40);
    //[title drawInRect:stringRect withAttributes:attr];
}
```

# Quartz 图形上下文

## 概述

CGContextRef 对象，包含了各种绘制参数。例如：绘制使用的颜色、裁剪区域、线段宽度与风格信息、字体信息等

## 自定义图形上下文

```objective-c
- (void)drawRect:(CGRect)rect {
    // 自定义图形上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    // 定义路径：三角形
    CGContextMoveToPoint (context, 75, 10);         // 以（75，10）作为绘制起点
    CGContextAddLineToPoint (context, 10, 150);     // 定义从（75，10）到（10,150）的线段
    CGContextAddLineToPoint (context, 160, 150);    // 定义从（10,150）到（160，150）的线段，此时路径不是闭合的
    CGContextClosePath(context);                    // 定义闭合路径
    // 设置黑色描边参数
    [[UIColor blackColor] setStroke];
    // 设置红色条填充参数
    [[UIColor redColor] setFill];
    // 绘制路径
    CGContextDrawPath(context, kCGPathFillStroke);
}
```

![](https://ws3.sinaimg.cn/large/006tNc79ly1fl71a8mu0mj31kw0ls47n.jpg)

# Quartz 路径

## 概述

- Quartz 路径可以用来描述：矩形、圆、其他 2D 图形
- 通过路径，可以对几何图形进行：描边、填充、描边填充
- Quartz 2D（Core Graphics）有4个基本图元用于描述路径：
  - 点：二维空间中的一个位置。一个点完全不占空间，画一个点在屏幕上不会显示任何东西
  - 线段：由起点、终点定义，可以由描边绘制出来。线段没有面积，所以不能被填充。想要填充的话可以用一组线段或去西安组成一个具有封闭路径的集合图形，然后填充
  - 弧：由圆心点、半径、起始角和结束角决定。圆是弧的特例，起始角为0度，结束角为360度。因为弧是占有一定面积的路径，所以可以被填充、描边、描边填充
  - 贝赛尔曲线：分为二次方贝塞尔去西安和高阶贝赛尔曲线，由4个点描述：两个点描述两个短点（例如：p1和 p2，p2和 p3），另外两个点描述每一端的切线（例如：p0，p1和 p0）

![](https://ws4.sinaimg.cn/large/006tNc79ly1fl711j6l17j31kw0er0vd.jpg)

- 定义和绘制是不同操作，先定义路径，再绘制路径

## 使用贝塞尔曲线

- 主要方法

```objective-c
void CGContextAddCurveToPoint(CGContextRef c, CGFloat cp1x, CGFloat cp1y, CGFloat cp2x, CGFloat cp2y, CGFloat x, CGFloat y);
// CGContextRef c：上下文对象
// CGFloat cp1x，CGFloat cp1y：第一控制点
// CGFloat cp2x，CGFloat cp2y：第二控制点
// CGFloat x, CGFloat y：端点
```

- 整体使用

```objective-c
- (void)drawRect:(CGRect)rect {    
    // 设置上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    // 定义路径（将轮廓分解成很多贝赛尔曲线，然后找到曲线的控制点）
    CGContextMoveToPoint(context, 333, 0);
    CGContextAddCurveToPoint(context, 333, 0, 332, 26, 330, 26);
    CGContextAddCurveToPoint(context, 330, 26, 299, 20, 299, 17);
    CGContextAddLineToPoint(context, 296, 17);
    CGContextAddCurveToPoint(context, 296, 17, 296, 19, 291, 19);
    CGContextAddLineToPoint(context, 250, 19);
    CGContextAddCurveToPoint(context, 250, 19, 241, 24, 238, 19);
    CGContextAddCurveToPoint(context, 236, 20, 234, 24, 227, 24);
    CGContextAddCurveToPoint(context, 220, 24, 217, 19, 216, 19);
    CGContextAddCurveToPoint(context, 214, 20, 211, 22, 207, 20);
    CGContextAddCurveToPoint(context, 207, 20, 187, 20, 182, 21);
    CGContextAddLineToPoint(context, 100, 45);
    CGContextAddLineToPoint(context, 97, 46);
    CGContextAddCurveToPoint(context, 97, 46, 86, 71, 64, 72);
    CGContextAddCurveToPoint(context, 42, 74, 26, 56, 23, 48);
    CGContextAddLineToPoint(context, 9, 47);
    CGContextAddCurveToPoint(context, 9, 47, 0, 31, 0, 0);
    // 根据上下文绘制路径
    CGContextStrokePath(context);
}
```

# Quartz 坐标变换

## 概述

图形变换的操作包括：平移、缩放、旋转等，都离不开坐标变换

## 坐标系

Quartz 2D（Core Graphics）坐标系与 UIKit 坐标系不同

- Quartz 2D 中，坐标系原点在左下角，X 轴向右为正方向，Y 轴向上为正方向

![](https://ws2.sinaimg.cn/large/006tNc79ly1fl72ptql67j30fi0dcwey.jpg)



- UIKit 中，坐标系原点在左上角，X 轴向右为正方向，Y 轴向下为正方向

![](https://ws3.sinaimg.cn/large/006tNc79ly1fl72qma2ftj30fg0dc74o.jpg)

想要使 Quartz 2D绘制出的图形在 UIKit 中正确显示出来，需要做一个变换，是 Quartz 2D 图形上下文与 UIKit 具有相同的坐标系，然后再根据 UIKit 坐标系进行平移，达到最终效果

```objective-c
    CGContextTranslateCTM(context, 0, uiImage.size.height);
    CGContextScaleCTM(context, 1, -1);
```



## 2D 图形基本变换原理

### 概述

- 图形变换本质上是矩阵计算，每一种变换都有一个矩阵，原始图形中的像素点坐标与矩阵进行计算得到新的像素点坐标，然后重新绘制到视图。
- 基本变换包括：平移、缩放、旋转
- 有的图形系统还提供例外几种变换：反射变换、错切变换等

### 平移变换

![](https://ws1.sinaimg.cn/large/006tNc79ly1fl737tizkkj31kw0ls0x9.jpg)

### 缩放变换

![](https://ws1.sinaimg.cn/large/006tNc79ly1fl738rbgqfj31kw07rjxo.jpg)

![](https://ws2.sinaimg.cn/large/006tNc79ly1fl739l1s8sj30e40dc0ta.jpg)

### 旋转变换

![](https://ws2.sinaimg.cn/large/006tNc79ly1fl7392sgg7j31kw0n6grh.jpg)

### 反射变换

#### X 轴对称变换

![](https://ws3.sinaimg.cn/large/006tNc79ly1fl77rjjnm8j31kw0mh78d.jpg)

#### Y 轴对称变换

![](https://ws1.sinaimg.cn/large/006tNc79ly1fl77rz51l3j30o90eygmy.jpg)

#### 坐标原点对称变换

![](https://ws2.sinaimg.cn/large/006tNc79ly1fl77s9v1toj31kw0p278v.jpg)

## Quartz 2D 提供的变换

### CTM 变换

#### 概述

CTM：current Transformation Matrix，当前变换矩阵变换，主要函数有：

- CGContextRotateCTM：旋转变换
- CGContextScaleCTM：缩放变换
- CGContextTranslateCTM：平移变换

#### 平移变换

根据指定的 TX、TY 值移动绘图对象的坐标原点

```objective-c
- (void)drawRect:(CGRect)rect {
    // 创建UIImage图片对象
    UIImage *uiImage = [UIImage imageNamed:@"cat"];
    // 将UIImage图片对象转换为CGImage图片对象
    CGImageRef cgImage = uiImage.CGImage;
    // 获取绘制上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    // 定义平移变换,沿 X 轴移动100点，沿 Y 轴移动50点（在 UIKit 坐标系中移动）
    CGContextTranslateCTM (context, 100, 50);
    // 设置绘制区域
    CGRect imageRect = CGRectMake(0, 0, uiImage.size.width, uiImage.size.height);
    // 根据上下文绘制图片
    CGContextDrawImage(context, imageRect, cgImage);    
}
```

#### 缩放变换

根据指定的 SX、SY 缩放因子改变图像的大小，缩放因子 SX、SY 决定新坐标系比原始坐标系大还是小。还可以指定 SX 因子为负数实现 X 轴对称变换，SY 因子为负数实现 Y 轴对称变换

```objective-c
- (void)drawRect:(CGRect)rect {
    // 创建UIImage图片对象
    UIImage *uiImage = [UIImage imageNamed:@"cat"];
    // 将UIImage图片对象转换为CGImage图片对象
    CGImageRef cgImage = uiImage.CGImage;
    // 获取绘制上下文
    CGContextRef context = UIGraphicsGetCurrentContext();  
    // 缩放变换，X 轴缩小到0.5倍，Y 轴缩小到0.75倍（在 Quartz 2D 坐标系基础下缩放，根据缩放后的数值显示在 UIKit 坐标系中）
    CGContextScaleCTM (context, 0.5, 0.75);
    // 设置绘制区域
    CGRect imageRect = CGRectMake(0, 0, uiImage.size.width, uiImage.size.height);
    // 根据上下文绘制图片
    CGContextDrawImage(context, imageRect, cgImage);
}
```

#### 旋转变换

根据指定的旋转角度 SX、SY 来旋转坐标

```objective-c
- (void)drawRect:(CGRect)rect { 
    // 创建UIImage图片对象
    UIImage *uiImage = [UIImage imageNamed:@"cat"];
    // 将UIImage图片对象转换为CGImage图片对象
    CGImageRef cgImage = uiImage.CGImage;
    // 获取绘制上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    // 旋转变换
    CGContextRotateCTM (context, (45.0 * M_PI / 180.0));
    // 设置绘制区域
    CGRect imageRect = CGRectMake(0, 0, uiImage.size.width, uiImage.size.height);
    // 根据上下文绘制图片
    CGContextDrawImage(context, imageRect, cgImage);
}
```

 组合变换

```objective-c
- (void)drawRect:(CGRect)rect {
    // 创建UIImage图片对象
    UIImage *uiImage = [UIImage imageNamed:@"cat"];
    // 将UIImage图片对象转换为CGImage图片对象
    CGImageRef cgImage = uiImage.CGImage;
    // 获取绘制上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    // 组合变换，先进行进行向下的平移变换，再进行 Y 轴对称变换，再
    CGContextTranslateCTM(context, 0, uiImage.size.height);
    CGContextScaleCTM(context, 1, -1);   
    // 设置绘制区域
    CGRect imageRect = CGRectMake(0, 0, uiImage.size.width, uiImage.size.height);
    // 根据上下文绘制图片
    CGContextDrawImage(context, imageRect, cgImage);
}
```

### 仿射变换

能将多次变换的效果累加起来，是 CGAffineTransform 结构体类型，所有仿射变换的返回值都是 CGAffineTransfrom 实例，但是变换的结果连接到 CTM 矩阵才能输出。函数如下：

- CGAffineTransformMakeRotation：创建并初始化旋转矩阵
- CGAffineTransformMakeScale：创建新的缩放矩阵
- CGAffineTransformMakeTranslation：创建新的平移矩阵
- CGAffineTransformRotate：旋转矩阵
- CGAffineTransformScale：缩放矩阵
- CGAffineTransformTranslate：平移矩阵

```objective-c
- (void)drawRect:(CGRect)rect {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"cat" ofType:@"png"];
    // 创建UIImage图片对象
    UIImage *uiImage = [UIImage imageWithContentsOfFile:path];
    // 将UIImage图片对象转换为CGImage图片对象
    CGImageRef cgImage = uiImage.CGImage;
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // 缩放变换：创建缩放矩阵
    CGAffineTransform myAffine = CGAffineTransformMakeScale(1, -1);
    // 平移变换：缩放矩阵乘以平移矩阵
    myAffine = CGAffineTransformTranslate(myAffine, 0, -uiImage.size.height);
    // 连接到CTM矩阵：连接到 CTM 矩阵才能输出结果
    CGContextConcatCTM(context, myAffine);
    
    CGRect imageRect = CGRectMake(0, 0, uiImage.size.width, uiImage.size.height);
    CGContextDrawImage(context, imageRect, cgImage);
    
}

```

