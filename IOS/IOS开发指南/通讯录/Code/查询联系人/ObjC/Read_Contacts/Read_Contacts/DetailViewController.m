//
//  DetailViewController.m
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

#import "DetailViewController.h"

@interface DetailViewController ()

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    ////// 根据传来的 CNContact 对象，查询该联系人多值属性
    // 初始化：联系人管理对象
    CNContactStore *contactStore = [[CNContactStore alloc] init];
    // 设置：要查询的属性（姓、名、电子邮件、电话号、图片）
    NSArray *keysToFetch = @[CNContactFamilyNameKey, CNContactGivenNameKey, CNContactEmailAddressesKey, CNContactPhoneNumbersKey, CNContactImageDataKey];
    // 执行：查询联系人（根据 CNContact 的 indentifier 属性）
    NSError *error = nil;
    CNContact *contact = [contactStore unifiedContactWithIdentifier:self.selectContact.identifier
                                                        keysToFetch:keysToFetch
                                                              error:&error];
    // 执行：读取联系人属性
    if (!error) {
        // 读取单值属性：姓名        （对应：CNContactGivenNameKey、CNContactFamilyNameKey）
        NSString *firstName = contact.givenName;
        NSString *lastName = contact.familyName;
        NSString *name = [NSString stringWithFormat:@"%@ %@", firstName, lastName];
        [self.lblName setText:name];
        // 读取单值属性：图片        （对应：CNContactImageDataKey）
        NSData *photoData = contact.imageData;
        if(photoData){
            [self.imageView setImage:[UIImage imageWithData:photoData]];
        }
        // 读取多值属性：Email      （对应：CNContactEmailAddressesKey）
        NSArray<CNLabeledValue<NSString *> *> *emailAddresses = contact.emailAddresses;
        for (CNLabeledValue<NSString *> *emailProperty in emailAddresses) {
            if ([emailProperty.label isEqualToString:CNLabelWork]) {        // 工作 email
                [self.lblWorkEmail setText:emailProperty.value];
            } else if ([emailProperty.label isEqualToString:CNLabelHome]) { // 家庭 email
                [self.lblHomeEmail setText:emailProperty.value];
            } else {
                NSLog(@"%@: %@", @"其他Email", emailProperty.value);
            }
        }
        // 读取多值属性：电话号码     （对应：CNContactPhoneNumbersKey）
        NSArray<CNLabeledValue<CNPhoneNumber *> *> *phoneNumbers = contact.phoneNumbers;
        for (CNLabeledValue<CNPhoneNumber *> *phoneNumberProperty in phoneNumbers) {
            CNPhoneNumber *phoneNumber = phoneNumberProperty.value;
            if ([phoneNumberProperty.label isEqualToString:CNLabelPhoneNumberMobile]) {         // 移动电话号码
                [self.lblMobile setText:phoneNumber.stringValue];
            } else if ([phoneNumberProperty.label isEqualToString:CNLabelPhoneNumberiPhone]) {  // iphone 电话号码
                [self.lblIPhone setText:phoneNumber.stringValue];
            } else {
                NSLog(@"%@: %@", @"其他电话", phoneNumber.stringValue);
            }
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
