//
//  CTURLModel.m
//  CTWDriver
//
//  Created by mao on 2017/6/26.
//  Copyright © 2017年 changtu. All rights reserved.
//

#import "CTURLModel.h"

@implementation CTURLModel

+ (CTURLModel *)initWithUrl:(NSString *)url params:(NSMutableDictionary *)params {
    CTURLModel *m = [[CTURLModel alloc] init];
    m.url = url;
    m.params = params;
    m.requestType = CTRequestHttpSerializer;
    m.responseType = CTResponseJsonSerializer;
    return m;
}

- (id)init {
    self = [super init];
    
    if (self) {
        //默认bu加密
        self.isEncrpty = false;
        self.random16Str = nil;
    }
    
    return self;
}

- (NSMutableDictionary *)params {
    if (!_params) {
        _params = [NSMutableDictionary dictionary];
    }
    return _params;
}

- (id)copyWithZone:(nullable NSZone *)zone {
    CTURLModel *u = [[CTURLModel alloc] init];
    u.isEncrpty = self.isEncrpty;
    u.random16Str = self.random16Str;
    u.params = self.params;
    u.url = self.url;
    u.responseType = self.responseType;
    u.requestType = self.requestType;
    return u;
}

- (NSString *)description {
    NSDictionary * dic = @{@"url":self.url,@"params":self.params};
    return dic.description;
}

@end
