//
//  CustomPickerView.m
//  WanSheng
//
//  Created by mao on 2018/1/16.
//  Copyright © 2018年 mao. All rights reserved.
//

#import "CustomPickerView.h"

@implementation CustomPickerView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        //
        //216 + 40
        self.frame = [UIScreen mainScreen].bounds;
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.35];
        self.tag = 76;
        UITapGestureRecognizer *ges = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(blankAreaClicked:)];
        ges.delegate = self;
        ges.numberOfTapsRequired = 1;
        [self addGestureRecognizer:ges];
        
        CGFloat y = (CGRectGetHeight(self.frame) - 256)/2;
        
        self.addresPickerView = [[AddressPickerView alloc] initWithFrame:CGRectMake(0, y, CGRectGetWidth(self.frame), 216)];
        self.addresPickerView.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.addresPickerView];
        [self.addresPickerView sendReqs];
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
        [btn setTitle:@"确定" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btn setBackgroundColor:[UIColor redColor]];
        [btn.titleLabel setFont:[UIFont systemFontOfSize:18]];
        btn.frame = CGRectMake(0, y + 216, CGRectGetWidth(self.frame), 40);
        [btn addTarget:self action:@selector(doClickConfirm:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
    }
    return self;
}

- (void)doClickConfirm:(id)sender {
    
    NSInteger selectOne = [self.addresPickerView.pickerView selectedRowInComponent:0];
    NSInteger selectTwo = [self.addresPickerView.pickerView selectedRowInComponent:1];
    NSInteger selectThree = [self.addresPickerView.pickerView selectedRowInComponent:2];
    
    ProvinceModel *model = self.addresPickerView.provinceArr.count > selectOne? self.addresPickerView.provinceArr[selectOne]:@"";
    CityModel *cityModel = model.citiesArr.count > selectTwo? model.citiesArr[selectTwo]:nil;
    AreaModel *areaModel = cityModel.areaArray.count > selectThree? cityModel.areaArray[selectThree]:nil;
    
    if (areaModel.aID.integerValue == -1) {
        //选择的是城市
        if (self.doRequireAddressBlock) {
            self.doRequireAddressBlock(model, cityModel, nil);
        }
 
    }
    else {
        if (self.doRequireAddressBlock) {
            self.doRequireAddressBlock(model, cityModel, areaModel);
        }
    }
}

- (void)blankAreaClicked:(UITapGestureRecognizer *)ges {
    self.hidden = YES;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    if (gestureRecognizer.view.tag == 76) {
        return YES;
    }
    return NO;
}

@end
