//
//  ZJBLTabbar.h
//  ZJBL-SJ
//
//  Created by 郭军 on 2017/5/8.
//  Copyright © 2017年 ZJNY. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZJBLTabbarButton.h"


#define kTabbarHeight 49

@protocol ZJBLTabBarDelegate <NSObject>

@required
-(void)changeNav:(NSInteger)from to:(NSInteger)to andBtn:(ZJBLTabbarButton *)btn;

@end


@interface ZJBLTabbar : UIView

@property (nonatomic, strong) UILabel *badgeValue;

@property (nonatomic,weak) id <ZJBLTabBarDelegate> delegate;


@end
