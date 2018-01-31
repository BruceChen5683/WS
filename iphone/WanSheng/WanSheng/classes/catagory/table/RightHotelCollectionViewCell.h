//
//  RightHotelCollectionViewCell.h
//  WanSheng
//
//  Created by mao on 2018/1/10.
//  Copyright © 2018年 mao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ActiveImageView.h"
#define RightCollectionCellID   @"rightcelliid"
@interface RightHotelCollectionViewCell : UICollectionViewCell

@property(weak, nonatomic) IBOutlet ActiveImageView *imgV;

@property(weak, nonatomic) IBOutlet UILabel *nameLbl;

@property(weak, nonatomic) IBOutlet UILabel *addressLbl;

@property(weak, nonatomic) IBOutlet UILabel *phoneLbl;



@end
