//
//  ContactKFViewController.m
//  WanSheng
//
//  Created by mao on 2018/1/8.
//  Copyright © 2018年 mao. All rights reserved.
//

#import "ContactKFViewController.h"

@interface ContactKFViewController ()
@property (weak, nonatomic) IBOutlet UILabel *rowOneLbl;
@property (weak, nonatomic) IBOutlet UILabel *rowTwoLbl;
@property (weak, nonatomic) IBOutlet UILabel *rowThreeLbl;

@end

@implementation ContactKFViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)clickRowOne:(id)sender {
    UIPasteboard* pasteboard = [UIPasteboard generalPasteboard];
    [pasteboard setString:self.rowOneLbl.text];
    [WSMessageAlert showMessage:@"复制成功"];
}
- (IBAction)clickRowTwo:(id)sender {
    UIPasteboard* pasteboard = [UIPasteboard generalPasteboard];
    [pasteboard setString:self.rowTwoLbl.text];
    [WSMessageAlert showMessage:@"复制成功"];
}
- (IBAction)clickRowThree:(id)sender {
    NSString *str=[[NSString alloc]initWithFormat:@"tel:%@",self.rowThreeLbl.text];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
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
