//
//  CTAssembleRequest.h
//  CTWDriver
//
//  Created by mao on 2017/6/29.
//  Copyright © 2017年 changtu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CTURLModel.h"

@class AFHTTPRequestSerializer;
@class AFJSONRequestSerializer;

@interface CTAssembleRequest : NSObject

+ (NSMutableURLRequest *)ctRequest:(CTURLModel *)urlM method:(NSString *)method;

+ (AFHTTPRequestSerializer *)reqHttpSerializer;

+ (AFJSONRequestSerializer *)reqJsonSerializer;

@end
