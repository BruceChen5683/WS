//
//  PPNetErrorCodeHandle.m
//  CTWDriver
//
//  Created by mao on 2017/8/22.
//  Copyright © 2017年 changtu. All rights reserved.
//

#import "PPNetErrorCodeHandle.h"

@implementation PPNetErrorCodeHandle


+ (void)handleError:(NSError *)error finBlock:(void(^)())finBlock {
    NSDictionary *dict = error.userInfo;
    NSArray *array = [dict allValues];
    NSHTTPURLResponse *response = nil;
    for (id obj in array) {
        if ([obj isKindOfClass:[NSHTTPURLResponse class]]) {
            response = obj;
            break;
        }
    }
    finBlock();
}

+ (NSInteger)returnErrorCode:(NSError *)error {
    NSDictionary *dict = error.userInfo;
    NSArray *array = [dict allValues];
    NSHTTPURLResponse *response = nil;
    for (id obj in array) {
        if ([obj isKindOfClass:[NSHTTPURLResponse class]]) {
            response = obj;
            break;
        }
    }
    return response.statusCode;
}

@end
