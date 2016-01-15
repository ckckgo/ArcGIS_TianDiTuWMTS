//
//  ViewController.m
//  TianDiTuWMTSDemo
//
//  Created by Henry on 16/1/13.
//  Copyright © 2016年 Henry. All rights reserved.
//

#import "ViewController.h"
#import <ArcGIS/ArcGIS.h>
#import "TianMapLayer.h"

@interface ViewController ()<AGSMapViewLayerDelegate>
@property (weak, nonatomic) AGSMapView *mapView; 
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    AGSMapView *mapView = [[AGSMapView alloc] initWithFrame:self.view.bounds];
    self.mapView = mapView;
    [self.view addSubview:mapView];
    
    NSError *error;
    TianMapLayer *vectorLayer = [[TianMapLayer alloc] initWithType:TianMapTypeVector2000 localServiceURL:nil error:&error];
    [self.mapView addMapLayer:vectorLayer withName:@"Vector2000"];
    
    TianMapLayer *annoLayer = [[TianMapLayer alloc] initWithType:TianMapTypeVectorAnnotationChinese2000 localServiceURL:nil error:&error];
    [self.mapView addMapLayer:annoLayer withName:@"VectorAnnotationChinese2000"];
    
    self.mapView.layerDelegate = self;
}

#pragma mark- mapViewLayerDelegate methods
- (void)mapViewDidLoad:(AGSMapView *)mapView {
    [mapView.locationDisplay startDataSource];
    mapView.locationDisplay.autoPanMode = AGSLocationDisplayAutoPanModeDefault;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

@end
