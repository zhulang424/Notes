//
//  ViewController.m
//  UploadDownload
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

@interface ViewController ()

@property(nonatomic, strong) NSTimer *timer;
@property (strong, nonatomic) UIActivityIndicatorView *activityIndicatorView;
@property (strong, nonatomic) UIProgressView *progressView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    
    CGRect screen = [[UIScreen mainScreen] bounds];
    
    // 创建指示器
    self.activityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle: UIActivityIndicatorViewStyleWhiteLarge];
    
    // 重新设置指示器的位置
    CGRect frame = self.activityIndicatorView.frame;
    frame.origin = CGPointMake((screen.size.width - frame.size.width) / 2, 84);
    self.activityIndicatorView.frame = frame;
    
    // 设置指示器停止活动时隐藏
    self.activityIndicatorView.hidesWhenStopped = YES;
    
    // 设置指示器在显示时处于活动状态
    [self.activityIndicatorView startAnimating];
    
    // 判断指示器是否处于活动状态
//    if (self.activityIndicatorView.animating) {
//
//    }
    
    [self.view addSubview:self.activityIndicatorView];
    
    ///2.Upload按钮
    UIButton* buttonUpload = [UIButton buttonWithType:UIButtonTypeSystem];
    [buttonUpload setTitle:@"Upload" forState:UIControlStateNormal];
    
    CGFloat buttonUploadWidth = 50;
    CGFloat buttonUploadHeight = 30;
    CGFloat buttonUploadTopView = 190;
    
    buttonUpload.frame = CGRectMake((screen.size.width - buttonUploadWidth)/2 , buttonUploadTopView, buttonUploadWidth, buttonUploadHeight);
    
    //指定事件处理方法
    [buttonUpload addTarget:self action:@selector(startToMove:) forControlEvents: UIControlEventTouchUpInside];
    [self.view addSubview:buttonUpload];
    
    ///3.进度条
    CGFloat progressViewWidth = 200;
    CGFloat progressViewHeight = 2;
    CGFloat progressViewTopView = 283;
    
    // 创建 ProgressView
    self.progressView = [[UIProgressView alloc] initWithFrame:CGRectMake((screen.size.width - progressViewWidth)/2 , progressViewTopView, progressViewWidth, progressViewHeight)];
    
    [self.view addSubview: self.progressView];
    
    ///4.Download按钮
    UIButton* buttonDownload = [UIButton buttonWithType:UIButtonTypeSystem];
    [buttonDownload setTitle:@"Download" forState:UIControlStateNormal];
    
    CGFloat buttonDownloadWidth = 69;
    CGFloat buttonDownloadHeight = 30;
    CGFloat buttonDownloadTopView = 384;
    
    buttonDownload.frame = CGRectMake((screen.size.width - buttonDownloadWidth)/2 , buttonDownloadTopView, buttonDownloadWidth, buttonDownloadHeight);
    //指定事件处理方法
    [buttonDownload addTarget:self action:@selector(downloadProgress:) forControlEvents: UIControlEventTouchUpInside];
    [self.view addSubview:buttonDownload];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)startToMove:(id)sender {
    if (self.activityIndicatorView.isAnimating) {
        [self.activityIndicatorView stopAnimating];
        NSLog(@"%@",[NSValue valueWithCGRect:self.activityIndicatorView.frame]);
    }else{
        [self.activityIndicatorView startAnimating];
    }
}

- (void)downloadProgress:(id)sender {
    // 每间隔1秒，给 self 发送 download 消息，消息参数为 nil，重复发送，直到 NSTimer 无效
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0
                                                  target:self
                                                selector:@selector(download)
                                                userInfo:nil
                                                 repeats:YES];
}

// 定时器事件
-(void)download{
    // 进度值域 0.0 ~ 1.0
    // 每秒钟进度增加 0.1
    self.progressView.progress = self.progressView.progress + 0.1;
    
    // 进度值为 1.0 时，取消定时器
    if (self.progressView.progress == 1.0) {
        [self.timer invalidate];
    }
}

@end
