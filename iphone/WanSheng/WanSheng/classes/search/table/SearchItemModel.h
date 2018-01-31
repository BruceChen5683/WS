//
//  SearchItemModel.h
//  WanSheng
//
//  Created by mao on 2018/1/9.
//  Copyright © 2018年 mao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SearchItemModel : NSObject


@property(copy, nonatomic) NSString *address;

@property(copy, nonatomic) NSString *phone;

@property(copy, nonatomic) NSString *imgUrl;

@property(copy, nonatomic) NSString *flag;

//////////////

@property(nonatomic, copy) NSNumber *categoryId;

@property(nonatomic, copy) NSString *cellphone;

@property(nonatomic, copy) NSNumber *sID;

@property(nonatomic, copy) NSNumber *isHot;

@property(nonatomic, copy) NSNumber *isNewRecord;

@property(copy, nonatomic) NSString *name;

@property(nonatomic, copy) NSString *region;

@property(copy, nonatomic) NSString *sort;

@end
