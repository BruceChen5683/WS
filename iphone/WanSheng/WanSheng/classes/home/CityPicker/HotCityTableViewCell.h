//
//  HotCityTableViewCell.h
//  ChooseArea
//
//  Created by ctzq on 2018/1/11.
//  Copyright © 2018年 zhushuai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CityModel.h"

@interface HotCityTableViewCell : UITableViewCell<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic, strong) NSArray *hotArr;

@property(nonatomic, copy) void(^clickCollectionCellBlock)(NSInteger row);

@end
