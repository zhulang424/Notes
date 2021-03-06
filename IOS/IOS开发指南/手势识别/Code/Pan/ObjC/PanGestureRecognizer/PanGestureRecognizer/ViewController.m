//
//  ViewController.m
//  PanGestureRecognizer
//
//  Created by tony on 2017/3/20.
//  本书网站：http://www.51work6.com
//  智捷课堂在线课堂：http://www.zhijieketang.com/
//  智捷课堂微信公共号：zhijieketang
//  作者微博：@tony_关东升
//  作者微信：tony关东升
//  QQ：569418560 邮箱：eorient@sina.com
//  QQ交流群：162030268
//

#import "ViewController.h"

@interface ViewController () {
    BOOL boolTrashEmptyFlag;//垃圾桶是否为空标志：NO-桶满；YES-桶空
}

@property(strong, nonatomic) UIImage *imageTrashFull;
@property(strong, nonatomic) UIImage *imageTrashEmpty;

@property(strong, nonatomic) UIImageView *imageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    //界面初始化
    CGRect screen = [[UIScreen mainScreen] bounds];
    CGFloat imageViewWidth = 128;
    CGFloat imageViewHeight = 128;
    CGFloat imageViewTopView = 148;
    CGRect frame = CGRectMake((screen.size.width - imageViewWidth) / 2, imageViewTopView, imageViewWidth, imageViewHeight);
    self.imageView = [[UIImageView alloc] initWithFrame:frame];
    [self.view addSubview:self.imageView];

    //创建图片对象
    self.imageTrashFull = [UIImage imageNamed:@"Blend Trash Full"];
    self.imageTrashEmpty = [UIImage imageNamed:@"Blend Trash Empty"];

    self.imageView.image = self.imageTrashFull;

    // 创建Pan手势识别器
    UIPanGestureRecognizer *recognizer = [[UIPanGestureRecognizer alloc]
            initWithTarget:self
                    action:@selector(foundPan:)];
    // 设置Pan手势识别器属性
    recognizer.minimumNumberOfTouches = 1; // 手势要求最少触点
    recognizer.maximumNumberOfTouches = 1; // 手势要求最多触点

    // Pan手势识别器关联到imageView（已开启用户事件）
    [self.imageView addGestureRecognizer:recognizer];
    
    //设置imageView开启用户事件
    self.imageView.userInteractionEnabled = YES;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - 事件处理：拖动 imageView
- (void)foundPan:(UIPanGestureRecognizer *)sender {

    NSLog(@"拖动 state = %li", (long) sender.state);

    if (sender.state != UIGestureRecognizerStateEnded && sender.state != UIGestureRecognizerStateFailed) {
        CGPoint location = [sender locationInView:sender.view.superview]; // 获取触点在 imageView 父视图中的坐标
        NSLog(@"%@",[NSValue valueWithCGPoint:location]);
        sender.view.center = location; // 更新 imageView 的 center 坐标，使其随手指移动

        CGPoint translationPoint = [sender translationInView:sender.view.superview]; // 获取触点在 imageView 父视图中移动距离
        NSLog(@"%@",[NSValue valueWithCGPoint:translationPoint]);
    }
//    if (sender.state == UIGestureRecognizerStateChanged) {
//        CGPoint location = [sender locationInView:sender.view.superview]; // 获取触点在 imageView 父视图中的坐标
//        NSLog(@"%@",[NSValue valueWithCGPoint:location]);
//        sender.view.center = location; // 更新 imageView 的 center 坐标，使其随手指移动
//    }
}


@end
