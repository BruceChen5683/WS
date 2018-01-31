//
//  HomePMDView.m
//  WanSheng
//
//  Created by mao on 2018/1/5.
//  Copyright © 2018年 mao. All rights reserved.
//

#import "HomePMDView.h"

@implementation HomePMDView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)awakeFromNib {
    [super awakeFromNib];
    
    // 由于模拟器的渲染问题，如果发现轮播时有一条线不必处理，模拟器放大到100%或者真机调试是不会出现那条线的
    self.scrollDirection = UICollectionViewScrollDirectionVertical;
    self.onlyDisplayText = YES;
    [self disableScrollGesture];
    self.titleLabelBackgroundColor = [UIColor whiteColor];
    self.titleLabelTextColor = [UIColor grayColor];
}

- (void)setPmdArray:(NSArray *)pmdArray {
    _pmdArray = pmdArray;
    self.titlesGroup = _pmdArray;
}

@end
