//
//  AFHttpUtil.h
//  ECarWash
//
//  Created by 李文龙 on 14/11/11.
//  Copyright (c) 2014年 李文龙. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CTURLModel.h"

typedef void (^AFHttpCallback)(BOOL isSuccessed, id result);

@interface AFHttpUtil : NSObject

+ (void)doGetWithUrl:(CTURLModel *)model callback:(AFHttpCallback) callback;

+ (void)doPostWithUrl:(CTURLModel *)model callback:(AFHttpCallback)callback;

+ (void)doPostBodyWithUrl:(CTURLModel *)model imageArray:(NSArray<UIImage *>*)imageArray callback:(AFHttpCallback)callback;
@end
