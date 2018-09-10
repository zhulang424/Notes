//
//  NotesTBXMLParser.m
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

#import "NotesTBXMLParser.h"


@implementation NotesTBXMLParser

// 开始解析
-(void)start {
    // 创建用于存储解析出的 实体对象 的集合
    self.listData = [[NSMutableArray alloc] init];
    
    // 创建 TBXML 解析器
    TBXML* tbxml = [[TBXML alloc] initWithXMLFile:@"Notes.xml" error:nil];
    // 获取文档 根元素
    TBXMLElement * root = tbxml.rootXMLElement;
    
	// 如果 根元素 有效，开始解析
	if (root) {
        // 查找 根元素 下的 子元素“Note”（如果有多个“Note”，只返回第一个）
		TBXMLElement * noteElement = [TBXML childElementNamed:@"Note" parentElement:root];  // 根据 父元素 查找 子元素
        // 如果 子元素“Note” 存在，创建 实体对象 并根据数据初始化
        while ( noteElement != nil) {
            // 创建实体对象
            NSMutableDictionary *dict = [NSMutableDictionary new];
            // 通过 子元素 获取“CDate”属性
            TBXMLElement *dateElement = [TBXML childElementNamed:@"CDate" parentElement:noteElement];   // 根据 父元素 查找 子元素
            if ( dateElement != nil) {
                NSString *date = [TBXML textForElement:dateElement];    // 取出元素内容
                dict[@"CDate"] = date;
            }
            // 通过 子元素 获取“Content”属性
            TBXMLElement *contentElement = [TBXML childElementNamed:@"Content" parentElement:noteElement];  // 根据 父元素 查找 子元素
            if ( contentElement != nil) {
                NSString *content = [TBXML textForElement:contentElement];  // 取出元素内容
                dict[@"Content"] = content;
            }
            // 通过 子元素 获取“UserID”属性
            TBXMLElement *userIDElement = [TBXML childElementNamed:@"UserID" parentElement:noteElement];    // 根据 父元素 查找 子元素
            if ( userIDElement != nil) {
                NSString *userID = [TBXML textForElement:userIDElement];    // 取出元素内容
                dict[@"UserID"] = userID;
            }
            //  通过 元素属性 获得“ID”属性
            NSString *identifier = [TBXML valueOfAttributeNamed:@"id" forElement:noteElement error:nil];    
            dict[@"id"] = identifier;
            // 将实体对象放入集合
            [self.listData addObject:dict];
            
            // 获取同层的下一个“Note”元素，继续循环
            noteElement = [TBXML nextSiblingNamed:@"Note" searchFromElement:noteElement];
            
		}
    }
    
    // 解析完成，将解析出的数据返回给视图
    NSLog(@"TBXML解析完成...");
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"reloadViewNotification" object:self.listData userInfo:nil];
    self.listData = nil;
    
}


@end
