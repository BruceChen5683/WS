//
//  CatagoryModel.h
//  WanSheng
//
//  Created by mao on 2018/1/10.
//  Copyright © 2018年 mao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CatagoryModel : NSObject

@property(nonatomic, copy) NSNumber *cID;

@property(nonatomic, copy) NSString *cName;

@property(nonatomic, copy) NSNumber *isNewRecord;

@property(nonatomic, copy) NSNumber *sort;

- (instancetype)initWithDic:(NSDictionary *)dic;

@end
