//
//  TianMapInfo.m
//  Install and setup
//
//  Created by roger on 16/1/12.
//  Copyright © 2016年 roger. All rights reserved.
//

#import "TianMapInfo.h"
//mecator
#define kURL_VECTOR_MERCATOR @"http://t0.tianditu.com/vec_w/wmts"
#define kURL_VECTOR_ANNOTATION_CHINESE_MERCATOR @"http://t0.tianditu.com/cva_w/wmts"
#define kURL_VECTOR_ANNOTATION_ENGLISH_MERCATOR @"http://t0.tianditu.com/eva_w/wmts"
#define kURL_IMAGE_MERCATOR @"http://t0.tianditu.com/img_w/wmts"
#define kURL_IMAGE_ANNOTATION_CHINESE_MERCATOR @"http://t0.tianditu.com/cia_w/wmts"
#define kURL_IMAGE_ANNOTATION_ENGLISH_MERCATOR @"http://t0.tianditu.com/cia_w/wmts"
#define kURL_TERRAIN_MERCATOR @"http://t0.tianditu.com/ter_w/wmts"
#define kURL_TERRAIN_ANNOTATION_CHINESE_MERCATOR @"http://t0.tianditu.com/cta_w/wmts"

//cgcs2000
#define kURL_VECTOR_2000 @"http://t0.tianditu.com/vec_c/wmts"
#define kURL_VECTOR_ANNOTATION_CHINESE_2000 @"http://t0.tianditu.com/cva_c/wmts"
#define kURL_VECTOR_ANNOTATION_ENGLISH_2000 @"http://t0.tianditu.com/eva_c/wmts"
#define kURL_IMAGE_2000 @"http://t0.tianditu.com/img_c/wmts"
#define kURL_IMAGE_ANNOTATION_CHINESE_2000 @"http://t0.tianditu.com/cia_c/wmts"
#define kURL_IMAGE_ANNOTATION_ENGLISH_2000 @"http://t0.tianditu.com/cia_c/wmts"
#define kURL_TERRAIN_2000 @"http://t0.tianditu.com/ter_c/wmts"
#define kURL_TERRAIN_ANNOTATION_CHINESE_2000 @"http://t0.tianditu.com/cta_c/wmts"

//services
#define kLAYER_NAME_VECTOR @"vec"
#define kLAYER_NAME_VECTOR_ANNOTATION_CHINESE @"cva"
#define kLAYER_NAME_VECTOR_ANNOTATION_ENGLISH @"eva"
#define kLAYER_NAME_IMAGE @"img"
#define kLAYER_NAME_IMAGE_ANNOTATION_CHINESE @"cia"
#define kLAYER_NAME_IMAGE_ANNOTATION_ENGLISH @"eia"
#define kLAYER_NAME_TERRAIN @"ter"
#define kLAYER_NAME_TERRAIN_ANNOTATION_CHINESE @"cta"

//Matrixset
#define kTILE_MATRIX_SET_MERCATOR @"w"
#define kTILE_MATRIX_SET_2000 @"c"

//SRID
#define kSRID_2000 4490
#define kSRID_MERCATOR 102100

#define X_MIN_2000 -180.0
#define Y_MIN_2000 -90.0
#define X_MAX_2000 180.0
#define Y_MAX_2000 90.0

#define X_MIN_MERCATOR -20037508.3427892
#define Y_MIN_MERCATOR -20037508.3427892
#define X_MAX_MERCATOR 20037508.3427892
#define Y_MAX_MERCATOR 20037508.3427892

#define kMIN_ZOOM_LEVEL 0
#define kMAX_ZOOM_LEVEL 16
#define kTILE_WIDTH 256
#define kTILE_HEIGHT 256
#define kDPI 96

@interface TianMapInfo ()

@end

