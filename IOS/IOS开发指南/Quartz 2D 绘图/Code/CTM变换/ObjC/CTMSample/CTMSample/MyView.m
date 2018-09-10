//
//  MyView.m
//  CTMSample
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

    //填充白色背景
    [[UIColor whiteColor] setFill];
    UIRectFill(rect);
    
    // 创建UIImage图片对象
    UIImage *uiImage = [UIImage imageNamed:@"cat"];
    // 将UIImage图片对象转换为CGImage图片对象
    CGImageRef cgImage = uiImage.CGImage;
    // 获取绘制上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    
//    // 平移变换,沿 X 轴移动100点，沿 Y 轴移动50点（在 UIKit 坐标系中移动）
//    CGContextTranslateCTM (context, 0, 100);
//    // 缩放变换，X 轴缩小到0.5倍，Y 轴缩小到0.75倍（在 Quartz 2D 坐标系基础下缩放，根据缩放后的数值显示在 UIKit 坐标系中）
//    CGContextScaleCTM (context, 0.5, 0.75);
//    // 旋转变换
//    CGContextRotateCTM (context, (45.0 * M_PI / 180.0));
    // 组合变换，先进行进行向下的平移变换，再进行 Y 轴对称变换，再
    CGContextTranslateCTM(context, 0, uiImage.size.height);
    CGContextScaleCTM(context, 1, -1);
    
    // 设置绘制区域
    CGRect imageRect = CGRectMake(0, 0, uiImage.size.width, uiImage.size.height);
    // 根据上下文绘制图片
    CGContextDrawImage(context, imageRect, cgImage);
}

@end
