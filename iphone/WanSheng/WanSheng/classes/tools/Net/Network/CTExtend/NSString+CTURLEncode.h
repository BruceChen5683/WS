//
//  NSString+CTURLEncode.h
//  Test
//
//  Created by bhlin on 2017/2/22.
//  Copyright © 2017年 bhlin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (CTURLEncode)

- (NSString *)URLEncodedString;
+ (NSString *)URLDecodedString:(NSString *)str;

@end
