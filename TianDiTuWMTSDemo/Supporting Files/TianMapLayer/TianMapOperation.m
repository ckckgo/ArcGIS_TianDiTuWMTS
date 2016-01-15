//
//  TianMapOperation.m
//  Install and setup
//
//  Created by roger on 16/1/12.
//  Copyright © 2016年 roger. All rights reserved.
//

#import "TianMapOperation.h"
#import "TianMapInfo.h"
#import "TianMapCacheTile.h"
#define kURL_GET_TILE @"%@?service=wmts&request=gettile&version=1.0.0&layer=%@&STYLE=default&tilematrixset=%@&tilematrix=%tu&tilerow=%tu&tilecol=%tu&format=tiles"

@interface TianMapOperation ()
@property (nonatomic, strong) TianMapInfo *layerInfo; ///< layer传入的layerInfo
@property (nonatomic, copy) void (^complete)(NSData *, AGSTileKey *); ///< block回调
@end

@implementation TianMapOperation
- (instancetype)initWithTileKey:(AGSTileKey *)tileKey tiledLayerInfo:(TianMapInfo *)layerInfo complete:(void (^)(NSData *, AGSTileKey *))complete {
    if (self = [super init]) {
        self.tileKey = tileKey;
        self.layerInfo = layerInfo;
        self.complete = complete;
    }
    return self;
}

- (void)main {
    if (self.cancelled) {
        return;
    }
    NSString *strUrl = [NSString stringWithFormat:kURL_GET_TILE, self.layerInfo.baseUrl, self.layerInfo.layerName, self.layerInfo.tileMatrixSet, self.tileKey.level, self.tileKey.row, self.tileKey.column];

    NSData *imageData = [TianMapCacheTile tileDataWithURL:strUrl];
    if (imageData == nil) {
        NSURL *aURL = [NSURL URLWithString:strUrl];
        imageData = [NSData dataWithContentsOfURL:aURL];
        [TianMapCacheTile saveTileData:imageData WithURL:strUrl];
    }
    
    if (!self.isCancelled && imageData) {
        self.complete(imageData, self.tileKey);
    }
    
}
@end
