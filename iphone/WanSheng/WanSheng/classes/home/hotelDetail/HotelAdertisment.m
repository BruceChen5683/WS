//
//  HotelAdertisment.m
//  WanSheng
//
//  Created by mao on 2018/1/11.
//  Copyright © 2018年 mao. All rights reserved.
//

#import "HotelAdertisment.h"

@implementation HotelAdertisment

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (IBAction)doClickModifyBtn:(id)sender {
    if (self.goclickBlock) {
        self.goclickBlock();
    }
}

@end
