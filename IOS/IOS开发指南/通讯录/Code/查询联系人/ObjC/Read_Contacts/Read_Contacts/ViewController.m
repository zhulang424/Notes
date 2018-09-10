//
//  ViewController.m
//  Read_Contacts
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

#import <Contacts/Contacts.h>

@interface ViewController () <UISearchBarDelegate, UISearchResultsUpdating> // 实现协议

@property(strong, nonatomic) UISearchController *searchController;

@property(strong, nonatomic) NSArray *listContacts;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 实例化UISearchController
    self.searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    // 设置self为更新搜索结果对象
    self.searchController.searchResultsUpdater = self;
    // 设置搜索时背景为灰色
    self.searchController.dimsBackgroundDuringPresentation = FALSE;
    // 将搜索栏放到表视图的表头中
    self.tableView.tableHeaderView = self.searchController.searchBar;

    /** 在后台并发队列中执行通讯录查询
     1.提高查询的执行效率
     2.放置通讯录被首次访问时出现“白屏”（默认情况下通讯录查询和通讯录授权都是串行执行，即同步执行，会出现思索状态，如果把通讯录查询防盗后台兵法队列中执行，则会避免死锁）
     */
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        // 查询通信录中所有联系人
        self.listContacts = [self findAllContacts];
        // 在主队列中更新 UI
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    });
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - 预处理Segue

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        DetailViewController *detailViewController = [segue destinationViewController];
        detailViewController.selectContact = self.listContacts[indexPath.row];
    }
}

#pragma mark - 查询通信录中所有联系人
- (NSArray*)findAllContacts {
    
    // 初始化：联系人 数组
    id contacts = [[NSMutableArray alloc] init];
    /** 初始化：查询属性 数组
     CNContactFamilyNameKey：姓
     CNContactGivenNameKey：名
     */
    NSArray *keysToFetch = @[CNContactFamilyNameKey, CNContactGivenNameKey];
    // 初始化：查询请求
    CNContactFetchRequest *fetchRequest = [[CNContactFetchRequest alloc] initWithKeysToFetch:keysToFetch];
    // 初始化：通讯录管理对象
    CNContactStore *contactStore = [[CNContactStore alloc] init];
    // 执行：查询通讯录
    NSError *error = nil;
    [contactStore enumerateContactsWithFetchRequest:fetchRequest
                                              error:&error
                                         usingBlock:^(CNContact *_Nonnull contact, BOOL *_Nonnull stop) {
        if (!error) {
            // 将 单个联系人 添加到 联系人数组
            [contacts addObject:contact];
        } else {
            NSLog(@"error : %@", error.localizedDescription);
        }
    }];
    
    return contacts;
}

#pragma mark - 按照姓名查询通信录中的联系人

- (NSArray*)findContactsByName:(NSString *)searchName {
    
    // 没有输入任何字符时，返回通信录中所有联系人
    if ([searchName length] == 0) {
        return [self findAllContacts];
    }
    
    // 初始化：通讯录管理对象
    CNContactStore *contactStore = [[CNContactStore alloc] init];
    /** 初始化：查询属性 数组
     CNContactFamilyNameKey：姓
     CNContactGivenNameKey：名
     */
    NSArray *keysToFetch = @[CNContactFamilyNameKey, CNContactGivenNameKey];
    // 初始化：过滤条件
    NSPredicate *predicate = [CNContact predicateForContactsMatchingName:searchName];
    // 执行：查询通讯录
    NSError *error = nil;
    id contact = [contactStore unifiedContactsMatchingPredicate:predicate
                                                    keysToFetch:keysToFetch
                                                          error:&error];
    if (!error) {
        // 没有有错误情况下返回查询结果
        return contact;
    } else {
        // 如果有错误发生，返回通信录中所有联系人
        return [self findAllContacts];
    }
}

#pragma mark - UISearchBarDelegate

- (void)searchBar:(UISearchBar *)searchBar selectedScopeButtonIndexDidChange:(NSInteger)selectedScope {
    [self updateSearchResultsForSearchController:self.searchController];
}

#pragma mark - UISearchResultsUpdating
// 回调：搜索栏成为 first responder 或 搜索栏文字变化
- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    // 根据搜索栏文字，查询通讯录
    NSString *searchString = searchController.searchBar.text;
    self.listContacts = [self findContactsByName:searchString];
    [self.tableView reloadData];
}


#pragma mark - Tableview data source
// 回调：设置表格数量
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.listContacts == nil) {
        return 0;
    }
    return [self.listContacts count];
}
// 回调：设置每行表格内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // 读取单值属性
    CNContact *contact = self.listContacts[indexPath.row];
    NSString *firstName = contact.givenName;    // 名（对应查询数组中的 CNContactGivenNameKey）
    NSString *lastName = contact.familyName;    // 姓（对应查询数组中的 CNContactFamilyNameKey）
   
    // 初始化：表格
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    NSString *name = [NSString stringWithFormat:@"%@ %@", firstName, lastName];
    cell.textLabel.text = name;
    
    return cell;
}


@end
