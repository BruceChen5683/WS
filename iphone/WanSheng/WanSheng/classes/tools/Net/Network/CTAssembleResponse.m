//
//  CTAssembleResponse.m
//  CTWDriver
//
//  Created by mao on 2017/6/29.
//  Copyright © 2017年 changtu. All rights reserved.
//

#import "CTAssembleResponse.h"
#import "AFNetworking.h"

@implementation CTAssembleResponse

static AFHTTPResponseSerializer *respHttpSerializer = nil;
static AFJSONResponseSerializer *respJsonSerializer = nil;
static AFImageResponseSerializer *respImageSerializer = nil;


+ (AFHTTPResponseSerializer *)responseHttpSerializer {

    if (!respHttpSerializer) {
        respHttpSerializer = [AFHTTPResponseSerializer serializer];
        respHttpSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html", @"text/json", @"text/plain", @"text/javascript", @"text/xml", @"image/jpeg",@"image/*", nil];
    }
    return respHttpSerializer;
}

+ (AFJSONResponseSerializer *)responseJsonSerializer {

    if (!respJsonSerializer) {
        respJsonSerializer = [AFJSONResponseSerializer serializer];
        respJsonSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html", @"text/json", @"text/plain", @"text/javascript", @"text/xml", @"image/jpeg",@"image/*", nil];
    }
    return respJsonSerializer;
}

+ (AFImageResponseSerializer *)responseImageSerializer {

    if (!respImageSerializer) {
        respImageSerializer = [AFImageResponseSerializer serializer];
        respImageSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html", @"text/json", @"text/plain", @"text/javascript", @"text/xml", @"image/*", nil];
    }
    return respImageSerializer;
}


@end
