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

@interface ViewController ()

@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

// 初始化地图
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear: animated];
    // 设置地图类型（值发生变化时自动重新加载）
    self.mapView.mapType = MKMapTypeStandard;
    // 设置地图中心点
    CLLocation *location = [[CLLocation alloc] initWithLatitude:40.002240 longitude:116.323328];
    /** 设置显示区域
     centerCoordina：中心点
     latitudinalMeters：南北跨度
     longitudinalMeters：东西跨度
     */
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, 10000, 10000);
    self.mapView.region = viewRegion;
}

// 通过分段控件调整地图类型
- (IBAction)selectMapViewType:(id)sender {
    
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
