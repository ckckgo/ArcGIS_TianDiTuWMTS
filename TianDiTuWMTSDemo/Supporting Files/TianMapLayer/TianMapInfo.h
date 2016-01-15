//
//  TianMapInfo.h
//  Install and setup
//
//  Created by roger on 16/1/12.
//  Copyright © 2016年 roger. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ArcGIS/ArcGIS.h>
#import "TianMapLayer.h"

@interface TianMapInfo : NSObject

@property (nonatomic, copy) NSString *baseUrl; ///< tile地址
@property (nonatomic, copy) NSString *layerName; ///< layerName
@property (nonatomic, copy) NSString *tileMatrixSet; ///< 切图矩阵集

@property (nonatomic, strong) AGSEnvelope *fullEnvelope; ///< <#desc#>
@property (nonatomic, strong) AGSTileInfo *tileInfo; ///< <#desc#>

+ (instancetype)infoWithLayerType:(TianMapType)layerType;
@end
