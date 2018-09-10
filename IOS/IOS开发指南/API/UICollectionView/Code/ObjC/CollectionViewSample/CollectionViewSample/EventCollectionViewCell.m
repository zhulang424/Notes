//
//  EventCollectionViewCell.m
//  CollectionViewSample
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


#import "EventCollectionViewCell.h"

@implementation EventCollectionViewCell

// 自定义的 View 要添加到 self.contentView 这个属性，不要直接添加到 self.view！！！详情见文档
- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor grayColor];
        // 单元格的宽度
        CGFloat cellWidth = self.frame.size.width;
        CGFloat cellHeight = self.frame.size.height;
        // 创建 ImageView
        CGFloat imageViewWidth = cellWidth;
        CGFloat imageViewHeight = cellHeight - 20;
        CGFloat imageViewX = 0;
        CGFloat imageViewY = 0;
        self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(imageViewX, imageViewY, imageViewWidth, imageViewHeight)];
        // 添加 ImageView 到 contentView
        [self.contentView addSubview:self.imageView];
        
        // 创建标签
        CGFloat labelWidth = cellWidth;
        CGFloat labelHeight = cellHeight - imageViewHeight;
        CGFloat labelX = 0;
        CGFloat labelY = imageViewHeight;
        self.label = [[UILabel alloc] initWithFrame:CGRectMake(labelX, labelY, labelWidth, labelHeight)];
        // 设置居中
        self.label.textAlignment = NSTextAlignmentCenter;
        // 设置字体
        self.label.font = [UIFont systemFontOfSize:13];
        // 添加 Label 到 contentView
        [self.contentView addSubview:self.label];
    }
    return self;
}

@end
