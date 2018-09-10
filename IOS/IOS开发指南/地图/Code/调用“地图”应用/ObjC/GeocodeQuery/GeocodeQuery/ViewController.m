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
#import <MapKit/MapKit.h>

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

// 回调：点击按钮（查询地点并调用“地图”应用）
- (IBAction)geocodeQuery:(id)sender {

    if (self.txtQueryKey.text == nil) {
        return;
    }
    
    // 初始化：查询对象
    MKLocalSearchRequest *request = [[MKLocalSearchRequest alloc] init];
    request.naturalLanguageQuery = self.txtQueryKey.text;   // 根据字符串进行查询
    MKLocalSearch *search = [[MKLocalSearch alloc] initWithRequest:request];
    // 进行查询
    [search startWithCompletionHandler:^(MKLocalSearchResponse *response, NSError *error) { // 查询回调代码快
        
        if ([response.mapItems count] > 0) {
            // 取出最后一个地标点
            MKMapItem *lastMapItem = response.mapItems.lastObject;
            // 调用“地图”应用，显示地标点
            [lastMapItem openInMapsWithLaunchOptions:nil];
            
//            // 取出最后一个地标点
//            MKMapItem *lastMapItem = response.mapItems.lastObject;
//            // 调用“地图”应用，显示路线（起点是当前位置）
//            NSDictionary* options = @{MKLaunchOptionsDirectionsModeKey : MKLaunchOptionsDirectionsModeDriving};   // 行车路线
//            [lastMapItem openInMapsWithLaunchOptions:options];
        }
    }];

    //关闭键盘
    [self.txtQueryKey resignFirstResponder];
}

@end
