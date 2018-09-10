//
//  ViewController.m
//  PageNavigation
//
//  Created by 关东升 on 2016-11-18.
//  本书网站：http://www.51work6.com
//  智捷课堂在线课堂：http://www.zhijieketang.com/
//  智捷课堂微信公共号：zhijieketang
//  作者微博：@tony_关东升
//  作者微信：tony关东升
//  QQ：569418560 邮箱：eorient@sina.com
//  QQ交流群：162030268
//


#import "ViewController.h"

// 定义枚举：翻页的方向
enum DirectionForward
{
    ForwardBefore = 1 //向前
    ,ForwardAfter =2  //向后
};

@interface ViewController () <UIPageViewControllerDataSource,UIPageViewControllerDelegate> {
    // 当前Page的索引
    int pageIndex;
    // 翻页的方向变量
    int directionForward;
}

@property (strong, nonatomic) UIPageViewController *pageViewController;
@property (strong, nonatomic) NSArray *viewControllers;

@end


@implementation ViewController

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
    
    //// 设置当前Page的索引
    pageIndex = 0;
    //// 设置翻页的方向变量
    directionForward = ForwardAfter;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

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


#pragma mark - 实现UIPageViewControllerDelegate协议
// 设置书脊位置和双面显示（可以根据屏幕的旋转方向进行动态设置）
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
    NSLog(@"%d",pageIndex);
}


@end
