//
//  ContentTableViewCell.m
//  WanSheng
//
//  Created by mao on 2018/1/8.
//  Copyright © 2018年 mao. All rights reserved.
//

#import "ContentTableViewCell.h"

@implementation ContentTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)loadContent:(ContentCellModel *)m {
    _titleLbl.text = m.title;
    _iconImg.image = [UIImage imageNamed:m.imgName];
    _despLbl.text = m.desp;
}

@end
