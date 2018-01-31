//
//  BaseController.h
//  ChooseArea
//
//  Created by 朱帅 on 2016/10/25.
//  Copyright © 2016年 zhushuai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CityModel.h"
#import "AreaModel.h"

@interface CityPickerController : UIViewController

@property(nonatomic, copy) void(^chooseCityBlock)(CityModel *m,AreaModel *a);

@end
