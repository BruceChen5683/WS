//
//  CustomPickerView.h
//  WanSheng
//
//  Created by mao on 2018/1/16.
//  Copyright © 2018年 mao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddressPickerView.h"

@interface CustomPickerView : UIView<UIGestureRecognizerDelegate>

@property(nonatomic, strong) AddressPickerView *addresPickerView;

@property(copy, nonatomic) void(^doRequireAddressBlock)(ProvinceModel *p, CityModel *c,AreaModel *a);

@end
