# 概述

分屏指示器，用于显示当前屏幕所在位置，与 UIScrollView（分屏滚动） 联合使用

![](https://ws4.sinaimg.cn/large/006tNc79ly1fl0ikddn2zj30ke02adi2.jpg)

# 使用

- 初始化

```objective-c
// 初始化 UIPageControl
CGFloat pageControlWidth  = 300;
CGFloat pageControlHeight = 37;
self.pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake((S_WIDTH - pageControlWidth) / 2, S_HEIGHT - pageControlHeight, pageControlWidth, pageControlHeight)];
// 设置分屏数量
self.pageControl.numberOfPages = 3;
// 设置响应点击事件的方法(点击原点左右两边，可以触发该事件)
[self.pageControl addTarget:self action:@selector(changePage:) forControlEvents: UIControlEventValueChanged];
[self.view addSubview:self.pageControl];
```

- 实现点击事件处理方法

```objective-c
#pragma mark - 实现 UIPageControl 事件处理
- (void)changePage:(id)sender {
    [UIView animateWithDuration:0.3f animations:^{
        NSInteger whichPage = self.pageControl.currentPage;
        self.scrollView.contentOffset = CGPointMake(S_WIDTH * whichPage, 0.0f);
    }];
}
```

