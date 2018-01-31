//
//  UploadImageCollectionViewCell.m
//  WanSheng
//
//  Created by mao on 2018/1/9.
//  Copyright © 2018年 mao. All rights reserved.
//

#import "UploadImageCollectionViewCell.h"

@implementation UploadImageCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (IBAction)clickDelete:(id)sender {
    if (self.deleteBlock) {
        self.deleteBlock(self);
    }
}

@end
