//
//  CTWBaseRequest.h
//  CTWDriver
//
//  Created by mao on 2017/6/8.
//  Copyright © 2017年 changtu. All rights reserved.
//
/*
 支持https（校验证书，不可以抓包）:
 
 // 1.初始化单例类
 AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
 manager.securityPolicy.SSLPinningMode = AFSSLPinningModeCertificate;
 // 2.设置证书模式
 NSString * cerPath = [[NSBundle mainBundle] pathForResource:@"xxx" ofType:@"cer"];
 NSData * cerData = [NSData dataWithContentsOfFile:cerPath];
 manager.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate withPinnedCertificates:[[NSSet alloc] initWithObjects:cerData, nil]];
 // 客户端是否信任非法证书
 mgr.securityPolicy.allowInvalidCertificates = YES;
 // 是否在证书域字段中验证域名
 [mgr.securityPolicy setValidatesDomainName:NO];
 支持https（不校验证书，可以抓包查看）:
 
 // 1.初始化单例类
 AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
 // 2.设置非校验证书模式
 manager.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
 manager.securityPolicy.allowInvalidCertificates = YES;
 [manager.securityPolicy setValidatesDomainName:NO];
 */
#import "PPNetworkHelper.h"

@interface WSBaseRequest : PPNetworkHelper

@end
