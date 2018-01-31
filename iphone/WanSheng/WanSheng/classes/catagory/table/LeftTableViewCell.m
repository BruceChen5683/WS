//
//  LeftTableViewCell.m
//  Linkage
//
//  Created by LeeJay on 16/8/22.
//  Copyright © 2016年 LeeJay. All rights reserved.
//  代码下载地址https://github.com/leejayID/Linkage

#import "LeftTableViewCell.h"
#import "UIColor+JGHexColor.h"

#define defaultColor rgba(253, 212, 49, 1)

@interface LeftTableViewCell ()

@property (nonatomic, strong) UIView *redView;

@end

@implementation LeftTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        self.name = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 75, 50)];
        self.name.numberOfLines = 0;
        self.name.font = [UIFont systemFontOfSize:15];
        self.name.textColor = [UIColor colorWithHexCode:@"#333333"];
        self.name.highlightedTextColor = [UIColor redColor];
        [self.contentView addSubview:self.name];

        self.redView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 3, 50)];
        self.redView.backgroundColor = [UIColor redColor];
        [self.contentView addSubview:self.redView];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state

}

- (void)bechoosed:(BOOL)choose{
    self.contentView.backgroundColor = choose ? [UIColor colorWithHexCode:@"#eeeeee"]: [UIColor colorWithHexCode:@"#ffffff"];
    self.highlighted = choose;
    self.name.highlighted = choose;
    self.redView.hidden = !choose;
}

@end
