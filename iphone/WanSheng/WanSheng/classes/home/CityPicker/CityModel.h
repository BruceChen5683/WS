//
//  CityModel.h
//  duobaoyu_iOS
//
//  Created by 朱帅 on 16/9/29.
//  Copyright © 2016年 zhushuai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CityModel : NSObject
@property(nonatomic,copy)NSString *city;
@property(nonatomic,copy)NSNumber *cId;
@property(nonatomic,copy)NSNumber *isNewRecord;
@property(nonatomic,copy)NSNumber *provinceid;

@property(nonatomic, strong) NSMutableArray *areaArray;

@end
