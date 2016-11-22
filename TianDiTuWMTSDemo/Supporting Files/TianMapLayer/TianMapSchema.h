//
//  TianMapSchema.h
//  TianMapLayer
//
//  Created by Henry on 11/22/16.
//  Copyright © 2016 Henry. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TianMapLayer.h"

@interface TianMapSchema : NSObject

@property (nonatomic, strong, readonly) AGSSpatialReference *spatialReference;
@property (nonatomic, strong, readonly) AGSEnvelope *fullEnvelope;
@property (nonatomic, strong, readonly) AGSTileInfo *tileInfo;
@property (nonatomic, copy, readonly) NSString *layerName;
@property (nonatomic, copy, readonly) NSString *tileMatrixSet;
@property (nonatomic, copy) NSString *baseUrl;

+ (instancetype)schemaWithMapType:(TianMapType)mapType;

@end
