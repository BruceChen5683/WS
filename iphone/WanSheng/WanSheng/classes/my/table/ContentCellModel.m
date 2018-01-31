//
//  ContentCellModel.m
//  WanSheng
//
//  Created by mao on 2018/1/8.
//  Copyright © 2018年 mao. All rights reserved.
//

#import "ContentCellModel.h"

@implementation ContentCellModel

- (ContentCellModel *)initWithImgName:(NSString *)imgName title:(NSString *)title desp:(NSString *)desp {
    ContentCellModel *model = [[ContentCellModel alloc] init];
    model.imgName = imgName;
    model.title = title;
    model.desp = desp;
    return model;
}
@end
