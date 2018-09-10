//
//  MyView.m
//  UIRectFrameSample
//
//  Created by tony on 2017/3/23.
//  本书网站：http://www.51work6.com
//  智捷课堂在线课堂：http://www.zhijieketang.com/
//  智捷课堂微信公共号：zhijieketang
//  作者微博：@tony_关东升
//  作者微信：tony关东升
//  QQ：569418560 邮箱：eorient@sina.com
//  QQ交流群：162030268
//

#import "MyView.h"

@implementation MyView

- (void)drawRect:(CGRect)rect {
    
    // 设置填充颜色
    [[UIColor blackColor] setFill];
    // 填充矩形
    UIRectFill(rect);
    
    // 设置描边颜色
    [[UIColor whiteColor] setStroke];
    // 设置图形 Frame
    CGRect frame = CGRectMake(20, 30, 100, 300);
    // 绘制矩形边框
    UIRectFrame(frame);
}

@end
