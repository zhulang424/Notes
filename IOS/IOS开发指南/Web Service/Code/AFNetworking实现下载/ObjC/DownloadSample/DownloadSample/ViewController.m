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
#import "AFNetworking.h"

@interface ViewController ()

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


- (IBAction)onClick:(id)sender {
    // URL
    NSString *strURL = [[NSString alloc] initWithFormat:@"http://www.51work6.com/service/download.php?email=%@&FileName=test1.jpg", @"<你的51work6.com用户邮箱>"];
    NSURL *url = [NSURL URLWithString:strURL];
    //  GET 请求对象
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    // 默认会话配置对象
    NSURLSessionConfiguration *defaultConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
    // 会话对象（AFURLSessionManager）
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:defaultConfig];
    // 会话任务（下载）
    NSURLSessionDownloadTask *downloadTask = [manager downloadTaskWithRequest:request progress:^(NSProgress *downloadProgress) {
        // 获取当前下载进度（downloadProgress 表示下载进度）
        NSLog(@"%@", [downloadProgress localizedDescription]);
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.progressView setProgress:downloadProgress.fractionCompleted animated:TRUE];   // downloadProgress.fractionCompleted 下载进度的分数表现方式
        }); // 根据 downloadProgress 更新 UI 组件（在主队列）

    } destination:^NSURL *(NSURL *targetPath, NSURLResponse *response) {
        // 设置下载文件路径
        NSString *downloadsDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, TRUE) objectAtIndex:0];    //在沙盒目录中的 Document 目录
        NSString *downloadStrPath = [downloadsDir stringByAppendingPathComponent:[response suggestedFilename]]; // 文件名是推荐文件名
        NSURL *downloadURLPath = [NSURL fileURLWithPath:downloadStrPath];

        return downloadURLPath;

    } completionHandler:^(NSURLResponse *response, NSURL *filePath, NSError *error) {
        // 下载完成回调代码
        NSLog(@"File downloaded to: %@", filePath);
        NSData *imgData = [[NSData alloc] initWithContentsOfURL:filePath];
        UIImage *img = [UIImage imageWithData:imgData];
        self.imageView1.image = img;

    }];
    // 执行任务
    [downloadTask resume];
}

@end
