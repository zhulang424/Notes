Web Service 技术通过 Web 协议提供服务，保证不通平台的应用服务可以相互操作，为客户端提供不同的服务

3种主流的 Web Service 实现方案有REST、SOAP、XML-RPC，REST 风格的 Web Service 更加简洁

# 概述

## REST 风格的 Web Serivice

- REST，表征状态转移，“表征”指客户端看到的页面，“状态转移”指页面跳转，客户端通过请求 URI 来获得要显示的页面
- REST 只是一种设计风格，不是设计标准，泛指采用 HTTP 和 HTTPS 等传输协议并通过 URI 定位资源的 Web Service
- 数据交换格式主要采用 JSON 和 XML
- 支持的 HTTP 请求包括 POST、GET、PUT、DELETE 等

## HTTP 协议

- HTTP 是“超文本传输协议”，一个应用层的面向对象的协议
  - 特点是简洁、快速
  - 使用的基本协议是 TCP/IP 协议（HTTP、HTTPS、FTP 等都是简历在 TCP/IP 协议上的应用层协议）
- HTTP 协议是无连接协议，支持 C/S 网络结构：每一次请求时建立链接，服务器处理完客户端的请求后，应答给客户端，然后断开链接，不会一直占用网络资源
- HTTP/1.1 协议定义了8中请求方法：GET（使用较多）、POST（使用较多）、OPTIONS、HEAD、PUT、DELETE、TRACE、CONNECT，GET、POST 
  - GET方法：请求数据，向指定的资源发出请求，发送的信息“显式”地跟在 URL 后面
    - GET 方法是不安全的：发送的信息任何人都可以看到
  - POST 方法：提交数据，向指定的资源提交数据，请求服务器进行处理（例如：提交表单或上传文件等）
    - POST 方法是安全的：数据被包含在请求体中，所以是安全的
- Web Service 主要使用 HTTP 协议

## HTTPS 协议

- HTTPS 是“超文本传输安全协议”，是超文本传输协议和 SSL 的组合，用以提供加密通信和对网络服务器身份的鉴定
- HTTP 和 HTTP 的升级版：
  - HTTPS 使用 “https://” 代替“http://”
  -  HTTPS 使用端口443，HTTP 使用端口80
- HTTPS 和 SSL 支持使用 X.509数字认证，如果需要的话，用户可以确认发送者是谁

## 苹果 ATS 限制

- IOS 9开始，苹果要求所有网络请求通信必须采用 HTTPS 协议，否则会报错
  - 可以通过 info.plist 中设置 NSAllowArbitraryLoads 为 YES 跳过 ATS 限制
- **IOS 10开始，苹果强制要求必须使用 HTTPS 协议，无法跳过 ATS限制，但是可以设置 ATS 白名单来使用 HTTP**
  - 设置 ATS 白名单
    - 在 Info.plist 中添加“App Transport Security Settings”键
    - 在“App Transport Security Settings”键下添加“Exception Domains”键
    - 在“Exception Domains”键下添加域名
    - 在域名下可以添加详细设置
      - NSIncludesSubdomains：是否包括子域名
      - NSExceptionRequiresForwardSecrecy：是否支持正向保密（旨在避免长期使用一个密钥所引起的不安全问题：要求一个密钥只能访问由它保护的数据；用来产生密钥的元素一次一换，不能再产生其他密钥；一个密钥被破解，并不影响其他密钥的安全性）
      - NSExceptionAllowsInsecureHTTPLoads：是否允许不安全 HTTP 加载
      - NSExceptionMinimumTLSVersion：设置传输层安全协议最小版本，默认是 TLSV1.2

