//
//  BaiDuMapViewController.h
//  Test-cy
//
//  Created by chenyun on 2018/1/8.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "BaseViewController.h"
#import <BaiduMapAPI_Map/BMKMapView.h>
#import <BaiduMapAPI_Location/BMKLocationService.h>
#import <BaiduMapAPI_Map/BMKPointAnnotation.h>
#import <BaiduMapAPI_Map/BMKPinAnnotationView.h>
#import <BaiduMapAPI_Search/BMKGeocodeSearch.h>

@interface BaiDuMapViewController : BaseViewController

@property (nonatomic, copy) void(^getAddrssBlock)(NSString *address,CLLocationCoordinate2D location);

@end
