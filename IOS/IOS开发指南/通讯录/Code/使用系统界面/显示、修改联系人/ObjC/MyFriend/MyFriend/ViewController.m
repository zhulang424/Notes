//
//  ViewController.m
//  MyFriend
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
#import <ContactsUI/ContactsUI.h>

@interface ViewController () <CNContactPickerDelegate, CNContactViewControllerDelegate>

@property(strong, nonatomic) NSMutableArray *listContacts;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.listContacts = [[NSMutableArray alloc] init];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)selectContacts:(id)sender {
    
    CNContactPickerViewController *contactPicker = [[CNContactPickerViewController alloc] init];
    contactPicker.delegate = self;
    contactPicker.displayedPropertyKeys = @[CNContactPhoneNumbersKey];
    
    [self presentViewController:contactPicker animated:TRUE completion:nil];
    
}

#pragma mark --实现表视图数据源协议

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.listContacts count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    CNContact *contact = self.listContacts[indexPath.row];
    NSString *firstName = contact.givenName;
    NSString *lastName = contact.familyName;
    
    NSString *name = [NSString stringWithFormat:@"%@ %@", firstName, lastName];
    cell.textLabel.text = name;
    
    return cell;
}

#pragma mark - UITableView Delegate
// 回调：点击表格行
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {   // 进入联系人详情页面
    
    // 创建：联系人管理对象
    CNContactStore* contactStore = [[CNContactStore alloc] init];
    // 获取：当前选择的联系人对象
    CNContact *selectedContact = self.listContacts[indexPath.row];
    // 设置：显示属性
    id keysToFetch = @[[CNContactViewController descriptorForRequiredKeys]];
    // 执行：查询联系人（根据 identifier）
    NSError *error;
    CNContact *contact = [contactStore unifiedContactWithIdentifier:selectedContact.identifier
                                                        keysToFetch:keysToFetch
                                                              error:&error];
    if (!error) {
        // 创建：联系人详情 视图控制器
        CNContactViewController* controller = [CNContactViewController viewControllerForContact:contact];
        // 设置：委托对象
        controller.delegate = self;
        // 设置：联系人管理对象
        controller.contactStore = contactStore;
        // 设置：详情页是否允许编辑
        controller.allowsEditing = TRUE;
        // 设置：详情页是否显示功能按钮（发送信息、共享联系人等）
        controller.allowsActions = TRUE;
        // 设置：详情页显示的属性
        controller.displayedPropertyKeys = @[CNContactPhoneNumbersKey, CNContactEmailAddressesKey];
        
        // 显示：联系人详情页
        [self.navigationController pushViewController:controller animated:TRUE];
    } else {
        NSLog(@"error : %@", error.localizedDescription);
    }
}

#pragma mark - CNContactViewControllerDelegate
// 回调：点击属性时是否执行默认功能（打电话、 FaceTime 等）
- (BOOL)contactViewController:(CNContactViewController *)viewController
shouldPerformDefaultActionForContactProperty:(CNContactProperty *)property {
    return TRUE;
}

#pragma mark - CNContactPickerDelegate
- (void)contactPicker:(CNContactPickerViewController *)picker didSelectContact:(CNContact *)contact {
    
    if (![self.listContacts containsObject:contact]) {
        [self.listContacts addObject:contact];
        [self.tableView reloadData];
    }
}



@end
