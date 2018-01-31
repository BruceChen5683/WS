//
//  BuildingDetailModel.m
//  WanSheng
//
//  Created by mao on 2018/1/10.
//  Copyright © 2018年 mao. All rights reserved.
//

#import "BuildingDetailModel.h"

@implementation BuildingDetailModel

-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"id"]) {
        [self setValue:value forKey:@"cID"];
    }

}

- (NSString *)logoUrl {
    if (!_logoUrl) {
        return _logoUrl;
    }
    
    if (![_logoUrl hasPrefix:@"http"]) {
        _logoUrl = [BaseImgUrl stringByAppendingString:_logoUrl];
    }
    return _logoUrl;
}

@end
