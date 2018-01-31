//
//  PPNetErrorCodeHandle.h
//  CTWDriver
//
//  Created by mao on 2017/8/22.
//  Copyright © 2017年 changtu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PPNetErrorCodeHandle : NSObject

+ (void)handleError:(NSError *)error finBlock:(void(^)())finBlock;

+ (NSInteger)returnErrorCode:(NSError *)error;


@end
