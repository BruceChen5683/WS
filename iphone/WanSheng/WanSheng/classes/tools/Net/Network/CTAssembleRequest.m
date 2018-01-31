//
//  CTAssembleRequest.m
//  CTWDriver
//
//  Created by mao on 2017/6/29.
//  Copyright © 2017年 changtu. All rights reserved.
//

#import "CTAssembleRequest.h"
#import "AFNetworking.h"
#import "CTAssembleRequest+PPAdd.h"
#import "NSMutableURLRequest+CTAdd.h"
@implementation CTAssembleRequest

static AFHTTPRequestSerializer *requestHttp = nil;

static AFJSONRequestSerializer *reqJson = nil;

+ (NSMutableURLRequest *)ctRequest:(CTURLModel *)urlM method:(NSString *)method{
    //使用url和加密参数创建Request对象
    AFHTTPRequestSerializer *requestSerializer = nil;
    
    if (urlM.requestType == CTRequestJsonSerializer) {
        requestSerializer = [self reqJsonSerializer];
    }
    else {
        requestSerializer = [self reqHttpSerializer];
    }

    NSDictionary *encrptyDic = urlM.params;
    
    NSMutableURLRequest *request = [requestSerializer requestWithMethod:method URLString:urlM.url parameters:encrptyDic error:NULL];
    request.encryptDic = encrptyDic;
    request.urlM = urlM;
    request.URL = [NSURL URLWithString:urlM.url];

    return request;
}

+ (AFHTTPRequestSerializer *)reqHttpSerializer {
    if (!requestHttp) {
        requestHttp = [AFHTTPRequestSerializer serializer];
        requestHttp.timeoutInterval = 30.f;
        [requestHttp setValue:@"application/x-www-form-urlencoded; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    }
    return requestHttp;
}

+ (AFJSONRequestSerializer *)reqJsonSerializer {
    if (!reqJson) {
        reqJson = [AFJSONRequestSerializer serializer];
        reqJson.timeoutInterval = 30.f;
        [reqJson setValue:@"application/x-www-form-urlencoded; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    }
    return reqJson;
}

@end
