//
//  WSWebViewController.m
//  WanSheng
//
//  Created by mao on 2018/2/7.
//  Copyright © 2018年 mao. All rights reserved.
//

#import "WSWebViewController.h"

@interface WSWebViewController ()

@property(weak, nonatomic) IBOutlet UIWebView *web;

@end

@implementation WSWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.web loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.urlStr]]];
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
