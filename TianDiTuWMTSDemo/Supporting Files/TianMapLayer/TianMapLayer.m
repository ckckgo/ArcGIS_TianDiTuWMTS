//
//  TianMapLayer.m
//  Install and setup
//
//  Created by roger on 16/1/12.
//  Copyright © 2016年 roger. All rights reserved.
//

#import "TianMapLayer.h"
#import "TianMapInfo.h"
#import "TianMapOperation.h"

@implementation TianMapLayer

- (instancetype)initWithType:(TianMapType)layerType localServiceURL:(NSString *)url error:(NSError *__autoreleasing *)error {
    if (self = [super init]) {
        TianMapInfo *layerInfo = [TianMapInfo infoWithLayerType:layerType];
        self.layerInfo = layerInfo;
        
        if (url) {
            layerInfo.baseUrl = url;
        }
        _fullEnvelope = layerInfo.fullEnvelope;
        _tileInfo = layerInfo.tileInfo;
        [_tileInfo computeTileBounds:self.fullEnvelope];
        [super layerDidLoad];
    }
    return self;
}

#pragma mark-
- (void)requestTileForKey:(AGSTileKey *)key {
    TianMapOperation *operation = [[TianMapOperation alloc] initWithTileKey:key
                                                             tiledLayerInfo:self.layerInfo complete:^(NSData *imageData, AGSTileKey *tileKey) {
                                                                 [super setTileData:imageData forKey:tileKey];
                                                             }];
    [self.requestQueue addOperation:operation];
}

- (void)cancelRequestForKey:(AGSTileKey *)key {
    for (NSOperation *op in [AGSRequestOperation sharedOperationQueue].operations) {
        if ([op isKindOfClass:[TianMapOperation class]]) {
            TianMapOperation *offOp = (TianMapOperation *)op;
            if ([offOp.tileKey isEqualToTileKey:key]) {
                [offOp cancel];
            }
        }
    }
}

//- (void)didFinishOperation:(TianMapOperation *)op {
//    [super setTileData:op.imageData forKey:op.tileKey];
//}

#pragma mark- 重写getter
- (AGSTileInfo *)tileInfo {
    return _tileInfo;
}

- (AGSEnvelope *)fullEnvelope {
    return _fullEnvelope;
}

- (AGSSpatialReference *)spatialReference {
    return _fullEnvelope.spatialReference;
}

#pragma mark- lazyLoad
- (NSOperationQueue *)requestQueue {
    if (_requestQueue == nil) {
        _requestQueue = [[NSOperationQueue alloc] init];
        _requestQueue.maxConcurrentOperationCount = 16;
    }
    return _requestQueue;
}
@end
