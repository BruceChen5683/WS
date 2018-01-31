//
//  PayTableViewCell.m
//  WanSheng
//
//  Created by mao on 2018/1/23.
//  Copyright © 2018年 mao. All rights reserved.
//

#import "PayTableViewCell.h"

@implementation PayTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setSelect:(BOOL)select {
    _select = select;
    
    if (select) {
        [_selectImg setImage:[UIImage imageNamed:@"icon_my_selected"]];
    }
    else {
        [_selectImg setImage:[UIImage imageNamed:@"icon_my_unselected"]];
    }
}

@end
