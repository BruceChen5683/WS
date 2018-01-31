//
//  LookMyRecommendsViewController.m
//  WanSheng
//
//  Created by mao on 2018/1/10.
//  Copyright © 2018年 mao. All rights reserved.
//

#import "LookMyRecommendsViewController.h"
#import "CTURLModel.h"

@interface LookMyRecommendsViewController ()
@property (weak, nonatomic) IBOutlet UITextField *phoneTxt;
@property (weak, nonatomic) IBOutlet UITextField *iccardIDTxt;

@property (weak, nonatomic) IBOutlet UIView *lookView;
@property (weak, nonatomic) IBOutlet UILabel *recommadLineOneLbl;
@property (weak, nonatomic) IBOutlet UILabel *recommandLineTwoLbl;

@end

@implementation LookMyRecommendsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)clickLookRecommands:(id)sender {
    if (self.phoneTxt.text.length == 0) {
        [WSMessageAlert showMessage:self.phoneTxt.placeholder];
        return;
    }
    if (self.iccardIDTxt.text.length == 0) {
        [WSMessageAlert showMessage:self.iccardIDTxt.placeholder];
        return;
    }
        // merchant/findNum/13512345678
        NSString *urlstr = [BaseUrl stringByAppendingString:[NSString stringWithFormat:@"merchant/findNum/%@",self.phoneTxt.text]];
        CTURLModel *model = [CTURLModel initWithUrl:urlstr params:nil];
        __weak typeof(self) weakSelf = self;
        [WSBaseRequest GET:model success:^(id responseObject) {
            __strong typeof(weakSelf) strongSelf = weakSelf;
            NSDictionary *dic = (NSDictionary *)responseObject;
            if ([dic[@"errcode"] integerValue]  == 0) {
                strongSelf.recommandLineTwoLbl.text = [NSString stringWithFormat:@"累计推荐: %@家",dic[@"data"]];
                strongSelf.lookView.hidden = NO;
            }
            
        } failure:^(NSError *error) {
            
            
        }];
    
    
   // api/merchant/getReferees/13512345678
    NSString *getRefereesUrl = [BaseUrl stringByAppendingString:[NSString stringWithFormat:@"merchant/getReferees/%@",self.phoneTxt.text]];
    CTURLModel *getRefereesModel = [CTURLModel initWithUrl:getRefereesUrl params:nil];
    [WSBaseRequest GET:getRefereesModel success:^(id responseObject) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        NSDictionary *dic = (NSDictionary *)responseObject;
        if ([dic[@"errcode"] integerValue]  == 0) {
            strongSelf.recommadLineOneLbl.text = [NSString stringWithFormat:@"今日推荐: %@家",dic[@"data"]];
            strongSelf.lookView.hidden = NO;
        }
        
    } failure:^(NSError *error) {
        
        
    }];

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
