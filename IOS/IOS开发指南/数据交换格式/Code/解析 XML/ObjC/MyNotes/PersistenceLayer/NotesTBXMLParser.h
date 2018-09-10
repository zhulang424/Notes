//
//  NotesTBXMLParser.h
//  MyNotes
//
//  Created by tonyguan on 2016/11/3.
//  本书网站：http://www.51work6.com
//  智捷课堂在线课堂：http://www.zhijieketang.com/
//  智捷课堂微信公共号：zhijieketang
//  作者微博：@tony_关东升
//  作者微信：tony关东升
//  QQ：569418560 邮箱：eorient@sina.com
//  QQ交流群：162030268
//

#import "TBXML.h"

@interface NotesTBXMLParser : NSObject

// 解析出的数据内部是字典类型
@property (strong,nonatomic) NSMutableArray *listData;

// 开始解析
-(void)start;

@end
