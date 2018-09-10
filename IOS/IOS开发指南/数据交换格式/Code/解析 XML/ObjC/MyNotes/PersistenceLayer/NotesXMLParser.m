//
//  NotesXMLParser.m
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

#import "NotesXMLParser.h"

@implementation NotesXMLParser

#pragma mark - NSXMLParserDelegate
// 开始解析
- (void)start {
    // 获取 XML文件路径
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Notes" ofType:@"xml"];
    NSURL *url = [NSURL fileURLWithPath:path];  // 转化为 NSURL 类型
    // 解析 XML 文件
    NSXMLParser *parser = [[NSXMLParser alloc] initWithContentsOfURL:url];
    parser.delegate = self;
    [parser parse];
}

// 事件处理：文档开始
- (void)parserDidStartDocument:(NSXMLParser *)parser {
    // 初始化用于存储解析数据的集合对象
    self.listData = [[NSMutableArray alloc] init];
}



// 事件处理：遇到 开始标签
- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qualifiedName attributes:(NSDictionary *)attributeDict {
    // 设置 当前解析标签名（元素名）
    self.currentTagName = elementName;
    // 如果 标签名 代表实体对象的话，创建实体对象并初始化
    if ([self.currentTagName isEqualToString:@"Note"]) {
        NSString *identifier = [attributeDict objectForKey:@"id"];  // 获取元素属性
        NSMutableDictionary *dict = [[NSMutableDictionary alloc] init]; // 创建实体对象
        [dict setObject:identifier forKey:@"id"];   // 根据元素属性初始化实体对象
        [self.listData addObject:dict];
    }

}

// 事件处理：遇到 字符串
- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    // 剔除字符串中 回车符、空格
    string = [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if ([string isEqualToString:@""]) {
        return;
    }
    // 取出正在解析数据对应的 实体对象
    NSMutableDictionary *dict = [self.listData lastObject];
    // 根据 当前解析标签名，设置实体对象的属性
    if ([self.currentTagName isEqualToString:@"CDate"] && dict) {
        [dict setObject:string forKey:@"CDate"];
    }
    if ([self.currentTagName isEqualToString:@"Content"] && dict) {
        [dict setObject:string forKey:@"Content"];
    }
    if ([self.currentTagName isEqualToString:@"UserID"] && dict) {
        [dict setObject:string forKey:@"UserID"];
    }
}

// 事件处理：遇到 结束标签
- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    // 清空 当前解析标签名
    self.currentTagName = nil;
}

// 事件处理：遇到文档结束
- (void)parserDidEndDocument:(NSXMLParser *)parser {
    // 将数据返回给视图
    NSLog(@"NSXML解析完成...");
    [[NSNotificationCenter defaultCenter] postNotificationName:@"reloadViewNotification" object:self.listData userInfo:nil];

}

// 刷金处理：解析出错
- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError {
    NSLog(@"%@", parseError);
}

@end
