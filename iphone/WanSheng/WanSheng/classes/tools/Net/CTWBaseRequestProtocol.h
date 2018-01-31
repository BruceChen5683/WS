//
//  CTWBaseRequestProtocol.h
//  CTWDriver
//
//  Created by mao on 2017/6/8.
//  Copyright © 2017年 changtu. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^DataPrepareCallbackBlock)(NSURLSessionTask *sessionTask);

typedef void(^ResponseCallbackBlock)(NSURLSessionTask *sessionTask);

@protocol CTWBaseRequestProtocol <NSObject>



@end
