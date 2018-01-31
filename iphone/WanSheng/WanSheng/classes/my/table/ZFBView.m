//
//  ZFBView.m
//  WanSheng
//
//  Created by mao on 2018/1/23.
//  Copyright © 2018年 mao. All rights reserved.
//

#import "ZFBView.h"
#import "PayTableViewCell.h"

@implementation ZFBView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self.tb registerNib:[UINib nibWithNibName:@"PayTableViewCell" bundle:nil] forCellReuseIdentifier:MethodCellID];
    
    [self.tb reloadData];
    
    self.selectIdx = 0;
    
    self.tag = 567;
    UITapGestureRecognizer *ges = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeFun)];
    ges.numberOfTapsRequired = 1;
    ges.delegate = self;
    [self addGestureRecognizer:ges];
}

- (void)removeFun {
    [self removeFromSuperview];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.paymethods.count;
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PayTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MethodCellID forIndexPath:indexPath];
    NSDictionary *dic = self.paymethods[indexPath.row];
    cell.iconImage.image = [UIImage imageNamed:dic[@"pic"]];
    cell.name.text = dic[@"name"];
    if (self.selectIdx == indexPath.row) {
        cell.select = YES;
    }
    else {
        cell.select = NO;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    PayTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.select = YES;

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

- (NSArray *)paymethods {
    
    return @[@{@"pic":@"icon_business_alipay",@"name":@"支付宝支付"}];
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    UIView *v = [touch view];
    if (v.tag == 567) {
        return YES;
    }
    return NO;
}

- (IBAction)doPayFee:(id)sender {
    if (self.payFee) {
        self.payFee(self.selectIdx);
    }
}

@end
