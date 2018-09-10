//
//  RegisterViewController.m
//  ModalViewSample
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


#import "RegisterViewController.h"

@interface RegisterViewController ()

@property (strong, nonatomic) UITextField *txtUsername;

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 不设置背景色的话，背景色默认为透明，会导致滑出过程中，父页面仍然透过背景显示出来
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationItem.title = @"注册";
    
    UIBarButtonItem *saveButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:
                                       UIBarButtonSystemItemSave target:self action:@selector(save:)];
    
    UIBarButtonItem *cancelButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:
                                         UIBarButtonSystemItemCancel target:self action:@selector(cancel:)];
    
    self.navigationItem.rightBarButtonItem = saveButtonItem;
    self.navigationItem.leftBarButtonItem = cancelButtonItem;
    
    
    /// 1.添加用户ID：标签
    UILabel* labelId = [[UILabel alloc] initWithFrame:CGRectMake(35, 187, 100, 21)];
    labelId.text = @"用户ID：";
    [self.view addSubview:labelId];
    
    /// 2.添加Username TextField
    self.txtUsername = [[UITextField alloc] initWithFrame:CGRectMake(180, 178, 131, 30)];
    self.txtUsername.borderStyle = UITextBorderStyleRoundedRect;
    [self.view addSubview:self.txtUsername];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)save:(id)sender {
    
    [self dismissViewControllerAnimated:TRUE completion:^{
        
        NSLog(@"点击Save按钮，关闭模态视图");
        
        NSDictionary *dataDict = @{@"username" : self.txtUsername.text};
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"RegisterCompletionNotification" object:nil userInfo:dataDict];
        
    }];
    
}

- (void)cancel:(id)sender {
    
    [self dismissViewControllerAnimated:TRUE completion:^{
        NSLog(@"点击Cancel按钮，关闭模态视图");
    }];
    
}

@end