![](https://ws1.sinaimg.cn/large/006tNc79ly1flbmqi9ev0j31kw0qxdvm.jpg)

![](https://ws1.sinaimg.cn/large/006tNc79ly1flbmqmz1z0j31kw17b47o.jpg)

# NSURLSession

## 概述

IOS 7之后苹果提供的网络通信 API

- 支持 HTTP、HTTPS、FT 等网络通信协议
- 支持后台下载、上传、断点续传
- 支持取消、恢复、挂起网络请求
- 可以为每个用户会话（session）配置缓存、协议、cookie
- 支持安全整数策略

## API

- 类
  - NSURLSession
  - NSURLSessionConfiguration
  - NSURLSessionTask
- 协议
  - NSURLSessionDelegate
  - NSURLSessionTaskDelegate
  - NSURLSessionDataDelegate
  - NSURLSessionDownloadDelegate

### 会话 NSURLSession

应用与服务器建立的通信对象，负责数据传输任务，一个应用可以建立多个会话，每个会话协调一组数据传输任务，可以创建4种形式的会话：

- 简单会话

  - 不可配置，只能执行基本的网络情况

  - ```objective-c
    // 简单会话
    NSURLSession *session = [NSURLSession sharedSession];
    ```

- 默认会话（default session）

  - 可以配置会话

  - ```objective-c
    // 会话配置类
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    // 默认会话
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration];
    ```

- 短暂会话（ephemeral session）

  - 不存储任何数据在磁盘，会话的所有数据都是缓存的，保存在内存中，包括证书

  - ```objective-c
    // 短暂会话配置对象
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration ephemeralSessionConfiguration];
    // 短暂会话对象
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration];
    ```

- 后台会话（background session）

  - 应用在后台运行时，可以在后台执行上传、下载数据任务

  - ```objective-c
    // 后台会话配置对象
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration backgroundSessionConfigurationWithIdentifier:nil];
    // 后台会话对象
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration];
    ```

### 会话任务 NSURLSessionTask

会话总是基于任务的，包括3中形式：

![](https://ws2.sinaimg.cn/large/006tNc79ly1flbuk6y6qlj31kw0lcwiq.jpg)

- 数据任务（NSURLSessionDataTask）：请求网络资源，从服务器返回一个或多个 NSData 对象
  - 支持：简单会话、默认会话、短暂会话
  - 不支持：后台会话
- 上传任务（NSURLSessionUploadTask）：以文件形式发送数据
  - 支持：后台会话
  - 不支持：
- 下载任务（NSURLSessionDownloadTask）：以文件形式接受数据
  - 支持：后台会话
  - 不支持：

**注：所有任务都可以取消、暂停、恢复，默认情况下，任务是暂停的，所以创建任务后，需要恢复任务才能执行**

## 实现 GET 请求

### 简单会话实现 GET 请求

```objective-c
// 简单会话实现 GET 请求
- (void)startRequest {
    // URL 对象
    NSString *strURL = [[NSString alloc] initWithFormat:@"http://www.51work6.com/service/mynotes/WebService.php?email=%@&type=%@&action=%@", @"<你的51work6.com用户邮箱>", @"JSON", @"query"];
    strURL = [strURL stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];  // 将字符串编码为 URL 字符串（URL 中不能有中文和特殊字符，必须进行编码），使用 URLQueryAllowedCharacterSet 字符集（带有请求参数的 URL 字符串允许的字符集）
    NSURL *url = [NSURL URLWithString:strURL];
    // GET请求 对象
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    // 简单会话 对象
    NSURLSession *session = [NSURLSession sharedSession];
    // 数据任务 对象
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:
        ^(NSData *data, NSURLResponse *response, NSError *error) {
        NSLog(@"请求完成...");
        if (!error) {
            // 解析返回数据（JSON）
            NSDictionary *resDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
            // 重新加载视图（调整视图需要在 GCD 主队列执行，而默认情况下，简单会话不是在主队列中执行）
            dispatch_async(dispatch_get_main_queue(), ^{
                [self reloadView:resDict];
            });
        } else {
            NSLog(@"error : %@", error.localizedDescription);
        }
    }];
    // 执行任务（新创建的任务默认情况默认情况下是暂停的，需要恢复任务才能执行）
    [task resume];
}
```

### 默认会话实现 GET 请求

```objective-c
// 默认会话实现 GET 请求
- (void)startRequest {
    // URL
    NSString *strURL = [[NSString alloc] initWithFormat:@"http://www.51work6.com/service/mynotes/WebService.php?email=%@&type=%@&action=%@", @"<你的51work6.com用户邮箱>", @"JSON", @"query"];
    strURL = [strURL stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSURL *url = [NSURL URLWithString:strURL];
    // 请求
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    // 默认会话配置 对象
    NSURLSessionConfiguration *defaultConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
    /**
     默认会话
     delegate：会话委托对象，一般用于下载会话，请求任务完成后回调 delegate 相关方法
     delegateQueue：设置会话任务执行在哪个队列
     */
    NSURLSession *session = [NSURLSession sessionWithConfiguration: defaultConfig delegate: nil delegateQueue: [NSOperationQueue mainQueue]];
    // 会话任务（数据）
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:
        ^(NSData *data, NSURLResponse *response, NSError *error) {
        NSLog(@"请求完成...");
        if (!error) {
            NSDictionary *resDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
            //dispatch_async(dispatch_get_main_queue(), ^{
            // 会话任务在主线程执行，所以不需要放到并发队列中执行了
            [self reloadView:resDict];  
            //});
        } else {
            NSLog(@"error : %@", error.localizedDescription);
        }
    }];
    // 执行任务
    [task resume];
}
```

## 实现 POST 请求

用 NSMutableURLRequest 替换 NSURLRequest

```objective-c
// 实现 POST 请求
- (void)startRequest {
    // URL
    NSString *strURL = @"http://www.51work6.com/service/mynotes/WebService.php";
    NSURL *url = [NSURL URLWithString:strURL];
    // 请求体（请求参数）
    NSString *post = [NSString stringWithFormat:@"email=%@&type=%@&action=%@", @"<你的51work6.com用户邮箱>", @"JSON", @"query"];
    NSData *postData = [post dataUsingEncoding:NSUTF8StringEncoding];   // 请求体是 NSData 类型，所以将请求参数字符串转换成 NSData 类型，编码一定要用 UTF-8
    // POST请求 对象
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"POST"];    // 设置为 POST 类型请求
    [request setHTTPBody:postData];     // 设置请求参数

    // 默认会话
    NSURLSessionConfiguration *defaultConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration: defaultConfig delegate: nil delegateQueue: [NSOperationQueue mainQueue]];
    // 数据会话任务
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:
        ^(NSData *data, NSURLResponse *response, NSError *error) {
        NSLog(@"请求完成...");
        if (!error) {
            NSDictionary *resDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
            //dispatch_async(dispatch_get_main_queue(), ^{
            [self reloadView:resDict];
            //});
        } else {
            NSLog(@"error : %@", error.localizedDescription);
        }
    }];
    // 执行任务
    [task resume];
}
```

## 下载

- 需要使用下载任务类：NSURLSessionDownloadTask 实现下载数据
- 支持会话：简单会话、默认会话、后台会话

注：**想要知道下载进度、能够支持短点续传等，需要使用默认会话**。需要实现 NSURLSessionDownloadDelegate 委托协议来接受服务器回调事件（不嫩更实用代码快接受服务器回调事件）

```objective-c
#import "ViewController.h"
@interface ViewController () <NSURLSessionDownloadDelegate>		// 实现协议
@end
@implementation ViewController
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
  	// bytesWritten：跟上一次执行该方法时相比，下载了多少数据
  	// totalBytesWritten：总计下载了多少数据
  	// totalBytesExpectedToWrite：总共需要下载多少数据
    
  	// 下载进度
    float progress = totalBytesWritten * 1.0 / totalBytesExpectedToWrite;
    // UI 操作，需要在主队列（主线程所在队列），由于会话配置在主队列，所以以下 UI 操作不用放在 dispatch_async 中执行
    [self.progressView setProgress:progress animated:TRUE];
    NSLog(@"进度= %f", progress);
    NSLog(@"接收: %lld 字节 (已下载: %lld 字节)  期待: %lld 字节.", bytesWritten, totalBytesWritten, totalBytesExpectedToWrite);
}

// 事件处理：下载完成
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didFinishDownloadingToURL:(NSURL *)location {
    // location 是临时文件（用于保存下载数据）的 URL
    
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
```

## 上传

使用 NSURLSessionUploadTask 实现

注：上传数据需要模拟 HTML 表单，数据采用 multipart/form-data 格式（将数据分割成小段上传），使用NSURLSessionUploadTask实现非常复杂，所以不推荐使用。**推荐使用第三方框架实现上传任务**。

## 综合使用

建议使用 POST 方法，因为 GET 请求的是静态资源，数据传输过程也不安全，而 POST 主要请求动态资源

### 接口文档

![](https://ws4.sinaimg.cn/large/006tNc79ly1flbzkapb4mj31kw0aotd1.jpg)

### 代码

#### 插入方法

```objective-c
- (void)startRequest {

    // 准备参数
    NSDate *date = [[NSDate alloc] init];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *dateStr = [dateFormatter stringFromDate:date];
    // 请求体
    NSString *post = [NSString stringWithFormat:@"email=%@&type=%@&action=%@&date=%@&content=%@",
                                                @"<你的51work6.com用户邮箱>", @"JSON", @"add", dateStr, self.txtView.text];
    NSData *postData = [post dataUsingEncoding:NSUTF8StringEncoding];
    // URL
    NSString *strURL = @"http://www.51work6.com/service/mynotes/WebService.php";
    NSURL *url = [NSURL URLWithString:strURL];
	// POST请求
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:postData];
	// 默认会话
    NSURLSessionConfiguration *defaultConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:defaultConfig delegate:nil delegateQueue:[NSOperationQueue mainQueue]];
	// 数据会话任务
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:
            ^(NSData *data, NSURLResponse *response, NSError *error) {
                NSLog(@"请求完成...");
                if (!error) {
                    NSDictionary *resDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];

                    NSNumber *resultCode = resDict[@"ResultCode"];
                    NSString *message = @"操作成功。";
                    if ([resultCode integerValue] < 0) {
                        message = [resultCode errorMessage];
                    }

                    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示信息" message:message preferredStyle:UIAlertControllerStyleAlert];
                    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
                    [alertController addAction:okAction];
                    //显示
                    [self presentViewController:alertController animated:true completion:nil];


                } else {
                    NSLog(@"error : %@", error.localizedDescription);
                }
            }];
  	// 执行任务
    [task resume];
}
```

#### 修改方法

```objective-c
- (void)startRequest {
    // 准备参数
    NSDate *date = [[NSDate alloc] init];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *dateStr = [dateFormatter stringFromDate:date];
    
    NSDictionary *dict = (NSDictionary*)self.detailItem;
    NSNumber* _id = (NSNumber*)dict[@"ID"];
    
    // 请求体
    NSString *post = [NSString stringWithFormat:@"email=%@&type=%@&action=%@&date=%@&content=%@&id=%@",
                                                @"<你的51work6.com用户邮箱>", @"JSON", @"modify", dateStr, self.txtView.text, _id];
    NSData *postData = [post dataUsingEncoding:NSUTF8StringEncoding];
    // URl
    NSString *strURL = @"http://www.51work6.com/service/mynotes/WebService.php";
    NSURL *url = [NSURL URLWithString:strURL];
	// POST请求
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:postData];
	// 默认会话
    NSURLSessionConfiguration *defaultConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:defaultConfig delegate:nil delegateQueue:[NSOperationQueue mainQueue]];
	// 数据会话任务
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:
            ^(NSData *data, NSURLResponse *response, NSError *error) {
                NSLog(@"请求完成...");
                if (!error) {
                    NSDictionary *resDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];

                    NSNumber *resultCode = resDict[@"ResultCode"];
                    NSString *message = @"操作成功。";
                    if ([resultCode integerValue] < 0) {
                        message = [resultCode errorMessage];
                    }

                    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示信息" message:message preferredStyle:UIAlertControllerStyleAlert];
                    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler: nil];
                    [alertController addAction:okAction];
                    //显示
                    [self presentViewController:alertController animated:true completion:nil];

                } else {
                    NSLog(@"error : %@", error.localizedDescription);
                }
            }];
	// 执行任务
    [task resume];
}
```

####  查询和删除

```objective-c
- (void)startRequest {
	// URL
    NSString *strURL = @"http://www.51work6.com/service/mynotes/WebService.php";
    NSURL *url = [NSURL URLWithString:strURL];
	// 请求体
    NSString *post;
    if (action == QUERY) {//查询处理
        post = [NSString stringWithFormat:@"email=%@&type=%@&action=%@", @"<你的51work6.com用户邮箱>", @"JSON", @"query"];
    } else if (action == REMOVE) {//删除处理
        NSMutableDictionary *dict = self.listData[deleteRowId];
        post = [NSString stringWithFormat:@"email=%@&type=%@&action=%@&id=%@",
                                          @"<你的51work6.com用户邮箱>", @"JSON", @"remove", dict[@"ID"]];
    }
    NSData *postData = [post dataUsingEncoding:NSUTF8StringEncoding];
	// POST请求
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:postData];
	// 默认会话
    NSURLSessionConfiguration *defaultConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:defaultConfig delegate:nil delegateQueue:[NSOperationQueue mainQueue]];
	// 数据会话任务
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:
            ^(NSData *data, NSURLResponse *response, NSError *error) {
                NSLog(@"请求完成...");
                if (!error) {
                    NSDictionary *resDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];

                    if (action == QUERY) {//查询处理
                        [self reloadView:resDict];
                    } else if (action == REMOVE) {//删除处理

                        NSNumber *resultCode = resDict[@"ResultCode"];
                        NSString *message = @"操作成功。";
                        if ([resultCode integerValue] < 0) {
                            message = [resultCode errorMessage];
                        }

                        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示信息" message:message preferredStyle:UIAlertControllerStyleAlert];
                        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
                        [alertController addAction:okAction];
                        //显示
                        [self presentViewController:alertController animated:true completion:nil];

                        //重新查询
                        action = QUERY;
                        [self startRequest];
                    }

                } else {
                    NSLog(@"error : %@", error.localizedDescription);
                }
            }];
	// 执行任务
    [task resume];

}
```

# AFNetworking

## 概述

基于易用性和安全性的考虑，第三方网络请求框架比 NSURLSession 更好

第三方框架对比

![](https://ws3.sinaimg.cn/large/006tNc79ly1flbzsltigoj31kw0kp46t.jpg)

**综合比较，AFNetworking是最好用的框架**，而且能够获得比较稳定的技术支持，并且AFNetworking 3在底层采用了 NSURLSession，能够发挥NSURLSession的优势，且弥补NSURLSession的不足之处

## 安装和配置

### CocoaPods

### 手动

#### 下载源码

![](https://ws1.sinaimg.cn/large/006tNc79ly1flc0bqobgvj30gv0dcta7.jpg)

- AFNetworking 和 UIKit+AFNetworking 是框架源代码
- AFNetworking.xcodeproj 是框架的工程文件
- AFNetworking.xcworkspace 是工作空间，包括：框架的工程和示例内容

#### 添加源码

- 将 AFNet working 和 UIKit+AFNetworking 目录添加到工程中
- 使用时引入头文件 ```#import "AFNetworking.h"```

#### 添加工程

- 将工程文件 AFNetworking.xcodeproj 添加到工程

![](https://ws4.sinaimg.cn/large/006tNc79ly1flc0g88oimj30a80dcwfn.jpg)

- 工程编译的目标是 AFNetworking.framework 框架文件，所以需要将框架文件添加到工程

![](https://ws2.sinaimg.cn/large/006tNc79ly1flc0ieucy7j31kw14jx1a.jpg)

## 实现 GET 请求

NSURLSession 换成 AFURLSessionManager

```objective-c
// 使用 AFNetworking 实现 GET 请求
- (void)startRequest {
    // URL
    NSString *strURL = [[NSString alloc] initWithFormat:@"http://www.51work6.com/service/mynotes/WebService.php?email=%@&type=%@&action=%@", @"<你的51work6.com用户邮箱>", @"JSON", @"query"];
    strURL = [strURL stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSURL *url = [NSURL URLWithString:strURL];
    // 请求对象
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    // 默认会话配置对象
    NSURLSessionConfiguration *defaultConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
    // 会话对象（AFURLSessionManager）
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:defaultConfig];
    // 会话任务（数据）
    NSURLSessionDataTask *task = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
      	// responseObject：服务器返回数据(经过解析，Foundation 对象)
        NSLog(@"请求完成...");
        if (!error) {
            [self reloadView:responseObject];
        } else {
            NSLog(@"error : %@", error.localizedDescription);
        }
    }];
    // 执行任务
    [task resume];
}
```

## 实现 POST 请求

NSURLSession 换成 AFURLSessionManager

```objective-c
// AFNetworking 实现 POST 请求
- (void)startRequest {
    // URL
    NSString *strURL = @"http://www.51work6.com/service/mynotes/WebService.php";
    NSURL *url = [NSURL URLWithString:strURL];
    
    // 请求体（请求参数）
    NSString *post = [NSString stringWithFormat:@"email=%@&type=%@&action=%@", @"<你的51work6.com用户邮箱>", @"JSON", @"query"];
    NSData *postData = [post dataUsingEncoding:NSUTF8StringEncoding];
    // POST 请求对象
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:postData];

    // 默认会话配置对象
    NSURLSessionConfiguration *defaultConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
    // 会话对象（AFURLSessionManager）
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:defaultConfig];
    // 会话任务（数据）
    NSURLSessionDataTask *task = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        NSLog(@"请求完成...");
        if (!error) {
            [self reloadView:responseObject];   // responseObject 是解析后的 Foundation 对象（数组、字典等）
        } else {
            NSLog(@"error : %@", error.localizedDescription);
        }
    }];
    // 执行任务
    [task resume];
}
```

## 实现下载

```objective-c
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
```

## 实现上传

```objective-c
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
```

# 反馈网络信息改善用户体验

## 下拉刷新

```objective-c
- (void)viewDidLoad {
    [super viewDidLoad];
    ...
    // 初始化UIRefreshControl
    UIRefreshControl *rc = [[UIRefreshControl alloc] init];
    rc.attributedTitle = [[NSAttributedString alloc]initWithString:@"下拉刷新"];
    [rc addTarget:self action:@selector(refreshTableView) forControlEvents:UIControlEventValueChanged];
    self.refreshControl = rc;
}
// 事件处理：下拉刷新
-(void) refreshTableView {
    if (self.refreshControl.refreshing) {
        self.refreshControl.attributedTitle = [[NSAttributedString alloc]initWithString:@"加载中..."];
        
        //查询请求数据
        action = QUERY;
        [self startRequest];
    }
}

// 数据请求...然后调用 reladView: 重新加载视图

#pragma mark - 重新加载表视图
- (void)reloadView:(NSDictionary *)res {
    // 停止刷新
    [self.refreshControl endRefreshing];
    // 重新设置下拉刷新标题
    self.refreshControl.attributedTitle = [[NSAttributedString alloc]initWithString:@"下拉刷新"];
    
    NSNumber *resultCode = res[@"ResultCode"];
    
    if ([resultCode integerValue] >= 0) {
        self.listData = res[@"Record"];
        [self.tableView reloadData];
    } else {
        NSString *errorStr = [resultCode errorMessage];
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"错误信息" message:errorStr preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
        [alertController addAction:okAction];
        // 显示
        [self presentViewController:alertController animated:true completion:nil];
    }
}
```

## 导航栏显示圆圈

导航栏中间，可以放置文字标题，也可以放置一个 View，但是title 和 titleView 是互斥的，只能显示一个，另一个被遮住。

请求数据时，导航栏显示活动指示器并处于转动状态，数据返回后要刷新界面时，移除导航栏的活动指示器，恢复导航栏标题

viewDidLoad 中，初始化活动指示器

![](https://ws3.sinaimg.cn/large/006tNc79ly1flcta2umilj31kw0c641f.jpg)

![](https://ws2.sinaimg.cn/large/006tNc79ly1flctaruozej31bg0dewid.jpg)

请求结束，要刷新界面时，移除导航栏活动指示器和提示信息

```objective-c
#pragma mark - 重新加载表视图
- (void)reloadView:(NSDictionary *)res {
    // 停止活动指示器，恢复导航栏
    self.navigationItem.titleView = nil;
    self.navigationItem.prompt = nil;
	...
}
```

## 状态栏小圆圈

使用 UIApplication 类的 networkActivityIndicatorVisible 属性（BOOL），请求开始显示，请求结束隐藏

```objective-c
#pragma mark - 开始请求Web Service
- (void)startRequest {
	...
    // 状态栏显示加载圆圈
    [UIApplication sharedApplication].networkActivityIndicatorVisible = TRUE;
}

#pragma mark - 请求结束，重新加载表视图
- (void)reloadView:(NSDictionary *)res {
	...
    // 隐藏状态栏加载圆圈
    [UIApplication sharedApplication].networkActivityIndicatorVisible = FALSE;
}
```

