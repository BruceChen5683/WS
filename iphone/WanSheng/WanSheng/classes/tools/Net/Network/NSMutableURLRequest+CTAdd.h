//
//  NSMutableURLRequest+CTAdd.h
//  CTWDriver
//
//  Created by mao on 2017/6/29.
//  Copyright © 2017年 changtu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CTURLModel.h"

@interface NSMutableURLRequest (CTAdd)

@property(nonatomic, strong) CTURLModel *urlM;

@property(nonatomic, strong) NSDictionary *encryptDic;

@end
