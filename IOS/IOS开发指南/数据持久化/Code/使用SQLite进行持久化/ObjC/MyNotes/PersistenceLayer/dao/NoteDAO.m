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

#import "NoteDAO.h"
#import "sqlite3.h"

#define DBFILE_NAME @"NotesList.sqlite3"

@interface NoteDAO () {
    sqlite3 *db;    // C指针，数据库对象
}

//NoteDAO扩展中DateFormatter属性是私有的
@property(nonatomic, strong) NSDateFormatter *dateFormatter;

// NoteDAO扩展中沙箱目录中属性列表文件路径是私有的
@property(nonatomic, strong) NSString *plistFilePath;

@end

@implementation NoteDAO

static NoteDAO *sharedSingleton = nil;

+ (NoteDAO *)sharedInstance {
    static dispatch_once_t once;
    dispatch_once(&once, ^{

        sharedSingleton = [[self alloc] init];

        // 初始化沙盒目录中数据库文件路径
        sharedSingleton.plistFilePath = [sharedSingleton applicationDocumentsDirectoryFile];
        // 初始化DateFormatter
        sharedSingleton.dateFormatter = [[NSDateFormatter alloc] init];
        [sharedSingleton.dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        // 根据路径初始化数据库文件
        [sharedSingleton createEditableCopyOfDatabaseIfNeeded];

    });
    return sharedSingleton;
}

// 初始化数据库文件
- (void)createEditableCopyOfDatabaseIfNeeded {
    // 将 NSString 转换成 C 接受的 char* 类型
    const char *cpath = [self.plistFilePath UTF8String];
    // 打开数据库，第一个参数是数据库文件的完整路径，第二个参数是 sqlite3 指针变量的地址；返回整数
    if (sqlite3_open(cpath, &db) != SQLITE_OK) {
        NSLog(@"数据库打开失败。");
    } else {
        // 建表 SQL 语句：在表 Note 不存在时创建，否则不创建（主键 cdate，TEXT 类型；content，TEXT 类型）
        NSString *sql = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS Note (cdate TEXT PRIMARY KEY, content TEXT);"];
        // 将 NSString 类型的建表语句转换成 C 接受的 char* 类型
        const char *cSql = [sql UTF8String];
        // 执行 SQL 语句：第一个参数是 sqlite3 指针地址，第二个参数是要执行的 SQL 语句，第三个参数是要回调的函数，第四个参数是回调函数的参数，第五个参数表示执行出错的字符串
        if (sqlite3_exec(db, cSql, NULL, NULL, NULL) != SQLITE_OK) {
            NSLog(@"建表失败。");
        }
    }
    // 释放数据库资源（必须！）
    sqlite3_close(db);
}

- (NSString *)applicationDocumentsDirectoryFile {
    NSString *documentDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, TRUE) lastObject];
    NSString *path = [documentDirectory stringByAppendingPathComponent:DBFILE_NAME];
    NSLog(@"path = %@", path);
    return path;
}


//插入Note方法
- (int)create:(Note *)model {
    // 数据库文件路径
    const char *cpath = [self.plistFilePath UTF8String];
    
    // 根据路径，打开数据库
    if (sqlite3_open(cpath, &db) != SQLITE_OK) {
        NSLog(@"数据库打开失败。");
    } else {
        // 创建插入 SQL 语句
        NSString *sql = @"INSERT OR REPLACE INTO note (cdate, content) VALUES (?,?)";
        const char *cSql = [sql UTF8String];
        
        // 创建语句对象
        sqlite3_stmt *statement;
        // 预处理过程（SQL -> statement）
        if (sqlite3_prepare_v2(db, cSql, -1, &statement, NULL) == SQLITE_OK) {
            // 创建用于绑定的参数
            NSString *strDate = [self.dateFormatter stringFromDate:model.date];
            const char *cDate = [strDate UTF8String];
            const char *cContent = [model.content UTF8String];

            // 绑定参数
            sqlite3_bind_text(statement, 1, cDate, -1, NULL);   // 第二个参数代表字段序号，从1开始
            sqlite3_bind_text(statement, 2, cContent, -1, NULL);

            // 执行statement，插入数据
            if (sqlite3_step(statement) != SQLITE_DONE) {
                NSLog(@"插入数据失败。");
            }
        }
        sqlite3_finalize(statement);    // 释放 statement 对象
    }
    sqlite3_close(db);  // 关闭数据库
    return 0;
}

