//
//  ApplyViewController.m
//  WanSheng
//
//  Created by mao on 2018/1/8.
//  Copyright © 2018年 mao. All rights reserved.
//

#import "ApplyViewController.h"
#import "UploadImageCollectionViewCell.h"
#import "SuPhotoPicker.h"
#import "SuccessViewController.h"
#import "AFHttpUtil.h"
#import "NSObject+SBJson.h"

@interface ApplyViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>


@property(nonatomic, strong) NSMutableArray *uploadedImageDataArray;
@property (weak, nonatomic) IBOutlet UICollectionView *uploadCollectionView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *uploadCollectionHConstraint;
@property (weak, nonatomic) IBOutlet UITextField *nameTxt;
@property (weak, nonatomic) IBOutlet UITextField *phoneTxt;
@property (weak, nonatomic) IBOutlet UITextField *iccardTxt;
@property (weak, nonatomic) IBOutlet UITextField *zfbTxt;
@property (weak, nonatomic) IBOutlet UITextField *wxTxt;

@end

@implementation ApplyViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.uploadCollectionHConstraint.constant = 120.0;
    self.uploadCollectionView.delegate = self;
    self.uploadCollectionView.dataSource = self;
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

#pragma mark - lazy load

- (NSMutableArray *)uploadedImageDataArray {
    if (!_uploadedImageDataArray) {
        _uploadedImageDataArray = [NSMutableArray array];
        [_uploadedImageDataArray addObject:[UIImage imageNamed:@"my_camera"]];
        //[_uploadedImageDataArray addObject:[UIImage imageNamed:@"my_photo"]];
    }
    return _uploadedImageDataArray;
}
#pragma mark - collection data source

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.uploadedImageDataArray.count;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UploadImageCollectionViewCell *ucell = [collectionView dequeueReusableCellWithReuseIdentifier:UploadImageCellID forIndexPath:indexPath];
    ucell.img.image = self.uploadedImageDataArray[indexPath.row];
    ucell.deleteBtn.hidden = (indexPath.row <= 0);
    __weak typeof(self) weakSelf = self;
    ucell.deleteBlock = ^(UploadImageCollectionViewCell *cell){
        __strong typeof(weakSelf) strongSelf = weakSelf;
        NSIndexPath *idx = [collectionView indexPathForCell:cell];
        [strongSelf.uploadedImageDataArray removeObjectAtIndex:idx.row];
        [strongSelf refreshUploadArea];
    };
    return ucell;
}

#pragma mark - collection view flow layout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(90, 100);
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsZero;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}

#pragma mark - collection delegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    
    PPLog(@"hello in ");
    if (indexPath.row == 0) {
        [self appearImageChooser:self.uploadedImageDataArray.count];
    }
}


#pragma mark - img choose

- (void)appearImageChooser:(NSUInteger)count {
    __weak typeof(self) weakSelf = self;
    SuPhotoPicker *picker = [[SuPhotoPicker alloc] init];
    [picker showInSender:self handle:^(NSArray<UIImage *> *photos) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if (photos.count > 0) {
            [strongSelf.uploadedImageDataArray addObjectsFromArray:photos];
            [strongSelf refreshUploadArea];
        }
        PPLog(@"%@",photos);
    }];
}

- (void)refreshUploadArea {
    [self.uploadCollectionView reloadData];
    self.uploadCollectionHConstraint.constant = self.uploadCollectionView.collectionViewLayout.collectionViewContentSize.height;
}

#pragma mark - action

- (IBAction)doClick:(id)sender {

    if ([self checkOK:self.nameTxt]
        && [self checkOK:self.phoneTxt]
        && [self checkOK:self.phoneTxt]
        && [self checkOK:self.iccardTxt]
        && [self checkOK:self.zfbTxt]
        && [self checkOK:self.wxTxt]) {
        
        if (self.uploadedImageDataArray.count > 2) {
            [WSMessageAlert showMessage:@"只能添加一张图片哦"];
            return ;
        }
        
       // api/agent/addAgent 添加代理人
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        [params setValue:self.nameTxt.text forKey:@"name"];
        [params setValue:self.iccardTxt.text forKey:@"idCard"];
        [params setValue:self.phoneTxt.text forKey:@"cellphone"];
        [params setValue:self.zfbTxt.text forKey:@"alipayAccount"];
        [params setValue:self.wxTxt.text forKey:@"weixinAccount"];
        
        CTURLModel *model = [CTURLModel initWithUrl:[BaseUrl stringByAppendingString:@"agent/addAgent"] params:params];
       __weak typeof(self) weakSelf = self;
        
        NSMutableArray *imgarr = [NSMutableArray array];

        for (NSInteger i = 1; i < self.uploadedImageDataArray.count; i ++) {
            [imgarr addObject:self.uploadedImageDataArray[i]];
        }
        
        [AFHttpUtil doPostBodyWithUrl:model imageArray:imgarr callback:^(BOOL isSuccessed, id result) {
            __strong typeof(weakSelf) strongSelf = weakSelf;
            if (isSuccessed) {
                NSString *jsonStr = [[NSString alloc] initWithData:result encoding:NSUTF8StringEncoding];
                NSDictionary *dic = [jsonStr JSONValue];
                if ([dic[@"errcode"] integerValue] == 0) {
                    [WSMessageAlert showMessage:@"成功啦！！！！"];
                    [strongSelf.navigationController popViewControllerAnimated:YES];
                } else {
                    [WSMessageAlert showMessage:@"Sorry,申请提交失败"];
                }
            }else {
                [WSMessageAlert showMessage:@"Sorry,申请提交失败"];
            }
        }];

    }
    /*
    SuccessViewController *success = [[UIStoryboard storyboardWithName:@"MyWS" bundle:nil] instantiateViewControllerWithIdentifier:@"successctl"];
    success.upLbl.text = @"您的申请成为代理请求已提交";
    [self.navigationController pushViewController:success animated:YES];
     */
}

- (BOOL)checkOK:(UITextField *)txt {
    if (txt.text.length == 0) {
        [WSMessageAlert showMessage:txt.placeholder];
        return NO;
    }
    return YES;
}

@end
