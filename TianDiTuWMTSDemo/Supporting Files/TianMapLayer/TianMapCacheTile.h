//
//  TianMapCacheTile.h
//  TianDiTuWMTSDemo
//
//  Created by Henry on 16/1/14.
//  Copyright © 2016年 Henry. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TianMapCacheTile : NSObject

/// 保存tile
+ (void)saveTileData:(NSData *)data WithURL:(NSString *)urlStr;

/// 获取tile
+ (NSData *)tileDataWithURL:(NSString *)urlStr;
@end
