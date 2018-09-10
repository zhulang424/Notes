//
//  ViewController.m
//  PickerViewSample
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

@interface ViewController () <UIPickerViewDelegate, UIPickerViewDataSource>

@property (strong, nonatomic) UIPickerView *pickerView;
@property (strong, nonatomic) UILabel *label;

@property (nonatomic, strong) NSDictionary  *pickerData; // 全部数据
@property (nonatomic, strong) NSArray  *pickerProvincesData; // 所有省数据
@property (nonatomic, strong) NSString *pickerSelectedProvincce; // 当前省
@property (nonatomic, strong) NSArray *pickerCitiesOfSelectedProvince; // 当前省包含的所有市

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 获取列表文件地址
    NSString *pickerDataPlistPath = [[NSBundle mainBundle] pathForResource:@"provinces_cities"
                                                          ofType:@"plist"];
    // 获取属性列表文件中的全部数据
    NSDictionary *dict = [[NSDictionary alloc] initWithContentsOfFile:pickerDataPlistPath];
    self.pickerData = dict;
    
    // 获取所有省数据
    self.pickerProvincesData =  [self.pickerData allKeys];
    
    // 默认取出第一个省的所有市的数据
    NSInteger defaultSelectedIndexOfProvince = 1;
    NSInteger defaultSelectedIndexOfCity = 1;
    self.pickerSelectedProvincce = [self.pickerProvincesData objectAtIndex:defaultSelectedIndexOfProvince];
    self.pickerCitiesOfSelectedProvince = [self.pickerData objectForKey:self.pickerSelectedProvincce];
    
    CGRect screen = [[UIScreen mainScreen] bounds];
    
    // 创建选择器
    CGFloat pickerViewWidth = 320;
    CGFloat pickerViewHeight = 162;
    CGFloat pickerViewX = 0;
    CGFloat pickerViewY = 0;
    self.pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(pickerViewX, pickerViewY, pickerViewWidth, pickerViewHeight)];
    
    // 设置 self 为委托对象、数据源对象
    self.pickerView.dataSource = self;
    self.pickerView.delegate = self;
    
    // 设置默认选中的行
    [self.pickerView selectRow:defaultSelectedIndexOfProvince inComponent:0 animated:YES];
    [self.pickerView selectRow:defaultSelectedIndexOfCity inComponent:1 animated:YES];
    
    [self.view addSubview:self.pickerView];
    
    /// 2.添加标签
    CGFloat labelWidth = 200;
    CGFloat labelHeight = 21;
    CGFloat labelTopView = 273;
    self.label = [[UILabel alloc] initWithFrame:CGRectMake((screen.size.width - labelWidth)/2 , labelTopView, labelWidth, labelHeight)];
    
    self.label.text = @"Label";
    //字体左右居中
    self.label.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.label];
    
    /// 3.Button按钮
    UIButton* button= [UIButton buttonWithType:UIButtonTypeSystem];
    [button setTitle:@"Button" forState:UIControlStateNormal];
    
    CGFloat buttonWidth = 46;
    CGFloat buttonHeight = 30;
    CGFloat buttonTopView = 374;
    
    button.frame = CGRectMake((screen.size.width - buttonWidth)/2 , buttonTopView, buttonWidth, buttonHeight);
    //指定事件处理方法
    [button addTarget:self action:@selector(onclick:) forControlEvents: UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)onclick:(id)sender {
    
//    NSInteger row1 = [self.pickerView selectedRowInComponent:0];
    NSInteger selectedRowOfCityComponent = [self.pickerView selectedRowInComponent:1];
    NSString *selectedProvince = self.pickerSelectedProvincce;
    NSString *selectedCity = [self.pickerCitiesOfSelectedProvince objectAtIndex:selectedRowOfCityComponent];
    
    NSString *title = [[NSString alloc] initWithFormat:@"%@，%@市", selectedProvince,selectedCity];
    
    self.label.text = title;
    
}

#pragma mark - 实现协议UIPickerViewDataSource方法
// 设置拨盘数量
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 2;
}

// 设置每个拨盘的行数
- (NSInteger)pickerView:(UIPickerView *)pickerView
numberOfRowsInComponent:(NSInteger)component {
    
    if (component == 0) {
        return [self.pickerProvincesData count];
    } else {
        return [self.pickerCitiesOfSelectedProvince count];
    }
    
}

#pragma mark - 实现协议UIPickerViewDelegate方法
// 设置每个拨盘每行的标题
-(NSString *)pickerView:(UIPickerView *)pickerView
            titleForRow:(NSInteger)row
           forComponent:(NSInteger)component {
    
    if (component == 0) {
        return [self.pickerProvincesData objectAtIndex:row];
    } else {
        return [self.pickerCitiesOfSelectedProvince objectAtIndex:row];
    }
}

// 设置选择拨盘某行时做什么
- (void)pickerView:(UIPickerView *)pickerView
      didSelectRow:(NSInteger)row
       inComponent:(NSInteger)component {
    
    // 选择省份后，pickerSelectedProvincce 和 pickerCitiesOfSelectedProvince 发生变化
    if (component == 0) {
        self.pickerSelectedProvincce = [self.pickerProvincesData objectAtIndex:row];
        self.pickerCitiesOfSelectedProvince = [self.pickerData objectForKey:self.pickerSelectedProvincce];
        [self.pickerView reloadComponent:1];
    }
}

@end
