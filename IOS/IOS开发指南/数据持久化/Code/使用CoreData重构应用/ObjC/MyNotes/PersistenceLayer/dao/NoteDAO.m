//
//  NoteDAO.m
//  MyNotes
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

#import <CoreData/CoreData.h>
#import "NoteDAO.h"
#import "NoteManagedObject+CoreDataProperties.h"

@interface NoteDAO()

@property (nonatomic,strong) NSDateFormatter *dateFormatter;

@end

@implementation NoteDAO

static NoteDAO *sharedSingleton = nil;

+ (NoteDAO *)sharedInstance {
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        
        sharedSingleton = [[self alloc] init];
        
        // 初始化DateFormatter
        sharedSingleton.dateFormatter = [[NSDateFormatter alloc] init];
        [sharedSingleton.dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        
    });
    return sharedSingleton;
}

// 插入方法
- (int)create:(Note *)model {
    // 获取 被管理对象上下文
    NSManagedObjectContext *context = self.persistentContainer.viewContext;
    
    // 插入 被管理对象
    NoteManagedObject *note = [NSEntityDescription insertNewObjectForEntityForName:@"Note" inManagedObjectContext:context];
    note.date = model.date;
    note.content = model.content;
    
    // 保存数据并同步到 持久化数据文件
    [self saveContext];
    return 0;
}

// 删除方法
- (int)remove:(Note *)model {
    // 获取 被管理对象上下文
    NSManagedObjectContext *context = self.persistentContainer.viewContext;
    // 获取 实体描述对象（由 被管理对象上下文 得到）
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"Note" inManagedObjectContext:context];
    // 创建谓词对象（用于过滤集合）
    NSPredicate *predicate = [NSPredicate predicateWithFormat: @"date = %@", model.date];
    // 创建并初始化 数据请求对象
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    request.entity = entityDescription;
    request.predicate = predicate;
    
    // 执行查询请求
    NSError *error = nil;
    NSArray *listData = [context executeFetchRequest:request error:&error];
    // 遍历查询结果，使用上下文删除 被管理对象，保存数据并同步到 持久化数据文件
    if (error == nil && [listData count] > 0) {
        NoteManagedObject *note = [listData lastObject];
        [context deleteObject:note];    // 使用 被管理对象上下文 删除指定 被管理对象
        
        [self saveContext]; // 保存数据
    }
    return 0;
}

// 修改方法
- (int)modify:(Note *)model {
    // 获取 被管理对象上下文
    NSManagedObjectContext *context = self.persistentContainer.viewContext;
    // 获取 实体描述对象（由 被管理对象上下文 得到）
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"Note" inManagedObjectContext:context];
    // 创建谓词对象（用于过滤集合）
    NSPredicate *predicate = [NSPredicate predicateWithFormat: @"date = %@", model.date];
    // 创建并初始化 数据请求对象
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    request.entity = entityDescription;
    request.predicate = predicate;
    
    // 执行查询请求
    NSError *error = nil;
    NSArray *listData = [context executeFetchRequest:request error:&error];
    
    // 修改
    if (error == nil && [listData count] > 0) {
        NoteManagedObject *note = [listData lastObject];
        note.content = model.content;
        // 保存数据
        [self saveContext];
    }
    return 0;
}

// 查询所有数据方法（无条件查询：返回所有的被管理实体对象 NSManagedObject，并按照 date 属性 升序 排列）
- (NSMutableArray *)findAll {
    //********** 创建并初始化 数据请求对象（用于查询）**********
    // 创建数据请求对象
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    // 设置 实体描述对象（由被管理对象上下文得到）
    NSManagedObjectContext *context = self.persistentContainer.viewContext; // 获取 被管理对象上下文
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Note" inManagedObjectContext:context];   // 获取 实体描述对象
    fetchRequest.entity = entity;   // 把 实体描述 设置到 请求对象 中
    // 设置 排序描述对象数组（指定排序字段和排序方式）
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"date" ascending:TRUE];   // 创建 排序描述类，指定 排序字段 和 排序方式
    NSArray *sortDescriptors = @[sortDescriptor];
    fetchRequest.sortDescriptors = sortDescriptors; // 把 排序描述对象 数组设置到 请求对象
    
    //********** 执行查询 **********
    NSError *error = nil;
    NSArray *listData = [context executeFetchRequest:fetchRequest error:&error];    // 查询返回的数组中是 NoteManagedObject 对象
    if (error != nil) {
        return nil;
    }
    
    //********** 将查询得到的 NoteManagedObject 对象转换成 Note 对象并返回 **********
    NSMutableArray *resListData = [[NSMutableArray alloc] init];
    for (NoteManagedObject *mo in listData) {
        Note *note = [[Note alloc] initWithDate:mo.date content:mo.content];
        [resListData addObject:note];
    }
    return resListData;
}

// 按照主键查询数据方法（有条件查询）
- (Note *)findById:(Note *)model {
    //********** 创建并初始化数据请求对象（用于查询）**********
    // 创建 数据请求对象
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    // 设置 实体描述对象（由被管理对象上下文得到）
    NSManagedObjectContext *context = self.persistentContainer.viewContext;
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Note" inManagedObjectContext:context];
    fetchRequest.entity = entity;
    // 设置 谓词对象（用于过滤集合）
    fetchRequest.predicate = [NSPredicate predicateWithFormat: @"date = %@",model.date];
    
    //********** 执行查询 **********
    NSError *error = nil;
    NSArray *listData = [context executeFetchRequest:fetchRequest error:&error]; // 使用 被管理对象上下文 进行查询
    
    //********** 将查询得到的 NoteManagedObject 对象转换成 Note 对象并返回 **********
    if (error == nil && [listData count] > 0) {
        NoteManagedObject *mo = [listData lastObject];
        Note *note = [[Note alloc] initWithDate:mo.date content:mo.content];
        return note;
    }
    return nil;
}


@end
