//
//  MasterViewController.m
//  MyNotes
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

#import "MasterViewController.h"
#import "DetailViewController.h"

@implementation MasterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
    self.detailViewController = (DetailViewController *) [[self.splitViewController.viewControllers lastObject] topViewController];

    [self startRequest];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 开始请求Web Service
// 简单会话实现 GET 请求
- (void)startRequest {
    // URL 对象
    NSString *strURL = [[NSString alloc] initWithFormat:@"http://www.51work6.com/service/mynotes/WebService.php?email=%@&type=%@&action=%@", @"<你的51work6.com用户邮箱>", @"JSON", @"query"];
    strURL = [strURL stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];  // 将字符串编码为 URL 字符串（URL 中不能有中文和特殊字符，必须进行编码），使用 URLQueryAllowedCharacterSet 字符集（带有请求参数的 URL 字符串允许的字符集）
    NSURL *url = [NSURL URLWithString:strURL];
    // 请求 对象
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

#pragma mark - Segues

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        NSMutableDictionary *dict = self.listData[indexPath.row];
        DetailViewController *controller = (DetailViewController *) [[segue destinationViewController] topViewController];
        [controller setDetailItem:dict];
        controller.navigationItem.leftBarButtonItem = self.splitViewController.displayModeButtonItem;
        controller.navigationItem.leftItemsSupplementBackButton = TRUE;
    }
}

#pragma mark - Table View

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.listData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];

    NSMutableDictionary *dict = self.listData[indexPath.row];
    cell.textLabel.text = dict[@"Content"];
    cell.detailTextLabel.text = dict[@"CDate"];

    return cell;
}

#pragma mark - 重新加载表视图

- (void)reloadView:(NSDictionary *)res {

    NSNumber *resultCode = res[@"ResultCode"];

    if ([resultCode integerValue] >= 0) {
        self.listData = res[@"Record"];
        [self.tableView reloadData];
    } else {
        NSString *errorStr = [resultCode errorMessage];
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"错误信息" message:errorStr preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
        [alertController addAction:okAction];
        //显示
        [self presentViewController:alertController animated:true completion:nil];
    }
}


@end
