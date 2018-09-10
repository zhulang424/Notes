//
//  DetailViewController.m
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

#import "DetailViewController.h"

@interface DetailViewController ()

@end

@implementation DetailViewController

#pragma mark - UIView Lifecycle


- (void)viewDidLoad {   // 根据传入的联系人对象，读取其属性并展示在界面
    [super viewDidLoad];
    
    CNContactStore *contactStore = [[CNContactStore alloc] init];
    NSArray *keysToFetch = @[CNContactFamilyNameKey, CNContactGivenNameKey, CNContactEmailAddressesKey, CNContactPhoneNumbersKey, CNContactImageDataKey];
    NSError *error = nil;
    CNContact *contact = [contactStore unifiedContactWithIdentifier:self.selectContact.identifier
                                                        keysToFetch:keysToFetch
                                                              error:&error];
    self.selectContact = contact;
    if (!error) {
        // 读取单值属性：姓名
        NSString *firstName = contact.givenName;
        NSString *lastName = contact.familyName;
        NSString *name = [NSString stringWithFormat:@"%@ %@", firstName, lastName];
        [self.lblName setText:name];
        
        // 读取单值属性：图片
        NSData *photoData = contact.imageData;
        if(photoData){
            [self.imageView setImage:[UIImage imageWithData:photoData]];
        }
        
        // 读取单值属性：email
        NSArray<CNLabeledValue<NSString*>*> *emailAddresses = contact.emailAddresses;
        for (CNLabeledValue<NSString*>* emailProperty in emailAddresses) {
            
            if ([emailProperty.label isEqualToString:CNLabelWork]) {
                [self.txtWorkEmail setText:emailProperty.value];
            } else if ([emailProperty.label isEqualToString:CNLabelHome]) {
                [self.txtHomeEmail setText:emailProperty.value];
            } else {
                NSLog(@"%@: %@", @"其他Email", emailProperty.value);
            }
        }
        
        // 读取多值属性：电话号码
        NSArray<CNLabeledValue<CNPhoneNumber *> *> *phoneNumbers = contact.phoneNumbers;
        for (CNLabeledValue<CNPhoneNumber *> *phoneNumberProperty in phoneNumbers) {
            CNPhoneNumber *phoneNumber = phoneNumberProperty.value;
            if ([phoneNumberProperty.label isEqualToString:CNLabelPhoneNumberMobile]) {
                [self.txtMobile setText:phoneNumber.stringValue];
            } else if ([phoneNumberProperty.label isEqualToString:CNLabelPhoneNumberiPhone]) {
                [self.txtIPhone setText:phoneNumber.stringValue];
            } else {
                NSLog(@"%@: %@", @"其他电话", phoneNumber.stringValue);
            }
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Button Click
// 回调：点击“保存”按钮
- (IBAction)saveClick:(id)sender {  // 修改联系人属性并保存
    
    // 获取：可变联系人对象
    CNMutableContact* contact = [self.selectContact mutableCopy];
    // 设置属性：电话号码
    CNPhoneNumber* mobilePhoneValue = [[CNPhoneNumber alloc] initWithStringValue:self.txtMobile.text];  // 将字符串转化成点好号码
    CNLabeledValue* mobilePhone = [[CNLabeledValue alloc] initWithLabel:CNLabelPhoneNumberMobile
                                                                  value:mobilePhoneValue];              // 电话号码键值对
    CNPhoneNumber* iPhoneValue = [[CNPhoneNumber alloc] initWithStringValue:self.txtIPhone.text];       // 将字符串转化成点好号码
    CNLabeledValue* iPhone = [[CNLabeledValue alloc] initWithLabel:CNLabelPhoneNumberiPhone
                                                             value:iPhoneValue];                        // 电话号码键值对
    contact.phoneNumbers = @[mobilePhone, iPhone];      // 将电话号码键值对 存入联系人
    // 设置属性：Email
    CNLabeledValue* homeEmail = [[CNLabeledValue alloc] initWithLabel:CNLabelHome
                                                                value:self.txtHomeEmail.text];  // Email 键值对
    CNLabeledValue* workEmail = [[CNLabeledValue alloc] initWithLabel:CNLabelWork
                                                                value:self.txtWorkEmail.text];  // Email 键值对
    contact.emailAddresses = @[homeEmail, workEmail];   // 将 Email 键值对 存入联系人
    
    // 创建：写入联系人请求
    CNSaveRequest* request = [[CNSaveRequest alloc] init];
    // 设置请求类型：修改
    [request updateContact:contact];
    
    // 创建：联系人管理对象
    CNContactStore *contactStore = [[CNContactStore alloc] init];
    // 执行请求
    NSError* error;
    [contactStore executeSaveRequest:request error:&error];
    if (!error) {
        // 成功：导航回根视图控制器
        [self.navigationController popToRootViewControllerAnimated:TRUE];
    } else {
        // 失败：打印错误信息
        NSLog(@"error : %@", error.localizedDescription);
    }
}

// 回调：点击“删除联系人”
- (IBAction)deleteClick:(id)sender {
    // 获取：可变联系人对象
    CNMutableContact* contact = [self.selectContact mutableCopy];
    
    // 创建：写入请求
    CNSaveRequest* request = [[CNSaveRequest alloc] init];
    // 设置操作类型：删除
    [request deleteContact:contact];
    
    // 创建：联系人管理对象
    CNContactStore *contactStore = [[CNContactStore alloc] init];
    // 执行请求
    NSError* error;
    [contactStore executeSaveRequest:request
                               error:&error];
    if (!error) {
        // 成功：导航回根视图控制器
        [self.navigationController popToRootViewControllerAnimated:TRUE];
    } else {
        // 失败：打印错误信息
        NSLog(@"error : %@", error.localizedDescription);
    }
    
}

@end
