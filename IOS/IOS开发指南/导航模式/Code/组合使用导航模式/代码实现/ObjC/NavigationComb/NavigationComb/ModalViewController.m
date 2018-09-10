//
//  ModalViewController.m
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


#import "ModalViewController.h"

@interface ModalViewController ()

@end

@implementation ModalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置背景色（不设置的话，背景色默认透明，向上滑出时，上级页面会透过背景色显示出来！）
    self.view.backgroundColor = [UIColor whiteColor];
    
    // 向导航栏添加左右按钮
    UIBarButtonItem* saveButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(save:)];
    self.navigationItem.rightBarButtonItem = saveButtonItem;
    
    UIBarButtonItem* cancelButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancel:)];
    self.navigationItem.leftBarButtonItem = cancelButtonItem;
    
    // 创建并初始化 UITextView
    CGRect screen = [[UIScreen mainScreen] bounds];
    CGFloat textViewWidth = 320;
    CGFloat textViewHeight = 200;
    CGFloat textViewTopView = 100;
    
    UITextView* textView = [[UITextView alloc] initWithFrame:CGRectMake((screen.size.width - textViewWidth)/2 , textViewTopView, textViewWidth, textViewHeight)];
    textView.text = @"Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Nam liber te conscient to factor tum poen legum odioque civiuda.";
    // 将 UITextView 加入父视图
    [self.view addSubview:textView];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// 事件处理：点击导航栏“Save”按钮
- (void)save:(id)sender {
}

// 事件处理：点击导航栏“ Cancel”按钮
- (void)cancel:(id)sender {
    [self dismissViewControllerAnimated:TRUE completion:^{
        NSLog(@"关闭模态视图");
    }];
}

@end
