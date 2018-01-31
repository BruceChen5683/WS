//
//  HomeMenuView.m
//  WanSheng
//
//  Created by mao on 2018/1/5.
//  Copyright © 2018年 mao. All rights reserved.
//

#import "HomeMenuView.h"
#import "HomeMenuCollectionViewCell.h"

@implementation HomeMenuView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)awakeFromNib {
    [super awakeFromNib];
    self.collection.delegate = self;
    self.collection.dataSource = self;
    [self.collection reloadData];

    self.menulist =@[@{@"icon":@"icon_home_food",@"name":@"餐饮美食"},
                     @{@"icon":@"icon_home_supermarket",@"name":@"超市百货"},
                     @{@"icon":@"icon_home_entertainment",@"name":@"娱乐休闲"},
                     @{@"icon":@"icon_home_life",@"name":@"生活服务"},
                     @{@"icon":@"icon_home_wholesale",@"name":@"贸易批发"},
                     @{@"icon":@"icon_home_business",@"name":@"商业服务"},
                     @{@"icon":@"icon_home_education",@"name":@"教育培训"},
                     @{@"icon":@"icon_home_car",@"name":@"汽车服务"}];
}

- (void)setMenulist:(NSArray *)menulist {
    _menulist = menulist;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.menulist.count;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    HomeMenuCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:HOME_MenuCELLID forIndexPath:indexPath];
    NSDictionary *dic = self.menulist[indexPath.row];
    cell.nameLbl.text = dic[@"name"];
    cell.titleImgView.image = [UIImage imageNamed:dic[@"icon"]];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    NSDictionary *dic = self.menulist[indexPath.row];
    if (self.menuClicked) {
        self.menuClicked(dic[@"name"]);
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat f = ScreenWidth / 4.0 - 2;
    return CGSizeMake(f, 90);
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsZero;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

@end
