//
//  ViewController.m
//  KeyframeAnimationPath
//
//  Created by tony on 2017/3/24.
//  本书网站：http://www.51work6.com
//  智捷课堂在线课堂：http://www.zhijieketang.com/
//  智捷课堂微信公共号：zhijieketang
//  作者微博：@tony_关东升
//  作者微信：tony关东升
//  QQ：569418560 邮箱：eorient@sina.com
//  QQ交流群：162030268
//

#import "ViewController.h"

@interface ViewController () <CAAnimationDelegate> // 声明动画协议（IOS 10.0 之后才有）
@property(strong, nonatomic) UIImageView *ball;
@property (strong, nonatomic) UIButton *button;
@end

@implementation ViewController
- (void)viewDidLoad {
    [super viewDidLoad];

    // 初始化 UIImageView *ball
    CGRect screen = [[UIScreen mainScreen] bounds];
    CGFloat imageWidth = 50;
    CGFloat imageHeight = 50;
    CGFloat imageTopView = 150;
    CGRect imageFrame = CGRectMake((screen.size.width - imageWidth) / 2, imageTopView, imageWidth, imageHeight);
    self.ball = [[UIImageView alloc] initWithFrame:imageFrame];
    self.ball.image = [UIImage imageNamed:@"Ball.png"];
    [self.view addSubview:self.ball];

    // 初始化 UIButton *button
    self.button = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.button setImage:[UIImage imageNamed:@"ButtonOutline.png"] forState:UIControlStateNormal];
    [self.button setImage:[UIImage imageNamed:@"ButtonOutlineHighlighted.png"] forState:UIControlStateHighlighted];
    [self.button addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
    CGFloat buttonWidth = 130;
    CGFloat buttonHeight = 50;
    CGFloat buttonTopView = 400;
    self.button.frame = CGRectMake((screen.size.width - buttonWidth) / 2, buttonTopView, buttonWidth, buttonHeight);
    [self.view addSubview: self.button];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 事件处理：点击按钮
- (void)onClick:(id)sender {
    // 设置按钮不可见
    self.button.alpha = 0.0;
    
    // 创建动画路径
    CGMutablePathRef starPath = CGPathCreateMutable();  // 可变路径
    CGPathMoveToPoint(starPath,NULL,160.0, 100.0);      // 设置可变路径的初始路劲
    CGPathAddLineToPoint(starPath, NULL, 100.0, 280.0); // 向可变路径对象中添加路径
    CGPathAddLineToPoint(starPath, NULL, 260.0, 170.0);
    CGPathAddLineToPoint(starPath, NULL, 60.0, 170.0);
    CGPathAddLineToPoint(starPath, NULL, 220.0, 280.0);
    CGPathCloseSubpath(starPath);
    
    //// 针对 CALayer 的 position 属性，创建位置变化的关键帧动画（只有关键帧动画才有 path 属性，才能设置动画路径）
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    // 设置动画持续时间
    animation.duration = 10.0;
    // 设置self为动画委托对象
    animation.delegate = self;
    // 设置动画路径
    animation.path = starPath;
    // 释放动画路径对象（CGMutablePathRef 属于 Core Foundation 框架，需要手动管理内存）
    CFRelease(starPath);
    // 将关键帧动画添加到 CALayer
    [self.ball.layer addAnimation:animation forKey:@"position"];
}

#pragma mark - 实现委托协议 CAAnimationDelegate
// 动画开始方法
- (void)animationDidStart:(CAAnimation *)anim {
    NSLog(@"动画开始...");
}

// 动画结束方法
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    NSLog(@"动画结束...");
    [UIView animateWithDuration:1.0 animations:^{
        //设置按钮完全可见
        self.button.alpha = 1.0;
    }];
}




@end
