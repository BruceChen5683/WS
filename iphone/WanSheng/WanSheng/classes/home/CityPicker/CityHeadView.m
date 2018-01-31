//
//  CityHeadView.m
//  ChooseArea
//
//  Created by ctzq on 2018/1/11.
//  Copyright © 2018年 zhushuai. All rights reserved.
//

#import "CityHeadView.h"

@implementation CityHeadView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (id)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        self.label = [[UILabel alloc]initWithFrame:CGRectMake(15, 5, 100, 20)];
        self.label.textAlignment = NSTextAlignmentLeft;
        self.label.font = [UIFont systemFontOfSize:14];
        [self addSubview:self.label];
    }
    return self;
}
@end
