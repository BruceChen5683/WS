//
//  HotelAddressTableViewCell.m
//  PopView
//
//  Created by ctzq on 2018/1/9.
//  Copyright © 2018年 ctzq. All rights reserved.
//

#import "HotelAddressTableViewCell.h"

@implementation HotelAddressTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setContents:(BuildingDetailModel *)m {
    _hotelName.text = m.name;
    _currentStatueImg.hidden = (m.isHot.integerValue != 1);
    _hotelTypeImg.hidden = [m.type isEqualToString:@"normal"];
    _browsCount.text = [NSString stringWithFormat:@"%@",m.viewNum];
    _addressName.text = m.address;
}

@end
