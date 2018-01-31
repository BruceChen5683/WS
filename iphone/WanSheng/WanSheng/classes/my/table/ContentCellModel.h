//
//  ContentCellModel.h
//  WanSheng
//
//  Created by mao on 2018/1/8.
//  Copyright © 2018年 mao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ContentCellModel : NSObject

@property(nonatomic, copy) NSString *title;

@property(nonatomic, copy) NSString *imgName;

@property(nonatomic, copy) NSString *desp;

- (ContentCellModel *)initWithImgName:(NSString *)imgName title:(NSString *)title desp:(NSString *)desp;

@end
