//
//  CtSheetView.h
//  CTSheetPop
//
//  Created by ctzq on 2018/1/9.
//  Copyright © 2018年 ctzq. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ClickBlock)(NSString *name,NSString *phone);

@interface CtSheetView : UIView<UIGestureRecognizerDelegate>
{
    ClickBlock finBlock;
}
@property(nonatomic, assign) UITextField *filedName;

@property(nonatomic, assign) UITextField *fieldNumber;

@property(nonatomic, assign) UIButton *commit;

@property(nonatomic, assign) UIView *containtView;

- (CtSheetView *)initWithMap:(NSDictionary *)dic clickBlock:(ClickBlock)clickBlock;

- (void)show;

@end
