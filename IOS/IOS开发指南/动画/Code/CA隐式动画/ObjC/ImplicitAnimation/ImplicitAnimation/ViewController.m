//
//  ViewController.m
//  ImplicitAnimation
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

    //// 创建并初始化 UIImageView *plane
    CGRect screen = [[UIScreen mainScreen] bounds];
    CGFloat imageWidth = 100;
    CGFloat imageHeight = 100;
    CGFloat imageTopView = 25;
    CGFloat imageLeftView = 20;
    CGRect imageFrame = CGRectMake(imageLeftView, imageTopView, imageWidth, imageHeight);
    self.plane = [[UIImageView alloc] initWithFrame:imageFrame];
    // 设置 plane 的图片属性
    self.plane.image = [UIImage imageNamed:@"clipartPlane.png"];
    // 设置 plane 视图上的图层 opacity 属性（opacity 是 CALayer的属性，表示图层不透明度，与 UIView 的属性 alpha 是一样的属性）
    self.plane.layer.opacity = 0.25;
    // 添加 plane 到当前视图
    [self.view addSubview:self.plane];

    // 创建按并初始化钮对象
    CGFloat buttonHeight = 50;
    CGFloat buttonTopView = 500;
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];CGFloat buttonWidth = 130;
    button.frame = CGRectMake((screen.size.width - buttonWidth) / 2, buttonTopView, buttonWidth, buttonHeight);
    [button setImage:[UIImage imageNamed:@"ButtonOutline.png"] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"ButtonOutlineHighlighted.png"] forState:UIControlStateHighlighted];
    [button addTarget:self action:@selector(movePlane:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - 事件处理：点击按钮
- (void)movePlane:(id)sender {
    // 创建平移仿射变换
    CGAffineTransform moveTransform = CGAffineTransformMakeTranslation(200, 300);
    // 将仿射变换作用于 plane 视图上的 CALayer
    self.plane.layer.affineTransform = moveTransform;
    // 设置层的opacity属性
    self.plane.layer.opacity = 1;
}


@end
