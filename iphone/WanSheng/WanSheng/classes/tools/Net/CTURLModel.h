//
//  CTURLModel.h
//  CTWDriver
//
//  Created by mao on 2017/6/26.
//  Copyright © 2017年 changtu. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    CTRequestJsonSerializer = 0,
    CTRequestHttpSerializer,
}CTRquestType;

typedef enum {
    CTResponseDataSerializer = 0,
    CTResponseJsonSerializer,
    CTResponseXMLSerializer,
}CTResponseSerializer;


@interface CTURLModel : NSObject<NSCopying>

//加密
@property(nonatomic, assign) bool isEncrpty;

@property(nonatomic, copy) NSString *url;

@property(nonatomic, strong) NSMutableDictionary *params;

@property(nonatomic, copy) NSString *random16Str;

@property(nonatomic, assign) CTResponseSerializer responseType;

@property(nonatomic, assign) CTRquestType requestType;

+ (CTURLModel *)initWithUrl:(NSString *)url params:(NSMutableDictionary *)params;

@end
