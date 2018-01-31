//
//  ZJBLNavigationController.m
//  ZJBL-GL
//
//  Created by 郭军 on 2017/5/31.
//  Copyright © 2017年 ZJBL. All rights reserved.
//

#import "ZJBLNavigationController.h"
#import "ZJBLConst.h"
@interface ZJBLNavigationController ()

@end

@implementation ZJBLNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
 
    /*
    //背景
    [self.navigationBar setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithHexCode:@"#d5000a"]] forBarMetrics:UIBarMetricsDefault];
    //标题字体颜色
    [self.navigationBar setTitleTextAttributes:@{
                                                 NSForegroundColorAttributeName:[UIColor colorWithHexCode:@"#ffffff"],
                                                 NSFontAttributeName : JGBoldFont(21),
                                                 }];
    
    [self.navigationBar setTintColor:[UIColor colorWithHexCode:@"#ffffff"]];
*/
    self.navigationBar.hidden = YES;
    
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
