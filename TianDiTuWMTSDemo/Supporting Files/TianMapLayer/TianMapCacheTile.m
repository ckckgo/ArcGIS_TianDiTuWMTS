//
//  TianMapCacheTile.m
//  TianDiTuWMTSDemo
//
//  Created by Henry on 16/1/14.
//  Copyright © 2016年 Henry. All rights reserved.CoreSimulator
//

#import "TianMapCacheTile.h"
#import "fmdb.h"

@implementation TianMapCacheTile

static FMDatabaseQueue *_queue;
static FMDatabase *_db;
+ (void)initialize {
    
    NSString *cachePath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).firstObject;
    NSString *filePath = [cachePath stringByAppendingPathComponent:@"TianMapTile.sqlite"];
    NSLog(@"filePath = %@",filePath);
    _db = [FMDatabase databaseWithPath:filePath];
    _queue = [FMDatabaseQueue databaseQueueWithPath:filePath];
    if (![_db open]) {
        NSLog(@"database open failed!");
    } else {
        if (![_db executeUpdate:@"create table if not exists t_tile (id integer primary key autoincrement, url text not null unique, imageData blob);"]) {
            NSLog(@"create t_tile failed!");
        }
        [_db close];
    }
}


+ (void)saveTileData:(NSData *)data WithURL:(NSString *)urlStr {
    [_queue inDatabase:^(FMDatabase *db) {
        [_db open];
        if (![_db executeUpdate:@"insert into t_tile (url, imageData) values(?, ?);",urlStr, data]) {
            NSLog(@"插入数据失败");
        }
        [_db close];
    }];
}

+ (NSData *)tileDataWithURL:(NSString *)urlStr {
    __block NSData *imageData;
    [_queue inDatabase:^(FMDatabase *db) {
        [_db open];
        FMResultSet *result = [_db executeQuery:@"select * from t_tile where url = ?", urlStr];
        while ([result next]) {
            imageData = [result dataForColumn:@"imageData"];
        }
        [_db close];
    }];
    
    return imageData;
}
@end
