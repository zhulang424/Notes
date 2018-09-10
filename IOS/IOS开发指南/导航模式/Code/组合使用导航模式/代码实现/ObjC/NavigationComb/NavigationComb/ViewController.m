//
//  ViewController.m
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


#import "ViewController.h"
#import "DetailViewController.h"

@interface ViewController ()

@property (strong, nonatomic) NSDictionary *dictData;
@property (strong, nonatomic) NSArray *listData;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"provinces_cities" ofType:@"plist"];
    self.dictData = [[NSDictionary  alloc] initWithContentsOfFile:plistPath];
    
    // 通过父视图控制器（UINavigationController）的 tabBarItem 的 title 属性来确定属于哪个标签，确定后对应初始化表格的数据
    UINavigationController *navigationController = (UINavigationController*)self.parentViewController;
    NSString *selectProvinces = navigationController.tabBarItem.title;
    
    NSLog(@"%@", selectProvinces);
    
    if ([selectProvinces isEqualToString:@"黑龙江"]) {
        self.listData = self.dictData[@"黑龙江省"];
        self.navigationItem.title = @"黑龙江省信息"; // 设置导航栏标题
    } else if ([selectProvinces isEqualToString:@"吉林"]) {
        self.listData = self.dictData[@"吉林省"];
        self.navigationItem.title = @"吉林省信息";
    } else {
        self.listData = self.dictData[@"辽宁省"];
        self.navigationItem.title = @"辽宁省信息";
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark --实现表视图数据源方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.listData count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIdentifier = @"CellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    NSInteger row = [indexPath row];
    NSDictionary *dict = self.listData[row];
    cell.textLabel.text = dict[@"name"];
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

#pragma mark --实现表视图委托协议方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSInteger selectedIndex = [indexPath row];
    NSDictionary *dict = self.listData[selectedIndex];
    
    // 创建并初始化二级页面
    DetailViewController *detailViewController = [[DetailViewController alloc] init];
    detailViewController.url = dict[@"url"];
    detailViewController.title = dict[@"name"]; // 设置二级页面的导航栏标题（由于二级页面是被 UINavigationController 压入栈顶的，所以自带导航栏）
    
    // 使用 UInavigationController 将二级页面压入栈顶显示出来
    [self.navigationController pushViewController:detailViewController animated:YES];
    
}

@end
