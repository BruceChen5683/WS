//
//  ZJBLCustomBaseNavController.m
//  ZJBL-GL
//
//  Created by 郭军 on 2017/6/1.
//  Copyright © 2017年 ZJBL. All rights reserved.
//

#import "ZJBLCustomBaseNavController.h"
#import "ZJBLConst.h"
@interface ZJBLCustomBaseNavController ()

@end

@implementation ZJBLCustomBaseNavController


/** 导航栏标题 */
- (NSString *)CustomNavTitle {
    return @"";
}



- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    //隐藏导航栏
    /*
     navigationBarHidden: 连同导航侧滑返回手势消失
     navigationBar.hidden: 只消失导航
     */
    //    self.navigationController.navigationBarHidden = YES;
    self.navigationController.navigationBar.hidden = YES;
    
}


-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    //显示导航栏
    //    self.navigationController.navigationBarHidden = NO;
    self.navigationController.navigationBar.hidden = NO;
}




- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor colorWithHexCode:@"#ffffff"];
    
    
    //创建导航栏
    [self createNavBar];
    
}





//创建导航栏
- (void)createNavBar {
    
    UIView *navView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, 64)];
    [self.view addSubview:navView];
    
    UIImageView *navImgV = [[UIImageView alloc] initWithFrame:navView.bounds];
    navImgV.image = [UIImage imageNamed:@"nav_bg"];
    [navView addSubview:navImgV];
    
    //返回按钮
    UIButton *backBtn = [[UIButton alloc] initWithFrame:CGRectMake(4, 31, 30, 30)];
    [backBtn setImage:[UIImage imageNamed:@"nav_back"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [navView addSubview:backBtn];
    
    //标题
    UILabel *titleLbl = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, 50, 44)];
    titleLbl.text = self.CustomNavTitle;
    titleLbl.font = JGFont(17);
    titleLbl.textColor = [UIColor colorWithHexCode:@"#ffffff"];
    [titleLbl sizeToFit];
    titleLbl.center = CGPointMake(kDeviceWidth * 0.5, 44);
    [navView addSubview:titleLbl];
}


// 返回
- (void)backBtnClick {
    
    
    
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
