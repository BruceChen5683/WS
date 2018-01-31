//
//  HotelModifyViewController.h
//  WanSheng
//
//  Created by mao on 2018/1/11.
//  Copyright © 2018年 mao. All rights reserved.
//

#import "BaseViewController.h"
#import "BuildingDetailModel.h"

@interface HotelModifyViewController : BaseViewController

@property (weak, nonatomic) IBOutlet UILabel *pageTitle;
@property (weak, nonatomic) IBOutlet UILabel *hotelTitle;
@property (weak, nonatomic) IBOutlet UILabel *addressLbl;
@property (weak, nonatomic) IBOutlet UILabel *phoneLbl;
@property (weak, nonatomic) IBOutlet UIButton *clickAquireBtn;
@property (weak, nonatomic) IBOutlet UITextField *proveTxtfield;
@property (weak, nonatomic) IBOutlet UITextView *changedTextView;
@property (weak, nonatomic) IBOutlet UILabel *changeTitleLbl;
@property (weak, nonatomic) IBOutlet UIButton *confirmBtn;

@property(nonatomic, assign) NSInteger source;

@property(nonatomic, strong) BuildingDetailModel *buildModel;

@end
