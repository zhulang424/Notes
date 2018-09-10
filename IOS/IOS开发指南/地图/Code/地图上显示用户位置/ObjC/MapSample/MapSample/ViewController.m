//
//  ViewController.m
//  MapSample
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
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

@interface ViewController () <MKMapViewDelegate>

@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property(nonatomic, strong) CLLocationManager *locationManager;    // 定位服务管理

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}
// 回调：视图即将显示
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear: animated];
    
    // 初始化地图视图
    self.mapView.mapType = MKMapTypeStandard;
    CLLocation *location = [[CLLocation alloc] initWithLatitude:40.002240 longitude:116.323328];            // 中心位置
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, 10000, 10000);  // 缩放比例
    self.mapView.region = viewRegion;
    self.mapView.delegate = self;
    
    // 请求定位授权（需要修改 Info.plist 文件！）
    self.locationManager = [[CLLocationManager alloc] init];
    [self.locationManager requestWhenInUseAuthorization];
    [self.locationManager requestAlwaysAuthorization];
    
    // 设置地图视图显示用户位置
    self.mapView.showsUserLocation = TRUE;
    self.mapView.userLocation.title = @"我在这里！"; // userLocation（MKUserLocation）是用户位置对象
    
    
}

#pragma mark - MKMapViewDelegate
// 回调：地图视图加载完成
- (void)mapViewDidFinishLoadingMap:(MKMapView *)mapView {
    // 设置用户跟踪模式
    mapView.userTrackingMode =  MKUserTrackingModeFollowWithHeading;    // 跟踪用户位置和前进方向
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

// 回调：点击按钮
- (IBAction)selectMapViewType:(id)sender {
    // 切换地图类型
    UISegmentedControl* sc = (UISegmentedControl*)sender;
    switch (sc.selectedSegmentIndex) {
        case 1:
            self.mapView.mapType = MKMapTypeSatellite;
            break;
        case 2:
            self.mapView.mapType = MKMapTypeHybrid;
            break;
        default:
            self.mapView.mapType = MKMapTypeStandard;
    }
}



@end
