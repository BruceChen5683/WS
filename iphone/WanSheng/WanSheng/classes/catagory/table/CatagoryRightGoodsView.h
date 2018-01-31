//
//  CatagoryRightGoodsView.h
//  WanSheng
//
//  Created by mao on 2018/1/10.
//  Copyright © 2018年 mao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RightHotelCollectionViewCell.h"
#import "BuildingDetailModel.h"

@interface CatagoryRightGoodsView : UIView<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
{
    long currentPage;
}
@property(nonatomic, strong) NSMutableArray *hotelDataSource;

@property(weak, nonatomic) IBOutlet UILabel *titleLbl;

@property(weak, nonatomic) IBOutlet UICollectionView *collection;

@property(copy,nonatomic) void(^backBtnBlock)(void);

@property(copy,nonatomic) void(^clickHotelBlock)(BuildingDetailModel *m);

@property(copy, nonatomic) NSNumber *catagoryId;

- (void)showContent;

@end
