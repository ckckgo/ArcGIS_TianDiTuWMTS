//
//  TianMapLayer.h
//  Install and setup
//
//  Created by roger on 16/1/12.
//  Copyright © 2016年 roger. All rights reserved.
//

#import <ArcGIS/ArcGIS.h>
@class TianMapInfo;

typedef NS_ENUM(NSInteger, TianMapType) {
    TianMapTypeVectorMercator = 0, ///<天地图矢量墨卡托投影地图服务
    TianMapTypeVectorAnnotationChineseMercator, ///<天地图矢量墨卡托中文标注
    TianMapTypeVectorAnnotationEnglishMercator, ///<天地图矢量墨卡托英文标注
    TianMapTypeImageMercator, ///<天地图影像墨卡托投影地图服务
    TianMapTypeImageAnnotationChineseMercator, ///<天地图影像墨卡托投影中文标注
    TianMapTypeImageAnnotationEnglishMercator, ///<天地图影像墨卡托投影英文标注
    TianMapTypeTerrainMercator, ///<天地图地形墨卡托投影地图服务
    TianMapTypeTerrainAnnotationChineseMercator, ///<天地图地形墨卡托投影中文标注
    
    TianMapTypeVector2000 = 8, ///<天地图矢量国家2000坐标系地图服务
    TianMapTypeVectorAnnotationChinese2000, ///<天地图矢量国家2000坐标系中文标注
    TianMapTypeVectorAnnotationEnglish2000, ///<天地图矢量国家2000坐标系英文标注
    TianMapTypeImage2000, ///<天地图影像国家2000坐标系地图服务
    TianMapTypeImageAnnotationChinese2000, ///<天地图影像国家2000坐标系中文标注
    TianMapTypeImageAnnotationEnglish2000, ///<天地图影像国家2000坐标系中文标注
    TianMapTypeTerrain2000, ///<天地图地形国家2000坐标系地图服务
    TianMapTypeTerrainAnnotationChinese2000, ///<天地图地形国家2000坐标系中文标注
};

@interface TianMapLayer : AGSTiledServiceLayer
{
    AGSTileInfo *_tileInfo;
    AGSEnvelope *_fullEnvelope;
    AGSSpatialReference *_spatialReference;
}
@property (nonatomic, strong) TianMapInfo *layerInfo; ///< customerTileLayerInfo
@property (nonatomic, strong) NSOperationQueue *requestQueue; ///< 队列

- (instancetype)initWithType:(TianMapType)layerType localServiceURL:(NSString *)url error:(NSError **)error;
@end
