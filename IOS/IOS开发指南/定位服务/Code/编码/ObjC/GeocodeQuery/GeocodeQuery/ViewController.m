//
//  ViewController.m
//  GeocodeQuery
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

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITextView *txtView;
@property (weak, nonatomic) IBOutlet UITextField *txtQueryKey;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.txtView.text = @"";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// 查询坐标（根据字符串）
//- (IBAction)geocodeQuery:(id)sender {
//    
//    if (self.txtQueryKey.text == nil) {
//        return;
//    }
//    
//    // 初始化：转换管理对象
//    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
//    // 查询坐标（根据字符串）
//    [geocoder geocodeAddressString:self.txtQueryKey.text
//                 completionHandler:^(NSArray<CLPlacemark *> * placemarks, NSError * error) {    // placemarks：查询出的地标数组
//                     
//        if (error) {                                            // 查询失败
//            NSLog(@"Error is %@",error.localizedDescription);
//        } else if ([placemarks count] > 0) {                    // 查询成功
//            // 地标对象
//            CLPlacemark* placemark = placemarks[0];
//            // 地点名称
//            NSString* name = placemark.name;
//            // 坐标
//            CLLocation *location = placemark.location;
//            double lng = location.coordinate.longitude;
//            double lat = location.coordinate.latitude;
//            
//            self.txtView.text = [NSString stringWithFormat:@"经度：%3.5f \n纬度：%3.5f \n%@", lng, lat, name];
//        }
//    }];
//    
//    [self.txtQueryKey resignFirstResponder];
//}

// 查询坐标（根据字符串和查询范围）
- (IBAction)geocodeQuery:(id)sender {
    
    if (self.txtQueryKey.text == nil) {
        return;
    }
    
    // 初始化：转换管理对象
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    // 初始化：查询范围
    CLLocation *regionCenter = [[CLLocation alloc] initWithLatitude:40.002240
                                                          longitude:117.323328];
    CLCircularRegion *region = [[CLCircularRegion alloc] initWithCenter:regionCenter.coordinate
                                                                 radius:5000
                                                             identifier:@"GeocodeRegion"];
    // 查询坐标（根据字符串和查询范围）
    [geocoder geocodeAddressString:self.txtQueryKey.text
                          inRegion:region
                 completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        
        if (error) {
            NSLog(@"Error is: %@",error.localizedDescription);
        } else if ([placemarks count] > 0) {
            // 地标对象
            CLPlacemark* placemark = placemarks[0];
            // 地点名称
            NSString* name = placemark.name;
            // 坐标
            CLLocation *location = placemark.location;
            double lng = location.coordinate.longitude;
            double lat = location.coordinate.latitude;
            
            self.txtView.text = [NSString stringWithFormat:@"经度：%3.5f \n纬度：%3.5f \n%@", lng, lat, name];
        }
    }];

    [self.txtQueryKey resignFirstResponder];
}

@end
