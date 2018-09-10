//
//  AppDelegate.m
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

#import "AppDelegate.h"
#import <CoreLocation/CoreLocation.h>

#define UpdateLocationNotification @"kUpdateLocationNotification"
@interface AppDelegate () <CLLocationManagerDelegate>       // 实现协议
@property(nonatomic, strong) CLLocationManager *locationManager;
@end

@implementation AppDelegate
// 回调：应用加载完成
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    // 定位服务管理对象初始化
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;     // 高精度
    self.locationManager.distanceFilter = 1000.0f;                      // 距离过滤器：最少移动1000.0米才会更新位置信息
    
    // 请求定位授权
    [self.locationManager requestWhenInUseAuthorization];   // 使用应用期间
    [self.locationManager requestAlwaysAuthorization];      // 始终

    return TRUE;
}

// 回调：应用进入活跃状态（启动、从后台恢复时都会调用）
- (void)applicationDidBecomeActive:(UIApplication *)application {
    // 开始定位
    [self.locationManager startUpdatingLocation];
    NSLog(@"开始定位");
}


// 回调：应用进入后台
- (void)applicationDidEnterBackground:(UIApplication *)application {
    // 停止定位
    [self.locationManager stopUpdatingLocation];
    NSLog(@"停止定位");
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}



- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


#pragma mark - CLLocationManagerDelegate

// 回调：位置更新
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    // 获取最新位置
    CLLocation *currLocation = [locations lastObject];
    // 发出通知，通知视图控制器新的定位信息
    [[NSNotificationCenter defaultCenter] postNotificationName:UpdateLocationNotification object:currLocation];
}

// 回调：位置更新失败
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    NSLog(@"error: %@", error);
}

// 回调：授权状态改变
- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status {

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
