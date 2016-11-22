//
//  TianMapLayer.m
//  TianMapLayer
//
//  Created by Henry on 11/22/16.
//  Copyright © 2016 Henry. All rights reserved.
//

#import "TianMapLayer.h"
#import "TianMapSchema.h"

#define kPath_Request_Tiled @"%@?service=wmts&request=gettile&version=1.0.0&layer=%@&STYLE=default&tilematrixset=%@&tilematrix=%tu&tilerow=%tu&tilecol=%tu&format=tiles"

@interface TianMapLayer()

@property (nonatomic, strong) TianMapSchema *schema;

/**
 Override super class
 */
@property (nonatomic, strong) AGSEnvelope *fullEnvelope;
@property (nonatomic, strong) AGSTileInfo *tileInfo;

@end

@implementation TianMapLayer

@synthesize fullEnvelope, tileInfo;

- (instancetype)initWithType:(TianMapType)layerType localServiceURL:(NSString *)url {
    self = [super init];
    if (!self) {
        return nil;
    }
    
    TianMapSchema *schema = [TianMapSchema schemaWithMapType:layerType];
    self.schema = schema;

    if (url) {
        self.schema.baseUrl = url;
    }
    
    self.fullEnvelope = schema.fullEnvelope;
    self.tileInfo = schema.tileInfo;
//    [self.tileInfo computeTileBounds:self.fullEnvelope];
    [super layerDidLoad];
    
    return self;
}

#pragma mark- Override

-(NSURL*)urlForTileKey:(AGSTileKey*)key {
    NSString *strUrl = [NSString stringWithFormat:kPath_Request_Tiled, self.schema.baseUrl, self.schema.layerName, self.schema.tileMatrixSet, key.level, key.row, key.column];
    return [NSURL URLWithString:strUrl];
}


@end
