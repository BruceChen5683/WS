//
//  PBLocation.m
//  test
//
//  Created by Playboy on 2016/12/30.
//  Copyright © 2016年 ywkj. All rights reserved.
//

#import "PBLocation.h"
#import <UIKit/UIKit.h>

@implementation PBLocationModel

@end


@interface PBLocation ()<CLLocationManagerDelegate>
@property (nonatomic,strong) CLLocationManager *manager;
@property (nonatomic,strong) CLGeocoder        *geocoder;
@property (nonatomic,copy) complateBlock       addressBlock;
@end

@implementation PBLocation

+ (instancetype)location {
    static PBLocation *location = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        location = [[PBLocation alloc] init];
    });
    return location;
}

- (void)startLocationAddress:(complateBlock)block {
    
    self.addressBlock = block;
    
    //判断用户定位服务是否开启
    if ([CLLocationManager locationServicesEnabled] && [CLLocationManager authorizationStatus] != kCLAuthorizationStatusDenied) {
        if([self.manager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
            [self.manager requestWhenInUseAuthorization];
        }
        [self.manager startUpdatingLocation];
        return;
    }
    if (self.addressBlock) {
        self.addressBlock(NO,nil);
    }
}

#pragma mark - <CLLocationManagerDelegate>

- (void)locationManager:(CLLocationManager *)manager
    didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation {
    __weak typeof (self) weakSelf = self;
    PBLocationModel *model = [[PBLocationModel alloc] init];
    model.currentLocation = newLocation;
 
    CLGeocoder *geocoder=[[CLGeocoder alloc]init];
    [geocoder reverseGeocodeLocation:newLocation completionHandler:^(NSArray *placemark,NSError *error) {
        CLPlacemark *placemarkOne=[placemark firstObject];
        model.locatedAddress = placemarkOne.addressDictionary;
        model.name = placemarkOne.name;
        model.country = placemarkOne.country;
        model.postalCode = placemarkOne.postalCode;
        model.ISOcountryCode = placemarkOne.ISOcountryCode;
        model.administrativeArea = placemarkOne.administrativeArea;
        model.subAdministrativeArea = placemarkOne.subAdministrativeArea;
        model.locality = placemarkOne.locality;
        model.subLocality = placemarkOne.subLocality;
        model.thoroughfare = placemarkOne.thoroughfare;
        model.subThoroughfare = placemarkOne.subThoroughfare;
        
        if (weakSelf.addressBlock) {
            weakSelf.addressBlock (YES,model);
        }
    }];
    // 停止定位
   [self stopLocation];
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    [self stopLocation];
    if (self.addressBlock) {
        self.addressBlock (NO,nil);
    }
}


#pragma mark - lazy loading
- (CLLocationManager *)manager {
    if (!_manager) {
        _manager = [[CLLocationManager alloc] init];
        [_manager requestWhenInUseAuthorization];
        [_manager setDelegate:self];
        [_manager setDesiredAccuracy:kCLLocationAccuracyBest];
        _manager.distanceFilter = 100; //控制定位服务更新频率。单位是“米”
       // [_manager setDistanceFilter:kCLDistanceFilterNone];
    }
    return _manager;
}

- (CLGeocoder *)geocoder {
    if (!_geocoder) {
        _geocoder = [[CLGeocoder alloc] init];
    }
    return _geocoder;
}
/**
 * 停止定位
 */
-(void)stopLocation {
    [self.manager stopUpdatingLocation];
    self.manager = nil; //这句话必须加上，否则可能会出现调用多次的情况
}
@end
