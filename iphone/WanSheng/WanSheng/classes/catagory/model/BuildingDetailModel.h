//
//  BuildingDetailModel.h
//  WanSheng
//
//  Created by mao on 2018/1/10.
//  Copyright © 2018年 mao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BuildingDetailModel : NSObject

@property(nonatomic, copy) NSString *adWord;

@property(nonatomic, copy) NSString *address;

@property(nonatomic, copy) NSString *attendDate;

@property(nonatomic, copy) NSNumber *categoryId;

@property(nonatomic, copy) NSString *cellphone;

@property(nonatomic, copy) NSNumber *cID;

@property(nonatomic, copy) NSNumber *isHot;

@property(nonatomic, copy) NSNumber *isNewRecord;

@property(nonatomic, copy) NSString *lat;

@property(nonatomic, copy) NSString *lng;

@property(nonatomic, copy) NSString *logoUrl;
@property(nonatomic, copy) NSString *mainProducts;
@property(nonatomic, copy) NSString *name;

@property(nonatomic, copy) NSString *phone;
@property(nonatomic, copy) NSString *referee;
@property(nonatomic, copy) NSString *refereeCellphone;
@property(nonatomic, copy) NSString *region;
@property(nonatomic, copy) NSNumber *sort;
@property(nonatomic, copy) NSString *type;
@property(nonatomic, copy) NSNumber *viewNum;

@property(nonatomic, strong) NSArray *images;

- (NSString *)firstLogoUrl;

@end
