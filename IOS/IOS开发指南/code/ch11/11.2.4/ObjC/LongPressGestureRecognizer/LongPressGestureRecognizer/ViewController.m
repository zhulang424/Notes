//
//  ViewController.m
//  LongPressGestureRecognizer
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
{
    BOOL boolTrashEmptyFlag;//垃圾桶是否为空标志：NO-桶满；YES-桶空
}

@property (strong, nonatomic) UIImage *imageTrashFull;
@property (strong, nonatomic) UIImage *imageTrashEmpty;

@property (strong, nonatomic) UIImageView *imageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 初始化 imageView
    CGRect screen = [[UIScreen mainScreen] bounds];
    CGFloat imageViewWidth = 128;
    CGFloat imageViewHeight = 128;
    CGFloat imageViewTopView = 148;
    CGRect frame = CGRectMake((screen.size.width - imageViewWidth)/2 , imageViewTopView, imageViewWidth, imageViewHeight);
    self.imageView = [[UIImageView alloc] initWithFrame:frame];
    [self.view addSubview:self.imageView];
    // 创建图片对象
    self.imageTrashFull = [UIImage imageNamed:@"Blend Trash Full"];
    self.imageTrashEmpty = [UIImage imageNamed:@"Blend Trash Empty"];
    self.imageView.image = self.imageTrashFull;
    // 设置imageView开启用户事件
    self.imageView.userInteractionEnabled = YES;
    
    // 创建Long Press手势识别器
    UILongPressGestureRecognizer *recognizer =[[UILongPressGestureRecognizer alloc]
                                               initWithTarget:self
                                               action:@selector(foundLongPress:)];
    // 设置Long Press手势识别器属性
    recognizer.allowableMovement = 100.0f; // 在 failed 前，最大允许手指移动距离，单位是点，默认是10
    recognizer.minimumPressDuration = 1.0; // 手指最短持续时间，单位是秒，默认是0.5
    // Long Press手势识别器关联到imageView
    [self.imageView addGestureRecognizer:recognizer];


}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - 事件处理：长按 imageView
- (void)foundLongPress:(UILongPressGestureRecognizer*)sender {
    NSLog(@"长按 state = %li",(long)sender.state);
    // state = 1：began 状态
    // state = 2：changed 状态
    // state = 3：ended 状态
    
    
    if (sender.state == UIGestureRecognizerStateBegan) { //手势开始
        if (boolTrashEmptyFlag) {
            self.imageView.image = self.imageTrashFull;
            boolTrashEmptyFlag = NO;
        } else {
            self.imageView.image = self.imageTrashEmpty;
            boolTrashEmptyFlag = YES;
        }
    }
}


@end
