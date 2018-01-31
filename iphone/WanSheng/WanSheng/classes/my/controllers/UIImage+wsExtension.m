//
//  UIImage+wsExtension.m
//  WanSheng
//
//  Created by mao on 2018/1/17.
//  Copyright © 2018年 mao. All rights reserved.
//

#import "UIImage+wsExtension.h"
#import <objc/runtime.h>

#define ASS_KEY_1 @"ass_key__7"
#define ASSIMG_KEY_1 @"ass_key__6"


@implementation UIImage (wsExtension)
@dynamic randomNum;
@dynamic imgNameFromServer;

- (void)setRandomNum:(NSNumber *)randomNum {
    
    objc_setAssociatedObject(self, (const void *)CFBridgingRetain(ASS_KEY_1), randomNum, OBJC_ASSOCIATION_COPY);

}

- (NSNumber *)randomNum {
    return objc_getAssociatedObject(self, (const void *)CFBridgingRetain(ASS_KEY_1));
}

- (void)setImgNameFromServer:(NSString *)imgNameFromServer {
    objc_setAssociatedObject(self, (const void *)CFBridgingRetain(ASSIMG_KEY_1), imgNameFromServer, OBJC_ASSOCIATION_COPY);

}

- (NSString *)imgNameFromServer {
    return objc_getAssociatedObject(self, (const void *)CFBridgingRetain(ASSIMG_KEY_1));

}

@end
