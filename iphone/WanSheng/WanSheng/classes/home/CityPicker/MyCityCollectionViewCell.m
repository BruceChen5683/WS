//
//  MyCityCollectionViewCell.m
//  ChooseArea
//
//  Created by ctzq on 2018/1/11.
//  Copyright © 2018年 zhushuai. All rights reserved.
//

#import "MyCityCollectionViewCell.h"

@implementation MyCityCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.title.clipsToBounds = true;
  //  self.title.layer.cornerRadius = 5;
   // self.title.layer.borderColor = [UIColor redColor].CGColor;
  //  self.title.layer.borderWidth = 0.5;
    // Initialization code
}

@end
