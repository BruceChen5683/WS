//
//  OpenInfo.m
//  WanSheng
//
//  Created by mao on 2018/1/15.
//  Copyright © 2018年 mao. All rights reserved.
//

#import "OpenInfo.h"

@implementation OpenInfo

#define collectID @"mycollectData"

#define ScannedID @"myscanned"

+ (OpenInfo *)shared {

    static OpenInfo *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[OpenInfo alloc] init];
        instance.currentCity = [[CityModel alloc] init];
    });
    return instance;
}


- (NSArray *)collectArray {
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    return [userDefault valueForKey:collectID];
}

- (NSArray *)addToCollect:(NSDictionary *)dic {

    NSArray *data = [self collectArray];
    
    NSMutableArray *arr = [NSMutableArray array];
    if (data.count > 0) {
        [arr addObjectsFromArray:data];
    }
    [arr insertObject:dic atIndex:0];

    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];

    [userDefault setValue:arr forKey:collectID];
    
    [userDefault synchronize];
    
    return arr;
}

- (NSArray *)deleteDicInCollect:(NSDictionary *)dic {
    NSArray *data = [self collectArray];
    NSMutableArray *arr = [NSMutableArray array];
    for (NSDictionary *tmpDic in data) {
        if ([tmpDic[ITEMIDKEY] integerValue] != [dic[ITEMIDKEY] integerValue]) {
            [arr addObject:tmpDic];
        }
    }
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    
    [userDefault setValue:arr forKey:collectID];
    
    [userDefault synchronize];
    return arr;
}

#pragma mark - 浏览记录

- (NSArray *)scannedArray {
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    return [userDefault valueForKey:ScannedID];
}

- (NSArray *)addToScanned:(NSDictionary *)dic {
    
    NSArray *data = [self scannedArray];
    
    NSMutableArray *arr = [NSMutableArray array];
    if (data.count > 0) {
        [arr addObjectsFromArray:data];
    }
    
    __block BOOL find = NO;
    
    [arr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSDictionary *tmp = (NSDictionary *)obj;
        if ([tmp[ITEMIDKEY] integerValue] == [dic[ITEMIDKEY] integerValue]) {
            find = YES;
        }
    }];
    if (!find) {
        [arr insertObject:dic atIndex:0];
    }
    
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    
    [userDefault setValue:arr forKey:ScannedID];
    
    [userDefault synchronize];
    
    return arr;
}

- (NSArray *)deleteDicInScanned:(NSDictionary *)dic {
    NSArray *data = [self scannedArray];
    NSMutableArray *arr = [NSMutableArray array];
    for (NSDictionary *tmpDic in data) {
        if ([tmpDic[ITEMIDKEY] integerValue] != [dic[ITEMIDKEY] integerValue]) {
            [arr addObject:tmpDic];
        }
    }
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    
    [userDefault setValue:arr forKey:ScannedID];
    
    [userDefault synchronize];
    return arr;
}

+ (BOOL)ItsCity:(NSNumber *)areaID {
    
    BOOL reslut = NO;
    
    if (areaID.longLongValue == (areaID.longLongValue / 100 ) * 100) {
        reslut = YES;
    }
    
    return reslut;
}


+ (NSNumber *)choosedId {
    if ([OpenInfo shared].currentArea) {
        return [OpenInfo shared].currentArea.aID;
    }
    return [OpenInfo shared].currentCity.cId;
}

@end
