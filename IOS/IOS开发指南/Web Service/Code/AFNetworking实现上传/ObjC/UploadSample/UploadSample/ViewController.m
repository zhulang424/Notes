//
//  ViewController.m
//  UploadSample
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
@property(weak, nonatomic) IBOutlet UILabel *label;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

// AFNetworking 实现上传
- (IBAction)onClick:(id)sender {
    // URL
    NSString *uploadStrURL = @"http://www.51work6.com/service/upload.php";
    // 请求参数
    NSDictionary *params = @{@"email" : @"<你的51work6.com用户邮箱>"};
    // 上传文件路径
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"test2" ofType:@"jpg"];
    
    // 请求对象（POST）
    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] multipartFormRequestWithMethod:@"POST"         // 请求类型
                                                                                              URLString:uploadStrURL    // URL
                                                                                             parameters:params          // 请求参数
                                                                              constructingBodyWithBlock:^(id<AFMultipartFormData>formData) {
                      [formData appendPartWithFileURL:[NSURL fileURLWithPath:filePath]      // 上传文件路径
                                                 name:@"file"                       // 数据类型，相当于 HTML 表单中选择文件控件<input type="file">类型
                                             fileName:@"1.jpg"                      // 上传后文件名，可以与本地文件名不通
                                             mimeType:@"image/jpeg"                 // 数据相关 MIME类型
                                                error:nil];
                  } // 请求体代码快
                                                                                                  error:nil];
    // 会话对象（默认）
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    // 会话任务（上传）
    NSURLSessionUploadTask *uploadTask;
    uploadTask = [manager uploadTaskWithStreamedRequest:request     // 请求对象
                   progress:^(NSProgress *uploadProgress) {
                       // 上传进度回调代码快
                       NSLog(@"上传: %@", [uploadProgress localizedDescription]);
                       dispatch_async(dispatch_get_main_queue(), ^{
                           [self.progressView setProgress:uploadProgress.fractionCompleted];
                       });

                   }
                  completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
                      // 任务结束回调代码快
                      if (!error) {
                          NSLog(@"上传成功");
                          [self download];
                      } else {
                          NSLog(@"上传失败: %@", error.localizedDescription);
                      }
                  }];
    // 执行任务
    [uploadTask resume];
    
    self.label.text = @"上传进度";
    self.progressView.progress = 0.0;
}

- (void)download {

    NSString *strURL = [[NSString alloc] initWithFormat:@"http://www.51work6.com/service/download.php?email=%@&FileName=1.jpg", @"<你的51work6.com用户邮箱>"];

    NSURL *url = [NSURL URLWithString:strURL];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];

    NSURLSessionConfiguration *defaultConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:defaultConfig];

    NSURLSessionDownloadTask *downloadTask = [manager downloadTaskWithRequest:request progress:^(NSProgress *downloadProgress) {

        NSLog(@"下载: %@", [downloadProgress localizedDescription]);

        dispatch_async(dispatch_get_main_queue(), ^{
            [self.progressView setProgress:downloadProgress.fractionCompleted animated:TRUE];
        });

    } destination:^NSURL *(NSURL *targetPath, NSURLResponse *response) {

        NSString *downloadsDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, TRUE) objectAtIndex:0];
        NSString *downloadStrPath = [downloadsDir stringByAppendingPathComponent:[response suggestedFilename]];
        NSURL *downloadURLPath = [NSURL fileURLWithPath:downloadStrPath];

        return downloadURLPath;

    } completionHandler:^(NSURLResponse *response, NSURL *filePath, NSError *error) {

        NSLog(@"下载文件保存: %@", filePath);
        NSData *imgData = [[NSData alloc] initWithContentsOfURL:filePath];
        UIImage *img = [UIImage imageWithData:imgData];
        self.imageView1.image = img;

    }];

    [downloadTask resume];

    self.label.text = @"下载进度";
    self.progressView.progress = 0.0;

}

@end
