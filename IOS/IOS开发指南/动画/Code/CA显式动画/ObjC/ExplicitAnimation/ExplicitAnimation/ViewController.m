//
//  ViewController.m
//  ExplicitAnimation
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

@interface ViewController ()

@property(strong, nonatomic) UIImageView *plane;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // 创建并初始化 UIImageView *plane
    CGRect screen = [[UIScreen mainScreen] bounds];
    CGFloat imageWidth = 100;
    CGFloat imageHeight = 100;
    CGFloat imageTopView = 25;
    CGFloat imageLeftView = 20;
    CGRect imageFrame = CGRectMake(imageLeftView, imageTopView, imageWidth, imageHeight);
    self.plane = [[UIImageView alloc] initWithFrame:imageFrame];
    self.plane.image = [UIImage imageNamed:@"clipartPlane.png"];
    self.plane.layer.opacity = 0.25;
    [self.view addSubview:self.plane];

    // 创建并初始化按钮对象
    CGFloat buttonWidth = 130;
    CGFloat buttonHeight = 50;
    CGFloat buttonTopView = 500;
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake((screen.size.width - buttonWidth) / 2, buttonTopView, buttonWidth, buttonHeight);
    [button setImage:[UIImage imageNamed:@"ButtonOutline.png"] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"ButtonOutlineHighlighted.png"] forState:UIControlStateHighlighted];
    [button addTarget:self action:@selector(movePlane:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

#pragma mark - 事件处理：点击按钮
- (void)movePlane:(id)sender {
    
    //// 创建 opacity 动画（针对 CALayer 的 opacity 属性的动画）
    CABasicAnimation *opAnim = [CABasicAnimation animationWithKeyPath:@"opacity"];
    // 设置动画持续时间
    opAnim.duration = 3.0;
    // 设置 opacity 开始值
    opAnim.fromValue = @0.25;   // 数值为0.25的NSNumber对象
    // 设置 opacity 结束值
    opAnim.toValue= @1.0;       // 数值为1.0的SNumber对象
    // 设置累计上次值
    opAnim.cumulative = YES;
    // 设置动画重复2次
    opAnim.repeatCount = 2;
    // 设置动画结束时候处理方式
    opAnim.fillMode = kCAFillModeForwards;  // 表示保持动画结束值
    // 设置动画结束时是否停止
    opAnim.removedOnCompletion = NO;    // 这样设置前面的 fillMode 属性才能起作用,用于防止闪回问题（动画结束后，数值回到原来状态）
    // 添加动画到 CALayer
    [self.plane.layer addAnimation:opAnim forKey:@"animateOpacity"];
    
    //// 创建 CALayer 平移动画
    // 创建平移仿射变换
    CGAffineTransform moveTransform = CGAffineTransformMakeTranslation(200, 300);
    // 创建 CALayer 平移动画
    CABasicAnimation *moveAnim = [CABasicAnimation animationWithKeyPath:@"transform"];
    // 设置动画持续时间
    moveAnim.duration = 6.0;
    // 设置 CALayer 结束位置
    moveAnim.toValue= [NSValue valueWithCATransform3D:
                       CATransform3DMakeAffineTransform(moveTransform)];    // 封装仿射变换矩阵数据结构
    moveAnim.fillMode = kCAFillModeForwards;
    moveAnim.removedOnCompletion = NO;
    [self.plane.layer addAnimation:moveAnim forKey:@"animateTransform"];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
