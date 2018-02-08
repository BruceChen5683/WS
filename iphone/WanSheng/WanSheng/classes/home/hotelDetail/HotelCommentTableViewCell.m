//
//  HotelCommentTableViewCell.m
//  PopView
//
//  Created by ctzq on 2018/1/9.
//  Copyright © 2018年 ctzq. All rights reserved.
//

#import "HotelCommentTableViewCell.h"
#import <UIImageView+WebCache.h>

@implementation HotelCommentTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)loadContents:(BuildingDetailModel *)m {
    [_hotelImg sd_setImageWithURL:[NSURL URLWithString:[m logoUrl]] placeholderImage:[UIImage imageNamed:@"listDefault2"]];
    _hotelName.text = m.name;
    _phone.text = m.phone;
    _address.text = m.address;
}

@end
