//
//  ZFBView.h
//  WanSheng
//
//  Created by mao on 2018/1/23.
//  Copyright © 2018年 mao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZFBView : UIView<UITableViewDelegate,UITableViewDataSource,UIGestureRecognizerDelegate>

@property(strong,nonatomic) NSArray *paymethods;
@property (weak, nonatomic) IBOutlet UITableView *tb;
@property (weak, nonatomic) IBOutlet UIButton *payBtn;

@property(nonatomic, assign) NSInteger selectIdx;

@property(copy, nonatomic) void(^payFee)(NSInteger selectIdx);

@end
