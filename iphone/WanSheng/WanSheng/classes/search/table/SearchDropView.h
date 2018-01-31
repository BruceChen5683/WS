//
//  SearchDropView.h
//  WanSheng
//
//  Created by mao on 2018/1/10.
//  Copyright © 2018年 mao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchDropView : UIView<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic, weak) IBOutlet UITableView *dropTB;

@property(copy, nonatomic) void(^cellClick)(NSInteger row);

@end
