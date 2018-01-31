//
//  AddressPickerView.h
//  WanSheng
//
//  Created by mao on 2018/1/16.
//  Copyright © 2018年 mao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AreaModel.h"
#import "CityModel.h"
#import "ProvinceModel.h"

@interface AddressPickerView : UIView<UIPickerViewDelegate,UIPickerViewDataSource>

@property(strong, nonatomic) UIPickerView *pickerView;

@property(nonatomic, strong) NSMutableArray *provinceArr;

@property(copy, nonatomic) void(^notifyUIBlock)(void);

- (void)sendReqs;

@end
