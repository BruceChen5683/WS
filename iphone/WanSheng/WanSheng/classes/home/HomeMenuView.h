//
//  HomeMenuView.h
//  WanSheng
//
//  Created by mao on 2018/1/5.
//  Copyright © 2018年 mao. All rights reserved.
//

#import <UIKit/UIKit.h>

#define HOME_MenuCELLID @"homeMenuCell"

@interface HomeMenuView : UIView<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property(nonatomic, weak) IBOutlet UICollectionView *collection;

@property(nonatomic, strong) NSArray *menulist;

@property(copy, nonatomic) void(^menuClicked)(NSString* name);

@end
