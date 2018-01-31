//
//  BaseViewController.m
//  WanSheng
//
//  Created by mao on 2018/1/4.
//  Copyright © 2018年 mao. All rights reserved.
//

#import "BaseViewController.h"
#import "ZJBLTabbarController.h"

@interface BaseViewController ()

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *titleTopConstaint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *viewHConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentViewBottomConstraint;
@property (weak, nonatomic) IBOutlet UIView *contentView;

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    CGFloat top = [AdaptFrame ws_top:self.view];
    self.titleTopConstaint.constant = top>0? top:0;
    self.viewHConstraint.constant = top>0? top + 44:64;

    CGFloat bottom = [AdaptFrame ws_bottom:self.view];
    if ([self isKindOfClass:NSClassFromString(@"KindsViewController")] ||
        [self isKindOfClass:NSClassFromString(@"HomeViewController")] ||
         [self isKindOfClass:NSClassFromString(@"MyViewController")] ||
        [self isKindOfClass:NSClassFromString(@"SearchViewController")] ||
        [self isKindOfClass:NSClassFromString(@"RecommendViewController")] ) {
        self.contentViewBottomConstraint.constant = bottom + 49;
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if ([self isKindOfClass:NSClassFromString(@"KindsViewController")] ||
        [self isKindOfClass:NSClassFromString(@"HomeViewController")] ||
        [self isKindOfClass:NSClassFromString(@"MyViewController")] ||
        [self isKindOfClass:NSClassFromString(@"SearchViewController")] ||
        [self isKindOfClass:NSClassFromString(@"RecommendViewController")] ) {
        [[ZJBLTabbarController sharedZJBLTabbarController] showCusTabbar];
    }
    else {
        [[ZJBLTabbarController sharedZJBLTabbarController] hiddenCusTabbar];
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)clickBackOper:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}


@end
