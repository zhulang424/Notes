//
//  ViewController.m
//  MyLocation
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
#import <CoreLocation/CoreLocation.h>

@interface ViewController () <CLLocationManagerDelegate>        // 实现协议

//经度
@property (weak, nonatomic) IBOutlet UITextField *txtLng;
//纬度
@property (weak, nonatomic) IBOutlet UITextField *txtLat;
//高度
@property (weak, nonatomic) IBOutlet UITextField *txtAlt;

@property(nonatomic, strong) CLLocationManager *locationManager;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    

}

// 在视图显示时开启定位最合适
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    // 初始化：定位服务管理对象
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    /** 设置：期望精确度（精确越高，越耗时耗电；并且第一次获取的信息不一定能达到期望精确度，因为定位服务会以最快速度提交一次信息，之后再根据期望精确度提交更多的信息）
     kCLLocationAccuracyBestForNavigation：最高精确度，并且混合其他传感器的信息
     kCLLocationAccuracyBest：最高精确度
     kCLLocationAccuracyNearestTenMeters：精确到10米
     kCLLocationAccuracyHundredMeters：精确到100米
     kCLLocationAccuracyKilometer：精确到1000米
     kCLLocationAccuracyThreeKilometers：精确到3000米
     */
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    // 设置：更新定位信息的最小移动距离（单位是米，默认是 kCLDistanceFilterNone，任何移动都会更新定位信息）
    self.locationManager.distanceFilter = 1000.0f;
    // 请求定位授权（需要配置 Info.plist 文件）
    [self.locationManager requestWhenInUseAuthorization];   // 请求“使用应用期间”授权
    [self.locationManager requestAlwaysAuthorization];      // 请求“始终”授权
    self.locationManager.pausesLocationUpdatesAutomatically = YES;
    // 开始定位
    [self.locationManager startUpdatingLocation];
    NSLog(@"开始定位");
}

// 视图消失（应用进入后台）时停止定位
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    // 停止定位
    [self.locationManager stopUpdatingLocation];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - CLLocationManagerDelegate
// 事件处理：位置更新
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    // locations 是位置信息的集合，按照时间顺序存放，如果想要获得当前位置信息，使用数组最后一个元素
    
    // 当前位置信息（altitude：高度，coordinate.latitude：纬度，coordinate.longitude：经度）
    CLLocation *currLocation = [locations lastObject];
    self.txtLat.text = [NSString stringWithFormat:@"%3.5f",
                        currLocation.coordinate.latitude];
    self.txtLng.text = [NSString stringWithFormat:@"%3.5f",
                        currLocation.coordinate.longitude];
    self.txtAlt.text = [NSString stringWithFormat:@"%3.5f",
                        currLocation.altitude];
    
}
// 事件处理：位置更新失败
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    NSLog(@"error: %@",error);
}

// 事件处理：授权状态变化
- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status {
    /** 当前 app 位置服务授权状态
     kCLAuthorizationStatusNotDetermined：用户还没确定授权状态
     kCLAuthorizationStatusRestricted：用户无法更改授权状态（可能是因为“访问限制”）
     kCLAuthorizationStatusDenied：用户决绝授权位置服务 或 在设置中关闭了“定位”
     kCLAuthorizationStatusAuthorizedAlways：获得位置服务授权“始终”
     kCLAuthorizationStatusAuthorizedWhenInUse：获得位置服务授权“使用应用期间”
     */
    
    if (status == kCLAuthorizationStatusAuthorizedAlways) {
        NSLog(@"已经授权");
    } else if (status == kCLAuthorizationStatusAuthorizedWhenInUse) {
        NSLog(@"当使用时候授权");
    } else if (status == kCLAuthorizationStatusDenied) {
        NSLog(@"拒绝");
    } else if (status == kCLAuthorizationStatusRestricted) {
        NSLog(@"受限");
    } else if (status == kCLAuthorizationStatusNotDetermined) {
        NSLog(@"用户还没有确定");
    }
}

@end
