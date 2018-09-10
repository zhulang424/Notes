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

// 显示视图时，初始化地图
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear: animated];
    
    // 设置地图类型
    self.mapView.mapType = MKMapTypeStandard;

    // 设置地图3D属性
    [self placeCamera];
}



// 设置地图3D属性
-(void) placeCamera {
    // 设置3D相机
    MKMapCamera* mapCamera = [MKMapCamera camera];
    mapCamera.centerCoordinate = CLLocationCoordinate2DMake(40.002240, 116.323328); // 中心坐标
    mapCamera.pitch = 60;           // 摄像机俯角
    mapCamera.altitude = 1000;      // 摄像机高度
    mapCamera.heading = 45;         // 摄像头指向方向
    
    // 设置地图视图的camera属性
    self.mapView.camera = mapCamera;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

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
    
    [self placeCamera];
}

@end
