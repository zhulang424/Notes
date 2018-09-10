//
//  DetailViewController.m
//  NavigationComb
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


#import "DetailViewController.h"
#import "ModalViewController.h"
#import <WebKit/WebKit.h>

@interface DetailViewController () <WKNavigationDelegate>

@property(nonatomic, strong) WKWebView* webView;

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 添加导航栏右按钮“+”（此视图控制器是被 UINavigationController 压入栈顶，所以自带导航栏）
    UIBarButtonItem* addButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(add:)];
    self.navigationItem.rightBarButtonItem = addButtonItem;
    
    // 创建并初始化 WKWebView，并加入父视图
    self.webView = [[WKWebView alloc] initWithFrame: self.view.frame];
    [self.view addSubview: self.webView];
    self.webView.navigationDelegate = self;
    
    NSURL * url = [NSURL URLWithString: self.url];
    NSURLRequest * request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

// 事件处理：点击导航栏右按钮“+”
- (void)add:(id)sender {
    
    // 创建并初始化模态视图，并嵌入 UINavigationController
    ModalViewController* modalViewController = [[ModalViewController alloc] init];
    UINavigationController* navigationController = [[UINavigationController alloc] initWithRootViewController:modalViewController];
    
    // 使用 ViewController 包含的方法显示模态视图（从下向上滑出）
    [self presentViewController:navigationController animated: TRUE completion: nil];
    
}

#pragma mark  --实现WKNavigationDelegate委托协议
// 开始加载时调用
-(void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
    NSLog(@"开始加载");
}
// 当内容开始返回时调用
-(void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation {
    NSLog(@"内容开始返回");
}

// 加载完成之后调用
-(void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    NSLog(@"加载完成");
}

// 加载失败时调用
-(void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error {
    NSLog(@"加载失败 error :  %@", error.localizedDescription);
}

@end
