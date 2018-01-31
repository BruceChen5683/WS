//
//  CTAssembleResponse.h
//  CTWDriver
//
//  Created by mao on 2017/6/29.
//  Copyright © 2017年 changtu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CTURLModel.h"

@class AFHTTPResponseSerializer;
@class AFJSONResponseSerializer;
@class AFImageResponseSerializer;

@interface CTAssembleResponse : NSObject

+ (AFHTTPResponseSerializer *)responseHttpSerializer;

+ (AFJSONResponseSerializer *)responseJsonSerializer;

+ (AFImageResponseSerializer *)responseImageSerializer;

@end
