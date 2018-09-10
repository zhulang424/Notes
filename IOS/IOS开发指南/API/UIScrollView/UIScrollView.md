# 属性

## contentSize

ScrollView 中 ContentView 的大小，CGRect 类型

![](https://ws4.sinaimg.cn/large/006tNc79ly1fl0hn8dv1jj319c1vk4qp.jpg)

------

## contentInset

在 ContentView 与 ScrollView 之间的边距，有4个分量：

- top（上边距）
- bottom（下边距）
- left（左边距）
- right（右边距）

![](https://ws3.sinaimg.cn/large/006tNc79ly1fl0howta9zj31b41swty1.jpg)

------

## ontentOffset

ContentView 原点与 ScrollView 原点的偏移量，CGpoint 类型，包含：

-  x（X 轴偏移量）
- y（Y  轴偏移量）

![](https://ws1.sinaimg.cn/large/006tNc79ly1fl0hup0pb7j31a81pcniy.jpg)

------

# 使用

- 实现 UIScrollViewDelegate 协议

```objective-c
@interface ViewController () <UIScrollViewDelegate> // 实现 UIScrollViewDelegate 协议
...
@end
```

- 初始化 UIScrollView 并设置属性

```objective-c
// 初始化 UIScrollView
self.scrollView = [[UIScrollView alloc] init];
self.scrollView.frame = self.view.frame;
// 设置内容大小
self.scrollView.contentSize = CGSizeMake(S_WIDTH * 3, S_HEIGHT);
// 设置是否滑动一整屏
self.scrollView.pagingEnabled = TRUE;
// 设置不显示横向滑动指示器
self.scrollView.showsHorizontalScrollIndicator = FALSE;
// 设置不显示纵向滑动指示器
self.scrollView.showsVerticalScrollIndicator = FALSE;
// 设置代理
self.scrollView.delegate = self;
```

- 向 UIScrollView 中添加内容（ContentView）,并将 UIScrollView 放入父视图

>注意：ContentView 的尺寸要与 ContentSize 一致

```objective-c
self.imageView1 = [[UIImageView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, S_WIDTH, S_HEIGHT)];
self.imageView1.image = [UIImage imageNamed:@"达芬奇-蒙娜丽莎.png"];

self.imageView2 = [[UIImageView alloc] initWithFrame:CGRectMake(S_WIDTH, 0.0f, S_WIDTH, S_HEIGHT)];
self.imageView2.image = [UIImage imageNamed:@"罗丹-思想者.png"];

self.imageView3 = [[UIImageView alloc] initWithFrame:CGRectMake(2 * S_WIDTH, 0.0f, S_WIDTH, S_HEIGHT)];
self.imageView3.image = [UIImage imageNamed:@"保罗克利-肖像.png"];

[self.scrollView addSubview:self.imageView1];
[self.scrollView addSubview:self.imageView2];
[self.scrollView addSubview:self.imageView3];

[self.view addSubview:self.scrollView];
```

- 实现委托方法

```objective-c
#pragma mark - 实现 UIScrollViewDelegate 委托协议
// 每次屏幕滚动时回调的方法
- (void) scrollViewDidScroll: (UIScrollView *) scrollView {
...
}
```

- 整体代码

```objective-c
#import "ViewController.h"
//定义获取屏幕宽度宏
#define S_WIDTH [[UIScreen mainScreen] bounds].size.width
//定义获取屏幕高度宏
#define S_HEIGHT [[UIScreen mainScreen] bounds].size.height

@interface ViewController () <UIScrollViewDelegate> // 实现 UIScrollViewDelegate 协议

@property (strong, nonatomic) UIScrollView *scrollView;
@property (strong, nonatomic) UIPageControl *pageControl;

// 放置三张图片作为 ContentView
@property (strong, nonatomic) UIImageView *imageView1;
@property (strong, nonatomic) UIImageView *imageView2;
@property (strong, nonatomic) UIImageView *imageView3;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 初始化 UIScrollView
    self.scrollView = [[UIScrollView alloc] init];
    self.scrollView.frame = self.view.frame;
    // 设置内容大小
    self.scrollView.contentSize = CGSizeMake(S_WIDTH * 3, S_HEIGHT);
    // 设置是否滑动一整屏
    self.scrollView.pagingEnabled = TRUE;
    // 设置不显示横向滑动指示器
    self.scrollView.showsHorizontalScrollIndicator = FALSE;
    // 设置不显示纵向滑动指示器
    self.scrollView.showsVerticalScrollIndicator = FALSE;
    // 设置代理
    self.scrollView.delegate = self;
    
    self.imageView1 = [[UIImageView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, S_WIDTH, S_HEIGHT)];
    self.imageView1.image = [UIImage imageNamed:@"达芬奇-蒙娜丽莎.png"];
    
    self.imageView2 = [[UIImageView alloc] initWithFrame:CGRectMake(S_WIDTH, 0.0f, S_WIDTH, S_HEIGHT)];
    self.imageView2.image = [UIImage imageNamed:@"罗丹-思想者.png"];
    
    self.imageView3 = [[UIImageView alloc] initWithFrame:CGRectMake(2 * S_WIDTH, 0.0f, S_WIDTH, S_HEIGHT)];
    self.imageView3.image = [UIImage imageNamed:@"保罗克利-肖像.png"];
    
    [self.scrollView addSubview:self.imageView1];
    [self.scrollView addSubview:self.imageView2];
    [self.scrollView addSubview:self.imageView3];
    
    [self.view addSubview:self.scrollView];
}

#pragma mark - 实现 UIScrollViewDelegate 委托协议
// 每次屏幕滚动时调用的方法
- (void) scrollViewDidScroll: (UIScrollView *) scrollView {

}
```

