//
//  HomeHotCollectionViewCell.m
//  WanSheng
//
//  Created by mao on 2018/1/9.
//  Copyright © 2018年 mao. All rights reserved.
//

#import "HomeHotCollectionViewCell.h"

@implementation HomeHotCollectionViewCell

- (void)loadContents:(BuildingDetailModel *)m {
    [_imgView downImageWithUrl:m.logoUrl];
    _nameLbl.text = m.name;
}

@end
