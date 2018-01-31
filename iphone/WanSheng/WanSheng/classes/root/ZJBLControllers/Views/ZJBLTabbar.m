//
//  ZJBLTabbar.m
//  ZJBL-SJ
//
//  Created by 郭军 on 2017/5/8.
//  Copyright © 2017年 ZJNY. All rights reserved.
//

#import "ZJBLTabbar.h"
#import "ZJBLConst.h"

@implementation ZJBLTabbar {
    ZJBLTabbarButton *_selectedBarButton;
    
}


-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self addBarButtons];
    }
    return self;
}

-(void) addBarButtons{
    
    
    NSArray *titlesArr = @[@"首页",@"分类",@"搜索",@"我的",@"推荐"];
    NSArray *normalImage = @[@"btn_home_uncheck" ,@"btn_classifyl_uncheck" ,@"btn_search_uncheck" ,@"btn_personal_uncheck" ,@"btn_recommend_uncheck" ];
    NSArray *selectedImage = @[@"btn_home_check" ,@"btn_classifyl_check" ,@"btn_search_check" ,@"btn_personal_check" ,@"btn_recommend_check" ];
    //btn_classifyl_uncheck
    
   // Scheduling_selected
    for (int i = 0 ; i<titlesArr.count ; i++) {
        ZJBLTabbarButton *btn = [[ZJBLTabbarButton alloc] init];
        CGFloat btnW = self.frame.size.width/5;
        CGFloat btnX = i * btnW;
        CGFloat btnY = 0;
        CGFloat btnH = self.frame.size.height;
        
        btn.frame = CGRectMake(btnX, btnY, btnW, btnH);
        NSString *imageName = [NSString stringWithFormat:@"%@",normalImage[i]];
        NSString *selImageName = [NSString stringWithFormat:@"%@",selectedImage[i]];
        NSString *title = titlesArr[i];
        
        [btn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:selImageName] forState:UIControlStateSelected];
        btn.tag = i;
        
        
        if (i!=2) {
            [btn setTitle:title forState:UIControlStateNormal];
            btn.titleLabel.font = [UIFont systemFontOfSize: 11.0];
            btn.titleLabel.textAlignment = NSTextAlignmentCenter;
            
            [btn setTitleColor:[UIColor colorWithHexCode:@"#d5000a"] forState:UIControlStateSelected];
            [btn setTitleColor:JGRGBColor(128, 128, 128) forState:UIControlStateNormal];
            [self addSubview:btn];
            [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchDown];
        }
        btn.imageView.contentMode = UIViewContentModeScaleAspectFit;
        //        [self addSubview:btn];
        
        if(i == 0){
            [self btnClick:btn];
        }
    }
}


-(void) btnClick:(ZJBLTabbarButton *)button{
    
    
    [self.delegate changeNav:_selectedBarButton.tag to:button.tag andBtn:button];
    _selectedBarButton.selected = NO;
    button.selected = YES;
    _selectedBarButton = button;
    
    
}

@end
