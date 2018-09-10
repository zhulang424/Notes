//
//  MyView.m
//  StrokedFilledTriangle
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

    // 填充白色背景
    [[UIColor whiteColor] setFill];
    UIRectFill(rect);
    
    // 自定义图形上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    // 定义路径：三角形
    CGContextMoveToPoint (context, 75, 10);         // 以（75，10）作为绘制起点
    CGContextAddLineToPoint (context, 10, 150);     // 定义从（75，10）到（10,150）的线段
    CGContextAddLineToPoint (context, 160, 150);    // 定义从（10,150）到（160，150）的线段，此时路径不是闭合的
    CGContextClosePath(context);                    // 闭合路径
    // 设置黑色描边参数
    [[UIColor blackColor] setStroke];
    // 设置红色条填充参数
    [[UIColor redColor] setFill];
    // 绘制路径
    CGContextDrawPath(context, kCGPathFillStroke);
    
}

@end
