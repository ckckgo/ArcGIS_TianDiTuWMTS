//
//  TianMapOperation.h
//  Install and setup
//
//  Created by roger on 16/1/12.
//  Copyright © 2016年 roger. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ArcGIS/ArcGIS.h>
@class TianMapInfo;

@interface TianMapOperation : NSOperation
@property (nonatomic, strong) AGSTileKey *tileKey; ///< layer传入的tileKey

- (instancetype)initWithTileKey:(AGSTileKey *)tileKey
                 tiledLayerInfo:(TianMapInfo *)layerInfo
                       complete:(void(^)(NSData *imageData, AGSTileKey *tileKey))complete;
@end
