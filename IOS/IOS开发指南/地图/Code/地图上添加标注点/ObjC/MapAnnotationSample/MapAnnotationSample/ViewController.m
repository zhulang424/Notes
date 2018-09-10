//
//  ViewController.m
//  MapAnnotationSample
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
#import "MyAnnotation.h"

@interface ViewController () <MKMapViewDelegate>

@property(weak, nonatomic) IBOutlet MKMapView *mapView;
@property(weak, nonatomic) IBOutlet UITextField *txtQueryKey;
@property(weak, nonatomic) IBOutlet UITextView *txtView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.mapView.mapType = MKMapTypeStandard;
    self.mapView.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// 根据字符串查询，初始化地图标注信息对象
- (IBAction)geocodeQuery:(id)sender {
    
    if (self.txtQueryKey.text == nil || [self.txtQueryKey.text length] == 0) {
        return;
    }
    // 初始化：转换管理对象（用于查询地点）
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    // 根据字符串查询地点
    [geocoder geocodeAddressString:_txtQueryKey.text completionHandler:^(NSArray *placemarks, NSError *error) {
        
        NSLog(@"查询记录数：%lu", [placemarks count]);
        
        // 移除地图所有标注点
        [self.mapView removeAnnotations:self.mapView.annotations];
        
        // 初始化地图标注信息，并添加到地图视图
        for (CLPlacemark *placemark in placemarks) {
            // 初始化：地图标注信息
            MyAnnotation *annotation = [[MyAnnotation alloc] initWithCoordinate:placemark.location.coordinate];
            annotation.streetAddress = placemark.thoroughfare;  // 街道信息
            annotation.city = placemark.locality;               // 城市信息
            annotation.state = placemark.administrativeArea;    // 行政区信息
            annotation.zip = placemark.postalCode;              // 邮编
            // 给地图添加：地图标注信息
            [self.mapView addAnnotation:annotation];
        }
        
        // 移动地图显示区域：到最后一个地标附近
        if ([placemarks count] > 0) {
            // 最后一个地标
            CLPlacemark *lastPlacemark = placemarks.lastObject;
            // 地图中心点和缩放比例
            MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(lastPlacemark.location.coordinate, 10000, 10000);
            // 移动地图显示区域
            [self.mapView setRegion:viewRegion animated:TRUE];
        }
        
        // 关闭键盘
        [_txtQueryKey resignFirstResponder];
    }];
}

#pragma mark - MKMapViewDelegate
// 回调：给地图添加标注点
- (MKAnnotationView *)mapView:(MKMapView *)theMapView viewForAnnotation:(id <MKAnnotation>)annotation {
    
    // 初始化：大头针标注视图
    MKPinAnnotationView *annotationView = (MKPinAnnotationView *) [self.mapView dequeueReusableAnnotationViewWithIdentifier:@"PIN_ANNOTATION"];
    if (annotationView == nil) {
        annotationView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"PIN_ANNOTATION"];
    }
    annotationView.pinTintColor = [UIColor redColor];   // 设置颜色
    annotationView.animatesDrop = TRUE;                 // 是否以动画效果显示在地图上
    annotationView.canShowCallout = TRUE;               // 点击大头针是否显示地点信息
    
    return annotationView;
}

- (void)mapViewDidFailLoadingMap:(MKMapView *)theMapView withError:(NSError *)error {
    NSLog(@"error : %@", [error localizedDescription]);
}

@end
