//
//  AddViewController.m
//  Write_Contacts
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

#import "AddViewController.h"

@interface AddViewController ()

@end

@implementation AddViewController


- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
#pragma mark - Button Click
// 回调：点击“保存”按钮
- (IBAction)saveClick:(id)sender {
    // 创建：可变联系人
    CNMutableContact* contact = [[CNMutableContact alloc] init];
    // 设置：姓名
    contact.familyName =  self.txtFirstName.text;
    contact.givenName =  self.txtLastName.text;
    // 设置：电话号码
    CNPhoneNumber* mobilePhoneValue = [[CNPhoneNumber alloc] initWithStringValue:self.txtMobile.text];      // 根据字符串创建号码对象
    CNLabeledValue* mobilePhone = [[CNLabeledValue alloc] initWithLabel:CNLabelPhoneNumberMobile
                                                                  value:mobilePhoneValue];                  // 创建：电话号码键值对
    CNPhoneNumber* iPhoneValue = [[CNPhoneNumber alloc] initWithStringValue:self.txtIPhone.text];           // 根据字符串创建号码对象
    CNLabeledValue* iPhone = [[CNLabeledValue alloc] initWithLabel:CNLabelPhoneNumberiPhone
                                                             value:iPhoneValue];                            // 创建：电话号码键值对
    contact.phoneNumbers = @[mobilePhone, iPhone];      // 将 电话号码键值对 保存到联系人
    // 设置：Email
    CNLabeledValue* homeEmail = [[CNLabeledValue alloc] initWithLabel:CNLabelHome
                                                                value:self.txtHomeEmail.text];              // 创建：email 键值对
    CNLabeledValue* workEmail = [[CNLabeledValue alloc] initWithLabel:CNLabelWork
                                                                value:self.txtWorkEmail.text];              // 创建：email 键值对
    contact.emailAddresses = @[homeEmail, workEmail];   // 将 email 键值对 保存到联系人
    
    // 创建：写入请求
    CNSaveRequest* request = [[CNSaveRequest alloc] init];
    // 设置：请求类型
    [request addContact:contact toContainerWithIdentifier:nil]; // nil 表示默认容器
    
    // 创建：联系人管理对象
    CNContactStore *contactStore = [[CNContactStore alloc] init];
    // 执行：写入请求
    NSError* error;
    [contactStore executeSaveRequest:request
                               error:&error];
    if (!error) {
        // 成功后，关闭模态视图
        [self dismissViewControllerAnimated:TRUE
                                 completion:nil];
    } else {
        // 失败后，打印错误信息
        NSLog(@"error : %@", error.localizedDescription);
    }
}

// 回调：点击“取消”按钮
- (IBAction)cancelClick:(id)sender {
    
    // 关闭模态视图
    [self dismissViewControllerAnimated:TRUE completion:nil];
}

@end
