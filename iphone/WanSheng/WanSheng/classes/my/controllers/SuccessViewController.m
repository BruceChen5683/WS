//
//  SuccessViewController.m
//  WanSheng
//
//  Created by mao on 2018/1/12.
//  Copyright © 2018年 mao. All rights reserved.
//

#import "SuccessViewController.h"
#import "ZJBLTabbarController.h"
@interface SuccessViewController ()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imgHeightConstraint;

@end

@implementation SuccessViewController

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
    
    CGFloat f = [AdaptFrame ws_top:self.view];
    self.imgHeightConstraint.constant = 250 + f;
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
    [self.navigationController popToRootViewControllerAnimated:YES];
    [[ZJBLTabbarController sharedZJBLTabbarController] goToSelectCtrlWithTitle:@"首页" Index:0];
}

/*
 
 禁止当前页面左侧滑动返回 导致卡死
 
 */


-(void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
    
    self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    
}



-(void)viewWillDisappear:(BOOL)animated

{
    
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    
    [super viewWillDisappear:animated];
    
}



@end
