//
//  ViewController.m
//  DownloadSample
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

@interface ViewController () <NSURLSessionDownloadDelegate>
@property(weak, nonatomic) IBOutlet UIProgressView *progressView;
@property(weak, nonatomic) IBOutlet UIImageView *imageView1;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// 下载
- (IBAction)onClick:(id)sender {
    // URL
    NSString *strURL = [[NSString alloc] initWithFormat:@"http://www.51work6.com/service/download.php?email=%@&FileName=test1.jpg", @"<你的51work6.com用户邮箱>"];
    NSURL *url = [NSURL URLWithString:strURL];
    // 默认会话（委托对象 self）
    NSURLSessionConfiguration *defaultConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:defaultConfig delegate:self delegateQueue:[NSOperationQueue mainQueue]];
    // 会话任务（下载）
    NSURLSessionDownloadTask *downloadTask = [session downloadTaskWithURL:url];
    // 执行会话任务
    [downloadTask resume];

}

#pragma mark - NSURLSessionDownloadDelegate
// 事件处理：正在下载（定期回调，以通知委托下载进度）
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didWriteData:(int64_t)bytesWritten totalBytesWritten:(int64_t)totalBytesWritten totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite {
    // 下载进度
    float progress = totalBytesWritten * 1.0 / totalBytesExpectedToWrite;
    // UI 操作，需要在主队列（主线程所在队列），由于会话配置在主队列，所以以下 UI 操作不用放在 dispatch_async 中执行
    [self.progressView setProgress:progress animated:TRUE];
    NSLog(@"进度= %f", progress);
    NSLog(@"接收: %lld 字节 (已下载: %lld 字节)  期待: %lld 字节.", bytesWritten, totalBytesWritten, totalBytesExpectedToWrite);
}
// 事件处理：下载完成
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didFinishDownloadingToURL:(NSURL *)location {
    // 参数 location 是临时文件（用于保存下载数据）的 URL
    NSLog(@"临时文件: %@\n", location);
    // 应用沙盒 Documents 目录
    NSString *downloadsDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, TRUE) objectAtIndex:0];
    // 下载文件保存路径
    NSString *downloadStrPath = [downloadsDir stringByAppendingPathComponent:@"test1.jpg"];
    NSURL *downloadURLPath = [NSURL fileURLWithPath:downloadStrPath];
    // 如果路径文件文件，删除该文件（否则无法移动临时文件到该路径）
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error = nil;
    if ([fileManager fileExistsAtPath:downloadStrPath]) {
        [fileManager removeItemAtPath:downloadStrPath error:&error];
        if (error) {
            NSLog(@"删除文件失败: %@", error.localizedDescription);
        }
    }
    // 将临时文件移动到保存路径
    error = nil;
    if ([fileManager moveItemAtURL:location toURL:downloadURLPath error:&error]) {
        NSLog(@"文件保存: %@", downloadStrPath);
        UIImage *img = [UIImage imageWithContentsOfFile:downloadStrPath];
        self.imageView1.image = img;
    } else {
        NSLog(@"保存文件失败: %@", error.localizedDescription);
    }
}

@end
