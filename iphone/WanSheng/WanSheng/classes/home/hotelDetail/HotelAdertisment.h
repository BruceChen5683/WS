//
//  HotelAdertisment.h
//  WanSheng
//
//  Created by mao on 2018/1/11.
//  Copyright © 2018年 mao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HotelAdertisment : UIView
@property (weak, nonatomic) IBOutlet UILabel *titleLbl;
@property (weak, nonatomic) IBOutlet UITextView *content;
@property (weak, nonatomic) IBOutlet UIButton *clickBtn;

@property(copy, nonatomic) void(^goclickBlock)(void);

@end
