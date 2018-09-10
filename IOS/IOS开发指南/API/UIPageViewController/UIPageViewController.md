# 概述

- 管理多个页面组成的内容的视图控制器，每个页面对应一个子 ViewController
- 没有具体的视图，是一个容器类

# 属性

- doubleSided（双面显示）：在页面翻起时，下一页的内容是否在背面显示
- spineLocation（书脊位置）：只读，需要通过委托方法设定
  -  UIPageViewControllerSpineLocationMin：书脊位置在书的最左边（或最上边），书从右向左翻（或从下往上翻）
  - UIPageViewControllerSpineLocationMax：书脊位置在书的最右边（或最下边），书从左向右翻（或从上往下翻）
  - UIPageViewControllerSpineLocationMid：书脊位置在书中间（双页同时显示时使用）

#  使用

## 引入数据源、委托协议

```objective-c
#import "ViewController.h"

//翻页的方向
enum DirectionForward
{
    ForwardBefore = 1 //向前
    ,ForwardAfter =2  //向后
};

@interface ViewController () <UIPageViewControllerDataSource,UIPageViewControllerDelegate> {
    //当前Page的索引
    int pageIndex;
    //翻页的方向变量
    int directionForward;
}
@property (strong, nonatomic) UIPageViewController *pageViewController;
@property (strong, nonatomic) NSArray *viewControllers;
@end
```

## 初始化 UIPageViewController

```objective-c
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //// 初始化构成内容的 ViewController
    // 页面1
    UIViewController *page1ViewController = [[UIViewController alloc] init];
    UIImageView *imageView1 = [[UIImageView alloc] initWithFrame:self.view.frame];
    imageView1.image = [UIImage imageNamed:@"达芬奇-蒙娜丽莎.png"];
    [page1ViewController.view addSubview:imageView1];
    // 页面2
    UIViewController *page2ViewController = [[UIViewController alloc] init];
    UIImageView *imageView2 = [[UIImageView alloc] initWithFrame:self.view.frame];
    imageView2.image = [UIImage imageNamed:@"罗丹-思想者.png"];
    [page2ViewController.view addSubview:imageView2];
    // 页面3
    UIViewController *page3ViewController = [[UIViewController alloc] init];
    UIImageView *imageView3 = [[UIImageView alloc] initWithFrame:self.view.frame];
    imageView3.image = [UIImage imageNamed:@"保罗克利-肖像.png"];
    [page3ViewController.view addSubview:imageView3];
    // 将页面放入数组
    self.viewControllers = @[page1ViewController, page2ViewController, page3ViewController];
    
    //// 初始化 UIPageViewController
    // transitionStyle：页面翻转的样式（PageCurl：翻书效果，Scroll：滑屏效果）
    // navigationOrientation：翻页方向（Horizontal：水平，Vertical：垂直）
    
    self.pageViewController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStylePageCurl
                                                              navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal
                                                                            options:nil];
    self.pageViewController.delegate = self;
    self.pageViewController.dataSource = self;
    
    //// 设置首页（与书脊类型有关，如果是 min 或 max，是单页显示，首页只设置一个视图；如果是 mid，双页显示，需要设置两个视图作为首页）
    // direction：翻页动画方向（Forward：向前，Reverse：向后）
    [self.pageViewController setViewControllers:@[page1ViewController]
                                      direction:UIPageViewControllerNavigationDirectionForward
                                       animated:TRUE
                                     completion:nil];
    // 将 UIPageViewController 添加到父视图
    [self.view addSubview:self.pageViewController.view];
    
    // 设置当前Page的索引
    pageIndex = 0;
    // 设置翻页的方向变量
    directionForward = ForwardAfter;
}
```

## 实现数据源方法

### @required

```objective-c
#pragma mark - 实现UIPageViewControllerDataSource协议
//// @required
// 返回前一个视图控制器，用于上一个页面的显示
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    
    pageIndex--;
    
    if (pageIndex < 0){
        pageIndex = 0;
        return nil;
    }
    
    directionForward = ForwardBefore;
    return self.viewControllers[pageIndex];
}

// 返回后一个视图控制器，用于下一个页面的显示
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    pageIndex++;
    
    if (pageIndex > 2){
        pageIndex = 2;
        return nil;
    }
    
    directionForward = ForwardAfter;
    return self.viewControllers[pageIndex];
}
```

### @optional

当transitionStyle（页面翻转的样式）设置为Scroll（滑屏效果）时，可以实现下面两个方法以显示分屏指示器（不实现下面方法不显示分屏指示器）

![](https://ws4.sinaimg.cn/large/006tNc79ly1fl0m514dlsj319208a0uf.jpg)

## 实现委托方法

```objective-c
#pragma mark - 实现UIPageViewControllerDelegate协议
- (UIPageViewControllerSpineLocation)pageViewController:(UIPageViewController *)pageViewController spineLocationForInterfaceOrientation:(UIInterfaceOrientation)orientation {
    // 单面显示
    self.pageViewController.doubleSided = FALSE;
    // 书脊位置在最左边
    return UIPageViewControllerSpineLocationMin;
}

// 翻页动作完成后出发，可以用于判断用户是否成功翻到了下一页（用户可能翻了一点点，然后放弃翻页）
- (void)pageViewController:(UIPageViewController *)pageViewController
        didFinishAnimating:(BOOL)finished
   previousViewControllers:(NSArray *)previousViewControllers
       transitionCompleted:(BOOL)completed {
    // 通过“completed”参数可以判断是否成功进行了翻页，如果没有成功翻页，需要将记录页码的变量回复之前的状态（根据刚刚的翻页方向）
    if (!completed) {
        // 向后翻页未完成时，页码数减一
        if (directionForward == ForwardAfter) {
            pageIndex--;
        }
        // 向前翻页未完成时，页码数加一
        if (directionForward == ForwardBefore) {
            pageIndex++;
        }
    }
}
```