// 删除Note方法
- (int)remove:(Note *)model {
    // 数据库文件路径
    const char *cpath = [self.plistFilePath UTF8String];
    // 打开数据库
    if (sqlite3_open(cpath, &db) != SQLITE_OK) {
        NSLog(@"数据库打开失败。");
    } else {
        // 创建 SQL 语句
        NSString *sql = @"DELETE  from note where cdate =?";
        const char *cSql = [sql UTF8String];
        // 创建语句对象
        sqlite3_stmt *statement;
        // 预处理（将 SQL 语句编译成二进制代码（statement），提高执行速度）
        if (sqlite3_prepare_v2(db, cSql, -1, &statement, NULL) == SQLITE_OK) {
            // 创建用于绑定的参数
            NSString *strDate = [self.dateFormatter stringFromDate:model.date];
            const char *cDate = [strDate UTF8String];
            // 绑定参数
            sqlite3_bind_text(statement, 1, cDate, -1, NULL);
            // 执行删除数据的语句
            if (sqlite3_step(statement) != SQLITE_DONE) {
                NSLog(@"删除数据失败。");
            }
        }
        sqlite3_finalize(statement);    // 释放 statement 对象
    }
    sqlite3_close(db);  // 关闭数据库
    return 0;
}

// 修改方法
- (int)modify:(Note *)model {
    // 数据库文件路径
    const char *cpath = [self.plistFilePath UTF8String];
    // 根据路径打开数据库
    if (sqlite3_open(cpath, &db) != SQLITE_OK) {
        NSLog(@"数据库打开失败。");
    } else {
        // 创建 SQL 语句
        NSString *sql = @"UPDATE note set content=? where cdate =?";
        const char *cSql = [sql UTF8String];
        // 创建语句对象
        sqlite3_stmt *statement;
        // 预处理
        if (sqlite3_prepare_v2(db, cSql, -1, &statement, NULL) == SQLITE_OK) {
            // 用于绑定的参数
            NSString *strDate = [self.dateFormatter stringFromDate:model.date];
            const char *cDate = [strDate UTF8String];
            const char *cContent = [model.content UTF8String];
            // 绑定参数
            sqlite3_bind_text(statement, 1, cContent, -1, NULL);
            sqlite3_bind_text(statement, 2, cDate, -1, NULL);
            // 执行语句
            if (sqlite3_step(statement) != SQLITE_DONE) {
                NSLog(@"修改数据失败。");
            }
        }
        sqlite3_finalize(statement);    // 释放 statement 对象

    }
    sqlite3_close(db);  // 关闭数据库
    return 0;
}

// 查询所有数据方法
- (NSMutableArray *)findAll {
    // 数据库文件路径
    const char *cpath = [self.plistFilePath UTF8String];
    // 创建用于储存返回结果的可变数组
    NSMutableArray *listData = [[NSMutableArray alloc] init];
    
    // 打开数据库
    if (sqlite3_open(cpath, &db) != SQLITE_OK) {
        NSLog(@"数据库打开失败。");
    } else {
        // 创建查询 SQL 语句
        NSString *sql = @"SELECT cdate,content FROM Note";
        const char *cSql = [sql UTF8String];

        // 创建语句对象
        sqlite3_stmt *statement;
        // 预处理过程（SQL -> statement）
        if (sqlite3_prepare_v2(db, cSql, -1, &statement, NULL) == SQLITE_OK) {
            // 执行查询
            while (sqlite3_step(statement) == SQLITE_ROW) { // 遍历查询结果
                // 从查询到的某行数据中，提取 cdate 字段
                char *bufDate = (char *) sqlite3_column_text(statement, 0); // 提取 TEXT 类型的字段，参数2表示 select 字段索引0（cdate 字段）
                NSString *strDate = [[NSString alloc] initWithUTF8String:bufDate];
                NSDate *date = [self.dateFormatter dateFromString:strDate];
                
                // 从查询到的某行数据中，提取  content 字段
                char *bufContent = (char *) sqlite3_column_text(statement, 1);  // 提取 TEXT 类型的字段，参数2表示 select 字段索引1（content 字段）
                NSString *strContent = [[NSString alloc] initWithUTF8String:bufContent];
                
                // 根据提出的字段创建对象
                Note *note = [[Note alloc] initWithDate:date content:strContent];

                // 将对象添加到储存结果的可变数组
                [listData addObject:note];
            }
            
            // 释放资源
            sqlite3_finalize(statement);    // 释放二进制语句对象
            sqlite3_close(db);  // 关闭数据库
            
            return listData;
        }
        sqlite3_finalize(statement);    // 释放二进制语句对象
    }
    sqlite3_close(db);  // 关闭数据库
    return listData;
}

