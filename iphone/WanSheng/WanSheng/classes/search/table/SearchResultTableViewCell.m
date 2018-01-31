//
//  SearchResultTableViewCell.m
//  WanSheng
//
//  Created by mao on 2018/1/9.
//  Copyright © 2018年 mao. All rights reserved.
//

#import "SearchResultTableViewCell.h"

@implementation SearchResultTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)loadContentsByM:(BuildingDetailModel *)m {
    _nameLbl.text = m.name;
    _addressLbl.text = m.address;
    _phoneLbl.text = m.phone;
    [_imgView downImageWithUrl:m.logoUrl];
    _goldImgView.hidden = [m.type isEqualToString:@"normal"];
}

@end
