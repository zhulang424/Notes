//
//  ViewController.m
//  LayerSample
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

@property(nonatomic) CALayer *ballLayer;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 读取图片创建UIImage对象
    UIImage *image = [UIImage imageNamed:@"Ball2.png"];

    // 创建层ballLayer对象
    self.ballLayer = [CALayer layer];
    // 设置层ballLayer对象
    // 设置层内容(CALayer 的 contents 属性可以接受 CGImage 类型的图片或者其他 CALayer 的内容，CGImage 类型在 OC 中的引用类型是 CGImageRef）
    self.ballLayer.contents = (__bridge id)(image.CGImage); // (__bridge id)用于将 Core Foundation 对象转换成 OC 对象，该转换不会改变对象所有权
    // 设置层内容布局方式
    self.ballLayer.contentsGravity = kCAGravityResizeAspect; // 表示内容保持宽高比原样重新调整
    // 设置层的边界
    self.ballLayer.bounds = CGRectMake(0.0, 0.0, 125.0, 125.0);
    // 设置层的位置（中心点坐标）
    self.ballLayer.position = CGPointMake(CGRectGetMidX(self.view.bounds),  // 视图中心点 X 坐标
                                          CGRectGetMidY(self.view.bounds)); // 视图中心点 Y 坐标
    // 添加ballLayer层到当前层
    [self.view.layer addSublayer:self.ballLayer];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
