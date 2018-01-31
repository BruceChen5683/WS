//
//  HotelAddressTableViewCell.h
//  PopView
//
//  Created by ctzq on 2018/1/9.
//  Copyright © 2018年 ctzq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BuildingDetailModel.h"

@interface HotelAddressTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *hotelName;
@property (weak, nonatomic) IBOutlet UIImageView *hotelTypeImg;
@property (weak, nonatomic) IBOutlet UIImageView *currentStatueImg;
@property (weak, nonatomic) IBOutlet UILabel *browsCount;
@property (weak, nonatomic) IBOutlet UILabel *addressName;

- (void)setContents:(BuildingDetailModel *)m;

@end
