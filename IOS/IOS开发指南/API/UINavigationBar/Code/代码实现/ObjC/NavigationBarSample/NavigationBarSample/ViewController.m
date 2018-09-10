//
//  ViewController.m
//  NavigationBarSample
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

@interface ViewController ()

@property (strong, nonatomic) UILabel *label;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    

    
    // 创建导航栏
    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    CGFloat navigationBarWidth = screenBounds.size.width;
    CGFloat navigationBarHeight = 44; // 导航栏默认高度
    CGFloat navigationBarX = 0;
    CGFloat navigationBarY = 20; // 状态栏默认高度
    UINavigationBar *navigationBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(navigationBarX, navigationBarY, navigationBarWidth, navigationBarHeight)];
    
    // 创建左右按钮
    UIBarButtonItem *saveButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave
                                                                                    target:self
                                                                                    action:@selector(save:)];
    UIBarButtonItem *addButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                                                                   target:self
                                                                                   action:@selector(add:)];
    
    // 将左右按钮封装到 UINavigationItem
    UINavigationItem *navigationItem = [[UINavigationItem alloc] initWithTitle:@"Home"];
    navigationItem.leftBarButtonItem = saveButtonItem;
    navigationItem.rightBarButtonItem = addButtonItem;
    
    // 将 NavigationItem 封装进 NavigationBar
    navigationBar.items = @[navigationItem];
    
    [self.view addSubview:navigationBar];
    
    /// 2.添加标签
    CGFloat labelWidth = 84;
    CGFloat labelHeight = 21;
    CGFloat labelTopView = 198;
    
    self.label = [[UILabel alloc] initWithFrame:CGRectMake((screenBounds.size.width - labelWidth)/2 , labelTopView, labelWidth, labelHeight)];
    
    self.label.text = @"Label";
    //字体左右居中
    self.label.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.label];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


- (void)save:(id)sender {
    self.label.text = @"点击Save";
}

- (void)add:(id)sender {
    self.label.text = @"点击Add";
}

@end
