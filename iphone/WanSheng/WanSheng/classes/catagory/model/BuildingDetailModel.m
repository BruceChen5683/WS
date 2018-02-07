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

- (NSString *)firstLogoUrl {
    NSString *result = nil;
    
    if (self.images.count > 0) {
        NSString *tmpUrl = self.images[0];
        if (![tmpUrl hasPrefix:@"http"]) {
            tmpUrl = [BaseImgUrl stringByAppendingString:tmpUrl];
        }
        result = tmpUrl;
    }
    else {
        result = self.logoUrl;
        if (result.length == 0) {
            return result;
        }
        if (![result hasPrefix:@"http"]) {
            result = [BaseImgUrl stringByAppendingString:self.logoUrl];
        }
    }
    return result;
}

@end