@implementation TianMapInfo
+ (instancetype)infoWithLayerType:(TianMapType)layerType {
    TianMapInfo *layerInfo = [[self alloc] init];
    
    double xMin, yMin, xMax, yMax;
    AGSSpatialReference *sr;
    AGSPoint *origin;
    NSMutableArray *lods;
    
    if (layerType < 8) { //墨卡托
        layerInfo.tileMatrixSet = kTILE_MATRIX_SET_MERCATOR;
        
        xMin = X_MIN_MERCATOR;
        yMin = Y_MIN_MERCATOR;
        xMax = X_MAX_MERCATOR;
        yMax = Y_MAX_MERCATOR;
        sr = [[AGSSpatialReference alloc] initWithWKID:kSRID_MERCATOR];
        origin = [AGSPoint pointWithX:X_MIN_MERCATOR y:Y_MAX_MERCATOR spatialReference:sr];
        lods = [NSMutableArray arrayWithObjects:
                [[AGSLOD alloc] initWithLevel:0 resolution:156543.34701761068 scale:591658710.9091312],
                [[AGSLOD alloc] initWithLevel:1 resolution:78271.673508805340 scale:295829355.4545656],
                [[AGSLOD alloc] initWithLevel:2 resolution:39135.836754402670 scale:147914677.7272828],
                [[AGSLOD alloc] initWithLevel:3 resolution:19567.918377201335 scale:73957338.8636414],
                [[AGSLOD alloc] initWithLevel:4 resolution:9783.9591886006670 scale:36978669.4318207],
                [[AGSLOD alloc] initWithLevel:5 resolution:4891.9795943003340 scale:18489334.71591035],
                [[AGSLOD alloc] initWithLevel:6 resolution:2445.9897971501670 scale:9244667.357955175],
                [[AGSLOD alloc] initWithLevel:7 resolution:1222.9948985750834 scale:4622333.678977588],
                [[AGSLOD alloc] initWithLevel:8 resolution:611.49744928754170 scale:2311166.839488794],
                [[AGSLOD alloc] initWithLevel:9 resolution:305.74872464376960 scale:1155583.419744397],
                [[AGSLOD alloc] initWithLevel:10 resolution:152.87436232188531 scale:577791.7098721985],
                [[AGSLOD alloc] initWithLevel:11 resolution:76.437181160942660 scale:288895.85493609926],
                [[AGSLOD alloc] initWithLevel:12 resolution:38.218590580471330 scale:144447.92746804963],
                [[AGSLOD alloc] initWithLevel:13 resolution:19.109295290235693 scale:72223.96373402482],
                [[AGSLOD alloc] initWithLevel:14 resolution:9.5546476451178460 scale:36111.98186701241],
                [[AGSLOD alloc] initWithLevel:15 resolution:4.7773238225589230 scale:18055.990933506204],
                [[AGSLOD alloc] initWithLevel:16 resolution:2.3886619112794585 scale:9027.995466753102],
                nil];
    } else { // 国标2000
        layerInfo.tileMatrixSet = kTILE_MATRIX_SET_2000;
        
        xMin = X_MIN_2000;
        yMin = Y_MIN_2000;
        xMax = X_MAX_2000;
        yMax = Y_MAX_2000;
        sr = [[AGSSpatialReference alloc] initWithWKID:kSRID_2000];
        origin = [AGSPoint pointWithX:X_MIN_2000 y:Y_MAX_2000 spatialReference:sr];
        lods = [NSMutableArray arrayWithObjects:
                [[AGSLOD alloc] initWithLevel:0 resolution:1.40625 scale:591658710.9],
                [[AGSLOD alloc] initWithLevel:1 resolution:0.703125 scale:295829355.45],
                [[AGSLOD alloc] initWithLevel:2 resolution:0.3515625 scale:147914677.725],
                [[AGSLOD alloc] initWithLevel:3 resolution:0.17578125 scale:73957338.8625],
                [[AGSLOD alloc] initWithLevel:4 resolution:0.087890625 scale:36978669.43125],
                [[AGSLOD alloc] initWithLevel:5 resolution:0.0439453125 scale:18489334.715625],
                [[AGSLOD alloc] initWithLevel:6 resolution:0.02197265625 scale:9244667.3578125],
                [[AGSLOD alloc] initWithLevel:7 resolution:0.010986328125 scale:4622333.67890625],
                [[AGSLOD alloc] initWithLevel:8 resolution:0.0054931640625 scale:2311166.839453125],
                [[AGSLOD alloc] initWithLevel:9 resolution:0.00274658203125 scale:1155583.4197265625],
                [[AGSLOD alloc] initWithLevel:10 resolution:0.00137329101563 scale:577791.70986328125],
                [[AGSLOD alloc] initWithLevel:11 resolution:0.00068664550782 scale:288895.854931640625],
                [[AGSLOD alloc] initWithLevel:12 resolution:0.00034332275391 scale:144447.9274658203125],
                [[AGSLOD alloc] initWithLevel:13 resolution:0.00017166137696 scale:72223.96373291015625],
                [[AGSLOD alloc] initWithLevel:14 resolution:0.00008583068848 scale:36111.98186645507813],
                [[AGSLOD alloc] initWithLevel:15 resolution:0.00004291534424 scale:18055.99093322753907],
                [[AGSLOD alloc] initWithLevel:16 resolution:0.00002145767212 scale:9027.99546661376954],
                nil];
    }
    
    // other params
    switch (layerType) {
        case 0:
            layerInfo.baseUrl= kURL_VECTOR_MERCATOR;
            layerInfo.layerName = kLAYER_NAME_VECTOR;
            break;
        case 1:
            layerInfo.baseUrl= kURL_VECTOR_ANNOTATION_CHINESE_MERCATOR;
            layerInfo.layerName = kLAYER_NAME_VECTOR_ANNOTATION_CHINESE;
            break;
        case 2:
            layerInfo.baseUrl= kURL_VECTOR_ANNOTATION_ENGLISH_MERCATOR;
            layerInfo.layerName = kLAYER_NAME_VECTOR_ANNOTATION_ENGLISH;
            break;
        case 3:
            layerInfo.baseUrl= kURL_IMAGE_MERCATOR;
            layerInfo.layerName = kLAYER_NAME_IMAGE;
            break;
        case 4:
            layerInfo.baseUrl= kURL_IMAGE_ANNOTATION_CHINESE_MERCATOR;
            layerInfo.layerName = kLAYER_NAME_IMAGE_ANNOTATION_CHINESE;
            break;
        case 5:
            layerInfo.baseUrl= kURL_IMAGE_ANNOTATION_ENGLISH_MERCATOR;
            layerInfo.layerName = kLAYER_NAME_IMAGE_ANNOTATION_ENGLISH;
            break;
        case 6:
            layerInfo.baseUrl= kURL_TERRAIN_MERCATOR;
            layerInfo.layerName = kLAYER_NAME_TERRAIN;
            break;
        case 7:
            layerInfo.baseUrl= kURL_TERRAIN_ANNOTATION_CHINESE_MERCATOR;
            layerInfo.layerName = kLAYER_NAME_TERRAIN_ANNOTATION_CHINESE;
            break;
        case 8:
            layerInfo.baseUrl= kURL_VECTOR_2000;
            layerInfo.layerName = kLAYER_NAME_VECTOR;
            break;
        case 9:
            layerInfo.baseUrl= kURL_VECTOR_ANNOTATION_CHINESE_2000;
            layerInfo.layerName = kLAYER_NAME_VECTOR_ANNOTATION_CHINESE;
            break;
        case 10:
            layerInfo.baseUrl= kURL_VECTOR_ANNOTATION_ENGLISH_2000;
            layerInfo.layerName = kLAYER_NAME_VECTOR_ANNOTATION_ENGLISH;
            break;
        case 11:
            layerInfo.baseUrl= kURL_IMAGE_2000;
            layerInfo.layerName = kLAYER_NAME_IMAGE;
            break;
        case 12:
            layerInfo.baseUrl= kURL_IMAGE_ANNOTATION_CHINESE_2000;
            layerInfo.layerName = kLAYER_NAME_IMAGE_ANNOTATION_CHINESE;
            break;
        case 13:
            layerInfo.baseUrl= kURL_IMAGE_ANNOTATION_ENGLISH_2000;
            layerInfo.layerName = kLAYER_NAME_IMAGE_ANNOTATION_ENGLISH;
            break;
        case 14:
            layerInfo.baseUrl= kURL_TERRAIN_2000;
            layerInfo.layerName = kLAYER_NAME_TERRAIN;
            break;
        case 15:
            layerInfo.baseUrl= kURL_TERRAIN_ANNOTATION_CHINESE_2000;
            layerInfo.layerName = kLAYER_NAME_TERRAIN_ANNOTATION_CHINESE;
            break;
        default:
            break;
    }
    
    layerInfo.fullEnvelope = [[AGSEnvelope alloc] initWithXmin:xMin
                                                          ymin:yMin
                                                          xmax:xMax
                                                          ymax:yMax
                                              spatialReference:sr];

    layerInfo.tileInfo = [[AGSTileInfo alloc] initWithDpi:kDPI
                                                   format:@"PNG"
                                                     lods:[lods copy]
                                                   origin:origin
                                         spatialReference:sr
                                                 tileSize:CGSizeMake(kTILE_WIDTH, kTILE_HEIGHT)];
    
    return layerInfo;
}
@end
