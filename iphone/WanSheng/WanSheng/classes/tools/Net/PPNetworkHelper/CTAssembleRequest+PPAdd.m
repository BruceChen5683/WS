//
//  PPNetworkHelper+PPAdd.m
//  CTWDriver
//
//  Created by mao on 2017/6/23.
//  Copyright © 2017年 changtu. All rights reserved.
//

#import "CTAssembleRequest+PPAdd.h"
#import "NSString+CTURLEncode.h"
#import "NSObject+SBJson.h"
#import "SHXMLParser.h"

@implementation CTAssembleRequest (PPAdd)


#pragma mark - call back block


+ (id)praseResponse:(CTURLModel *)urlM data:(NSData *)data {
    
    id result = nil;
    BOOL success = true;
    if (urlM.responseType == CTResponseDataSerializer) {
        //image
        result = [UIImage imageWithData:data];
        success = (result != nil);
    }
    else if (urlM.responseType == CTResponseJsonSerializer) {
        //json
        result = [self parseReceivedJson:data encrpty:urlM.isEncrpty];
    }
    else if (urlM.responseType == CTResponseXMLSerializer) {
        //xml
        result = [self parseReceivedXml:data encrpty:urlM.isEncrpty];
    }
    success = (result != nil);

    return result;
}


+ (NSString *)bodyStr:(id)params key:(id)key{
    
    if ([key respondsToSelector:@selector(length)]) {
        if ([key length] > 0) {
            return params[key];
        }
    }
    
    return @"";
}


+ (NSDictionary *)parseReceivedJson:(NSData *)data encrpty:(BOOL)encrpty
{
    NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding (kCFStringEncodingUTF8);//kCFStringEncodingUTF8
    NSString * myResponseStr = [[NSString alloc] initWithData:data encoding:enc];
    if (encrpty) {
        //myResponseStr = [myResponseStr stringByReplacingOccurrencesOfString:@"+" withString:@" "];
        myResponseStr = [myResponseStr stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    }
    //     DLog(@"myResponseStr :%@",myResponseStr);
    //        //防止网页错误返回
    //        if ([[myResponseStr substringToIndex:1] isEqualToString:@"<"]) {
    //            return NO;
    //        }
    NSString *un  = [NSString stringWithFormat:@"%c",0x09]; //TAB键
    myResponseStr = [myResponseStr stringByReplacingOccurrencesOfString:un withString:@""];
    
    NSDictionary *dir = [myResponseStr JSONValue];
    NSDictionary *result = [[NSDictionary alloc] initWithDictionary:dir];
    
    if (dir && result) {
        //解析正确
        return result;
    } else {
        //解析错误
        return nil;
    }
}

+ (NSDictionary *)parseReceivedXml:(NSData *)data encrpty:(BOOL)encrpty
{
    SHXMLParser * parse = [[SHXMLParser alloc] init];
    NSDictionary * dir = [parse parseData:data];
    NSDictionary *result = [[NSDictionary alloc] initWithDictionary:dir];
    if (result) {
        return result;
    } else {
        return nil;
    }
}


@end
