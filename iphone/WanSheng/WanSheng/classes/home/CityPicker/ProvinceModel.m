//
//  ProvinceModel.m
//  duobaoyu_iOS
//
//  Created by 朱帅 on 16/9/29.
//  Copyright © 2016年 zhushuai. All rights reserved.
//

#import "ProvinceModel.h"

@implementation ProvinceModel
-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{

}

- (NSMutableArray *)citiesArr {
    if (!_citiesArr) {
        _citiesArr = [NSMutableArray array];
    }
    return _citiesArr;
}

@end
