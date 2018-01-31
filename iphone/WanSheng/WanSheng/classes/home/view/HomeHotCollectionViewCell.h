//
//  HomeHotCollectionViewCell.h
//  WanSheng
//
//  Created by mao on 2018/1/9.
//  Copyright © 2018年 mao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ActiveImageView.h"
#import "BuildingDetailModel.h"

#define hotCellID   @"hotcellid"

@interface HomeHotCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet ActiveImageView *imgView;
@property (weak, nonatomic) IBOutlet UILabel *nameLbl;

- (void)loadContents:(BuildingDetailModel *)m;

@end
