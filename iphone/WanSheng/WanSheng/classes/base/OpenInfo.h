//
//  OpenInfo.h
//  WanSheng
//
//  Created by mao on 2018/1/15.
//  Copyright © 2018年 mao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CityModel.h"
#import "AreaModel.h"
#import <CoreLocation/CoreLocation.h>

#define ITEMIDKEY @"itemIDKey"
#define ITEMNameKEY @"itemNameKey"

@interface OpenInfo : NSObject

+ (OpenInfo *)shared;

@property(nonatomic, strong) CityModel *currentCity;

@property(nonatomic, strong) AreaModel *currentArea;

@property(nonatomic, copy) NSString *cityCode;

@property(assign, nonatomic) CLLocationCoordinate2D bdLocation2D;

///用户存储的
- (NSArray *)collectArray;

- (NSArray *)addToCollect:(NSDictionary *)dic;

- (NSArray *)deleteDicInCollect:(NSDictionary *)dic;

- (NSArray *)scannedArray;

- (NSArray *)addToScanned:(NSDictionary *)dic;

- (NSArray *)deleteDicInScanned:(NSDictionary *)dic;

+ (BOOL)ItsCity:(NSNumber *)areaID;

+ (NSNumber *)choosedId;

@end
