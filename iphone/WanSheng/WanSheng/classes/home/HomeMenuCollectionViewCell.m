//
//  HomeMenuCollectionViewCell.m
//  WanSheng
//
//  Created by mao on 2018/1/5.
//  Copyright © 2018年 mao. All rights reserved.
//

#import "HomeMenuCollectionViewCell.h"

@implementation HomeMenuCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.titleImgView.layer.cornerRadius = 25;
    
    self.titleImgView.clipsToBounds = YES;
}

@end
