//
//  HotelCommentTableViewCell.h
//  PopView
//
//  Created by ctzq on 2018/1/9.
//  Copyright © 2018年 ctzq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BuildingDetailModel.h"

@interface HotelCommentTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *hotelImg;
@property (weak, nonatomic) IBOutlet UILabel *hotelName;
@property (weak, nonatomic) IBOutlet UILabel *phone;
@property (weak, nonatomic) IBOutlet UILabel *address;

- (void)loadContents:(BuildingDetailModel *)m;

@end
