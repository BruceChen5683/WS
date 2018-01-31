//
//  CatagoryModel.m
//  WanSheng
//
//  Created by mao on 2018/1/10.
//  Copyright © 2018年 mao. All rights reserved.
//

#import "CatagoryModel.h"

@implementation CatagoryModel

- (instancetype)initWithDic:(NSDictionary *)dic {
    CatagoryModel *m = [[CatagoryModel alloc] init];
    m.cID = dic[@"id"];
    m.isNewRecord = dic[@"isNewRecord"];
    m.cName = dic[@"name"];
    m.sort = dic[@"sort"];
    return m;
}

@end
