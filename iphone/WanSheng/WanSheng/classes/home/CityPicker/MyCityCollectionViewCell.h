//
//  MyCityCollectionViewCell.h
//  ChooseArea
//
//  Created by ctzq on 2018/1/11.
//  Copyright © 2018年 zhushuai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyCityCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *labelWidth;

@end
