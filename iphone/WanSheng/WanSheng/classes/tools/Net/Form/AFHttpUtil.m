//
//  AFHttpUtil.m
//  ECarWash
//
//  Created by 李文龙 on 14/11/11.
//  Copyright (c) 2014年 李文龙. All rights reserved.
//

#import "AFHttpUtil.h"
#import "NSString+ITTAdditions.h"
#import <AFNetworking/AFHTTPSessionManager.h>
#import <AFNetworking/AFURLRequestSerialization.h>
#import "ITTAFQueryStringPair.h"

@implementation AFHttpUtil

+ (void)doGetWithUrl:(CTURLModel *)model callback:(AFHttpCallback) callback {
    
    [[AFHTTPSessionManager manager] GET:model.url parameters:model.params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (responseObject)
        {
            callback(YES, responseObject);
        }
        else
        {
            callback(NO, nil);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        callback(NO, error);

    }];

}


+ (void)doPostWithUrl:(CTURLModel *)model callback:(AFHttpCallback)callback {
    
    //实例话对象
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer.timeoutInterval = 20;
    manager.responseSerializer = [[AFHTTPResponseSerializer alloc] init];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    
    //在请求头里 添加自己需要的参数
    //[manager.requestSerializer setValue:token forHTTPHeaderField:@"id"];

    [manager POST:model.url parameters:model.params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
        
    }  success:^(NSURLSessionDataTask *task, id responseObject) {
       // PPLog(@"responseObject == %@--++--%@----", [self getResponseObjcWithTask:responseObject],[self getRespodHeaderWithTask:task]);
        
       // if ([[self getRespodHeaderWithTask:task][@"Status"] isEqualToString:@"1"]) {
            //成功
       // }else{
            PPLog(@"成功");
            callback(YES, responseObject);
       // }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        callback(NO, error);
    }];
    /*
    NSStringEncoding stringEncoding = NSUTF8StringEncoding;
    NSString *paramString = ITTAFQueryStringFromParametersWithEncoding(model.params, stringEncoding);
    NSString *contentType = @"application/x-www-form-urlencoded; charset=utf-8";
    NSURL *URL = [NSURL URLWithString:model.url];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:URL];
    [request setValue:contentType forHTTPHeaderField:@"Content-Type"];
    NSData * formFormatPostData = [paramString dataUsingEncoding:NSUTF8StringEncoding];
    [request setHTTPBody:formFormatPostData];
    [request setHTTPMethod:@"POST"];
    */
    /*
    [[AFHTTPSessionManager manager] POST:model.url parameters:model.params progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        callback(YES, responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        callback(NO, error);
    }];
*/
}

//** 获取响应头 */
/*
+ (id)getRespodHeaderWithTask:(NSURLSessionTask *)task
{
    NSHTTPURLResponse *respond = (NSHTTPURLResponse *)task.response;
    return respond.allHeaderFields;
}
+ (id)getResponseObjcWithTask:(id )responseObect{
    id json;
    NSError *error;
    json = [NSJSONSerialization JSONObjectWithData:responseObect options:0 error:&error];
    if (error) {
        json = [[NSString alloc] initWithData:responseObect encoding:NSUTF8StringEncoding];
    }
    return json;
}
*/

+ (void)doPostBodyWithUrl:(CTURLModel *)model imageArray:(NSArray<UIImage *>*)imageArray callback:(AFHttpCallback)callback {
    
    //实例话对象
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer.timeoutInterval = 20;
    manager.responseSerializer = [[AFHTTPResponseSerializer alloc] init];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    
    //在请求头里 添加自己需要的参数
    //[manager.requestSerializer setValue:token forHTTPHeaderField:@"id"];
    
    [manager POST:model.url parameters:model.params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
       
        for (UIImage *img in imageArray) {
            NSData *data = UIImagePNGRepresentation(img);
            //这个就是参数
            [formData appendPartWithFileData:data name:@"image" fileName:@"image.png" mimeType:@"image/png"];
        }
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
        
    }  success:^(NSURLSessionDataTask *task, id responseObject) {
        
        // PPLog(@"responseObject == %@--++--%@----", [self getResponseObjcWithTask:responseObject],[self getRespodHeaderWithTask:task]);
        
        // if ([[self getRespodHeaderWithTask:task][@"Status"] isEqualToString:@"1"]) {
        //成功
        // }else{
        PPLog(@"成功");
        callback(YES, responseObject);
        // }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        callback(NO, error);
    }];
   
}

@end
