//
//  SearchDropView.m
//  WanSheng
//
//  Created by mao on 2018/1/10.
//  Copyright © 2018年 mao. All rights reserved.
//

#import "SearchDropView.h"

@implementation SearchDropView


- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.dropTB.tableFooterView = [UIView new];
    if ([self.dropTB respondsToSelector:@selector(separatorInset)]) {
        self.dropTB.separatorInset = UIEdgeInsetsZero;
    }
    if ([self.dropTB respondsToSelector:@selector(setLayoutMargins:)]) {
        [self.dropTB setLayoutMargins:UIEdgeInsetsMake(0,0,0,0)];
    }

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"dropcell"];
    
    if (indexPath.row == 0) {
        cell.textLabel.text = @"智能排序";
    }
    else if (indexPath.row == 1) {
        cell.textLabel.text = @"距离最近";
    }
    else if (indexPath.row == 2) {
        cell.textLabel.text = @"人气最高";
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (self.cellClick) {
        self.cellClick(indexPath.row);
    }
}

@end
