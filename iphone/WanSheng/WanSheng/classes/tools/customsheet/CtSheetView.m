//
//  CtSheetView.m
//  CTSheetPop
//
//  Created by ctzq on 2018/1/9.
//  Copyright © 2018年 ctzq. All rights reserved.
//

#import "CtSheetView.h"

#define screenwidth [UIScreen mainScreen].bounds.size.width
#define screenheight [UIScreen mainScreen].bounds.size.height
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@implementation CtSheetView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
 初始化map：@{@"name":@"推荐人：",@"nameValue":@"请输入您的名称或称呼",@"number":@"手机号码：",@"numberValue":@"请输入您的手机号码",@"tips":@"推荐好友成为万商代理，服务商家，创造财富",@"commitName":@"点击推荐"}
 
 
 
 
 
*/

- (CtSheetView *)initWithMap:(NSDictionary *)dic clickBlock:(ClickBlock)clickBlock {
    self = [super init];
    if (self) {
        
        finBlock = clickBlock;
        
        if ([UIApplication sharedApplication].statusBarFrame.size.height > 20) {
            self.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-34);
        } else {
            self.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
        }
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.1];
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] init];
        tapGesture.delegate = self;
        [tapGesture addTarget:self action:@selector(letViewDisimss)];
        [self addGestureRecognizer:tapGesture];
        [self mapWithContaintView:dic];
        
        
    }
    return self;
}

- (void)mapWithContaintView:(NSDictionary *)dic {
    
    UIView *containtView = [[UIView alloc]initWithFrame:CGRectMake(0, screenheight-180, screenwidth, 180)];
    
        if ([UIApplication sharedApplication].statusBarFrame.size.height > 20) {
            containtView.frame = CGRectMake(0, screenheight-180-34, screenwidth, 180);
        }
    
    containtView.backgroundColor = [UIColor whiteColor];
    UILabel *name = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, 80, 50)];
    name.text = dic[@"name"];
    name.font = [UIFont systemFontOfSize:14];
    name.textAlignment = NSTextAlignmentRight;
    name.textColor = UIColorFromRGB(0x333333);
    UITextField *fieldName = [[UITextField alloc]initWithFrame:CGRectMake(100, 0, screenwidth-110, 50)];
    fieldName.placeholder = dic[@"nameValue"];
    fieldName.font = [UIFont systemFontOfSize:14];
    UIView *lineOne = [[UIView alloc]initWithFrame:CGRectMake(0, 49.5, screenwidth, 0.5)];
    lineOne.backgroundColor = UIColorFromRGB(0xeeeeee);
    self.filedName = fieldName;
    [containtView addSubview:self.filedName];
    [containtView addSubview:lineOne];
    [containtView addSubview:name];
    
    UILabel *number = [[UILabel alloc]initWithFrame:CGRectMake(20, 50, 80, 50)];
    number.text = dic[@"number"];
    number.font = [UIFont systemFontOfSize:14];
    number.textAlignment = NSTextAlignmentRight;
    number.textColor = UIColorFromRGB(0x333333);
    UITextField *fieldNumber = [[UITextField alloc]initWithFrame:CGRectMake(100, 50, screenwidth-110, 50)];
    fieldNumber.placeholder = dic[@"numberValue"];
    fieldNumber.font = [UIFont systemFontOfSize:14];
    UIView *lineTwo = [[UIView alloc]initWithFrame:CGRectMake(0, 99.5, screenwidth, 0.5)];
    lineTwo.backgroundColor = UIColorFromRGB(0xeeeeee);
    self.fieldNumber = fieldNumber;
    [containtView addSubview:self.fieldNumber];
    [containtView addSubview:lineTwo];
    [containtView addSubview:number];
    
    UIView *tipView = [[UIView alloc] initWithFrame:CGRectMake(0, 100, screenwidth, 30)];
    tipView.backgroundColor = UIColorFromRGB(0xe8ca9e);
    [containtView addSubview:tipView];
    UIImageView *tipImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_recommend_hint"]];
    tipImg.contentMode = UIViewContentModeScaleAspectFit;
    tipImg.frame = CGRectMake(15, 5, 20, 20);
    [tipView addSubview:tipImg];
    UILabel *tipText = [[UILabel alloc]initWithFrame:CGRectMake(40, 5, screenwidth-55, 20)];
    tipText.text = dic[@"tips"];
    tipText.textColor = UIColorFromRGB(0xff7600);
    tipText.font = [UIFont systemFontOfSize:12];
    [tipView addSubview: tipText];
    
    UIButton *commit = [UIButton buttonWithType:UIButtonTypeCustom];
    commit.frame = CGRectMake(0, 130, screenwidth, 50);
    commit.backgroundColor = [UIColor redColor];
    [commit setTitle:dic[@"commitName"] forState:UIControlStateNormal];
    [commit setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [commit addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
    self.commit = commit;
    [containtView addSubview:self.commit];
    self.containtView = containtView;
    [self addSubview:self.containtView];
    
}

- (void)show {
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    [window addSubview:self];
    [UIView animateWithDuration:0.5 animations:^{
        if ([UIApplication sharedApplication].statusBarFrame.size.height > 20) {
            self.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-34);
        } else {
            self.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
        }
        
    }];
}

- (void)letViewDisimss {
    
    [UIView animateWithDuration:0.5 animations:^{
        [self setFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width, 0)];
        self.alpha = 0;
    } completion:^(BOOL finished) {
        if (finished) {
            [self removeFromSuperview];
        }
    }];
}

- (void)click {
    
    if (self.filedName.text.length == 0) {
        [WSMessageAlert showMessage:@"请填写推荐人"];
        return;
    }
    if (self.fieldNumber.text.length == 0) {
        [WSMessageAlert showMessage:@"请填写手机号"];
        return;
    }
  
    [self letViewDisimss];
    
    if (finBlock) {
        finBlock(self.filedName.text,self.fieldNumber.text);
    }
    
}

-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    
    if ([touch.view isDescendantOfView:self.containtView]) {
        return NO;
    }
    
    return YES;
    
}


@end