// 按照主键查询数据方法
- (Note *)findById:(Note *)model {
    // 数据库文件路径
    const char *cpath = [self.plistFilePath UTF8String];
    // 打开数据库（第一个参数是数据库文件的完整路径，第二个参数是 sqlite3 指针变量的地址；返回值是整数类型）
    if (sqlite3_open(cpath, &db) != SQLITE_OK) {
        NSLog(@"数据库打开失败。");
    } else {
        // 创建查询 SQL 语句
        NSString *sql = @"SELECT cdate,content FROM Note where cdate =?";   // “?”是占位符，需要绑定参数
        const char *cSql = [sql UTF8String];    // 将 NSString 类型的查询语句转化成 C 接受的 char* 类型

         // 创建二进制语句对象（真正用于执行的语句）
        sqlite3_stmt *statement;
        // 预处理过程（目的是将 SQL 编译成二进制代码（statement），提高执行速度）
        if (sqlite3_prepare_v2(db, cSql, -1, &statement, NULL) == SQLITE_OK) {  // 参数3代表全部 SQL 字符串的长度；参数4是 sqlite3_stmt 指针地址，是语句对象，通过该语句对象执行 SQL 语句；参数5是 SQL 语句没有执行的部分语句
            
            // 绑定参数
            NSString *strDate = [self.dateFormatter stringFromDate:model.date];
            const char *cDate = [strDate UTF8String];
            sqlite3_bind_text(statement, 1, cDate, -1, NULL);   // 参数1是 statement 指针，参数2是字段序号（从1开始），参数3是要替换的参数值，参数4是字符串长度（字节），参数5是函数指针

            // 执行查询 SQL 语句（statement，二进制的 SQL 语句）
            if (sqlite3_step(statement) == SQLITE_ROW) {    // 如果有查询结果（SQLITE_ROW 代表查到了数据）
                // 从查询结果中提取 cdate 字段数据
                char *bufDate = (char *) sqlite3_column_text(statement, 0); // 提取 TEXT 类型的字段，参数2表示 select 字段索引0（cdate 字段）
                NSString *strDate = [[NSString alloc] initWithUTF8String:bufDate];  // 将 char* 转化成 NSString
                NSDate *date = [self.dateFormatter dateFromString:strDate];
                
                // 从查询结果中提取 content 字段数据
                char *bufContent = (char *) sqlite3_column_text(statement, 1);  // 提取 TEXT 类型的字段，参数2表示 select 字段索引1（cotent 字段）
                NSString *strContent = [[NSString alloc] initWithUTF8String:bufContent];
                
                // 根据提取出的数据创建 Modal
                Note *note = [[Note alloc] initWithDate:date content:strContent];
                
                // 释放资源
                sqlite3_finalize(statement);    // 释放二进制语句对象
                sqlite3_close(db);  // 关闭数据库

                return note;
            }
        }
        sqlite3_finalize(statement);    // 释放二进制语句对象
    }
    sqlite3_close(db);  // 关闭数据库
    return nil;
}

@end
