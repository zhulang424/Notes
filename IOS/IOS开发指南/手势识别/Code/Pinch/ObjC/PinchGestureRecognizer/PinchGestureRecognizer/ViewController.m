//
//  ViewController.m
//  PinchGestureRecognizer
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

@interface ViewController ()
@property (strong, nonatomic) UIImage *imageTrashFull;
@property (strong, nonatomic) UIImageView *imageView;
@property (nonatomic,assign) CGFloat currentScale; // 缩放因子
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //界面初始化
    CGRect screen = [[UIScreen mainScreen] bounds];
    CGFloat imageViewWidth = 128;
    CGFloat imageViewHeight = 128;
    CGFloat imageViewTopView = 300;
    CGRect frame = CGRectMake((screen.size.width - imageViewWidth)/2 , imageViewTopView, imageViewWidth, imageViewHeight);
    self.imageView = [[UIImageView alloc] initWithFrame:frame];
    [self.view addSubview:self.imageView];

    //创建图片对象
    self.imageTrashFull = [UIImage imageNamed:@"Blend Trash Full"];
    self.imageView.image = self.imageTrashFull;
    
    // 创建Pinch手势识别器
    UIPinchGestureRecognizer *recognizer =[[UIPinchGestureRecognizer alloc]
                                            initWithTarget:self
                                            action:@selector(foundPinch:)];
    // Pinch手势识别器关联到imageView
    [self.imageView addGestureRecognizer:recognizer];
    // 设置imageView开启用户事件
    self.imageView.userInteractionEnabled = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - 事件处理：imageView的 Pinch 手势
- (void)foundPinch:(UIPinchGestureRecognizer*)sender {

    NSLog(@"缩放因子 = %f",sender.scale);
    
    if (sender.state == UIGestureRecognizerStateEnded){
        // 结束后保存缩放因子
        self.currentScale = sender.scale;
    } else if (sender.state == UIGestureRecognizerStateBegan && self.currentScale != 0.0f){
        // 手势开始时，将上次保存的缩放因子作为当前缩放因子使用，避免忽大忽小
        sender.scale = self.currentScale;
    }
    
    // 使 imageView 进行缩放变换，第一个参数是 x 轴缩放因子，第二个参数是 y 轴缩放因子（每次缩放都是从正常状态开始缩放，所以需要保存上次缩放因子）
    self.imageView.transform = CGAffineTransformMakeScale(sender.scale, sender.scale);
}

@end
