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
    
    
    // 获取 JSON文件 路径
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Notes" ofType:@"json"];
    // 将 JSON 文件内容转换成 NSData对象
    NSData *jsonData = [[NSData alloc] initWithContentsOfFile:path];

    /**
     解析 NSData，解析后的结果是 Foundation 类型的对象（NSDictionary，NSArray，NSString，NSNumber 等）
     参数 options：
            NSJSONReadingMutableContainers：返回可变容器（NSMutableArray，NSMutableDictionary）
            NSJSONReadingMutableLeaves： 返回的每个节点是可变字符串
            NSJSONReadingAllowFragments：允许解析不是数组或者字典的 JSON 数据（正常情况JSON的顶级节点要么是Array[]要么是Dictionary{}，如果不是，这用这个选项进行指定）
            0：无指定选项
     */
    NSMutableDictionary *resultDic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:NULL];
    
    self.listData = resultDic[@"Record"];
    
//    NSArray *recordArray = resultDic[@"Record"];
//    for (NSDictionary *noteDic in recordArray) {
//        NSLog(@"%@",[noteDic[@"ID"] class]);
//        NSLog(@"%@",[noteDic[@"CDate"] class]);
//        NSLog(@"%@",[noteDic[@"Content"] class]);
//        NSLog(@"%@",[noteDic[@"UserID"] class]);
//    }
//    NSDictionary *lastDic = [recordArray lastObject];
//    NSNumber *number = lastDic[@"ID"];
//    NSLog(@"%@",number);
    
//    [self DictToJson];
}

// 字典转JSON
-(void)DictToJson{
    // 创建字典
    NSDictionary *dict = @{
                           @"Name":@"LitterL",
                           @"Age":@"20"
                           };
    // 判断是否能转为Json数据
    BOOL isValidJSONObject =  [NSJSONSerialization isValidJSONObject:dict];
    if (isValidJSONObject) {
        /**
         将字典转换成 JSON
         参数 options:
                NSJSONWritingPrettyPrinted：排版
                kNilOptions（0）：不排版
         */
        NSData *data1 =  [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:nil];
        NSData *data2 =  [NSJSONSerialization dataWithJSONObject:dict options:kNilOptions error:nil];
        // 打印JSON数据
        NSLog(@"%@",[[NSString alloc]initWithData:data1 encoding:NSUTF8StringEncoding]);
        NSLog(@"%@",[[NSString alloc]initWithData:data2 encoding:NSUTF8StringEncoding]);
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

@end
