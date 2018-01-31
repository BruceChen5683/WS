//
//  NSMutableURLRequest+CTAdd.m
//  CTWDriver
//
//  Created by mao on 2017/6/29.
//  Copyright © 2017年 changtu. All rights reserved.
//

#import "NSMutableURLRequest+CTAdd.h"
#import <objc/runtime.h>

#define CT_Url_KEY_1 @"ct_url_key_1"
#define CT_encrptydic_KEY_1 @"ct_encrptydic_key_1"

@implementation NSMutableURLRequest (CTAdd)

@dynamic urlM;

@dynamic encryptDic;

- (void)setUrlM:(CTURLModel *)urlM {
    objc_setAssociatedObject(self, (const void *)CFBridgingRetain(CT_Url_KEY_1), urlM, OBJC_ASSOCIATION_COPY);
}

- (CTURLModel *)urlM {
    return objc_getAssociatedObject(self, (const void *)CFBridgingRetain(CT_Url_KEY_1));
}

- (void)setEncryptDic:(NSDictionary *)encryptDic {
    objc_setAssociatedObject(self, (const void *)CFBridgingRetain(CT_encrptydic_KEY_1), encryptDic, OBJC_ASSOCIATION_COPY);

}

- (NSDictionary *)encryptDic {
    return objc_getAssociatedObject(self, (const void *)CFBridgingRetain(CT_encrptydic_KEY_1));

}

@end
