//
//  PPNetworkHelper.m
//  PPNetworkHelper
//
//  Created by AndyPang on 16/8/12.
//  Copyright © 2016年 AndyPang. All rights reserved.
//


#import "PPNetworkHelper.h"
#import "AFNetworking.h"
#import "AFNetworkActivityIndicatorManager.h"
#import "CTAssembleRequest.h"
#import "CTAssembleResponse.h"
#import "CTAssembleRequest+PPAdd.h"
#import "PPNetErrorCodeHandle.h"

#define NSStringFormat(format,...) [NSString stringWithFormat:format,##__VA_ARGS__]

@implementation PPNetworkHelper

static NSMutableArray *_allSessionTask;
static AFHTTPSessionManager *_sessionManager;

#pragma mark - 开始监听网络
+ (void)networkStatusWithBlock:(PPNetworkStatus)networkStatus {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{

        [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
            switch (status) {
                case AFNetworkReachabilityStatusUnknown:
                    networkStatus ? networkStatus(PPNetworkStatusUnknown) : nil;
                    PPLog(@"未知网络");
                    break;
                case AFNetworkReachabilityStatusNotReachable:
                    networkStatus ? networkStatus(PPNetworkStatusNotReachable) : nil;
                    PPLog(@"无网络");
                    break;
                case AFNetworkReachabilityStatusReachableViaWWAN:
                    networkStatus ? networkStatus(PPNetworkStatusReachableViaWWAN) : nil;
                    PPLog(@"手机自带网络");
                    break;
                case AFNetworkReachabilityStatusReachableViaWiFi:
                    networkStatus ? networkStatus(PPNetworkStatusReachableViaWiFi) : nil;
                    PPLog(@"WIFI");
                    break;
            }
        }];
    });
}

+ (BOOL)isNetwork {
    return [AFNetworkReachabilityManager sharedManager].reachable;
}

+ (BOOL)isWWANNetwork {
    return [AFNetworkReachabilityManager sharedManager].reachableViaWWAN;
}

+ (BOOL)isWiFiNetwork {
    return [AFNetworkReachabilityManager sharedManager].reachableViaWiFi;
}


+ (void)cancelAllRequest {
    // 锁操作
    @synchronized(self) {
        [[self allSessionTask] enumerateObjectsUsingBlock:^(NSURLSessionTask  *_Nonnull task, NSUInteger idx, BOOL * _Nonnull stop) {
            [task cancel];
        }];
        [[self allSessionTask] removeAllObjects];
    }
}

+ (void)cancelRequestWithURL:(NSString *)URL {
    if (!URL) { return; }
    @synchronized (self) {
        [[self allSessionTask] enumerateObjectsUsingBlock:^(NSURLSessionTask  *_Nonnull task, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([task.currentRequest.URL.absoluteString hasPrefix:URL]) {
                [task cancel];
                [[self allSessionTask] removeObject:task];
                *stop = YES;
            }
        }];
    }
}

#pragma mark - GET请求无缓存
+ (NSURLSessionTask *)GET:(CTURLModel *)urlM
                  success:(PPHttpRequestSuccess)success
                  failure:(PPHttpRequestFailed)failure {
    return [self GET:urlM responseCache:nil success:success failure:failure];
}

#pragma mark - POST请求无缓存
+ (NSURLSessionTask *)POST:(CTURLModel *)urlM
                   success:(PPHttpRequestSuccess)success
                   failure:(PPHttpRequestFailed)failure {
    
    return [self POST:urlM responseCache:nil success:success failure:failure];
}
#pragma mark - GET请求自动缓存
+ (NSURLSessionTask *)GET:(CTURLModel *)urlM
            responseCache:(PPHttpRequestCache)responseCache
                  success:(PPHttpRequestSuccess)success
                  failure:(PPHttpRequestFailed)failure {
    //读取缓存
    responseCache!=nil ? responseCache([PPNetworkCache httpCacheForURL:urlM.url parameters:urlM.params]) : nil;
    NSMutableURLRequest *urlReq = [CTAssembleRequest ctRequest:urlM method:@"GET"];
    NSURLSessionTask *sessionTask = [_sessionManager dataTaskWithRequest:urlReq
                                                          uploadProgress:^(NSProgress * _Nonnull uploadProgress) {
                                                          }
                                                        downloadProgress:^(NSProgress * _Nonnull downloadProgress) {
                                                        } completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
                                                            
                                                            if (!error) {
                                                                PPLog(@"%@ responseObject = %@",urlM.description ,[self jsonToString:responseObject]);
                                                                NSDictionary *dic = [CTAssembleRequest praseResponse:urlReq.urlM data:responseObject];
                                                                [[self allSessionTask] removeObject:sessionTask];
                                                                success ? success(dic) : nil;
                                                                //对数据进行异步缓存
                                                                responseCache!=nil ? [PPNetworkCache setHttpCache:responseObject URL:urlM.url parameters:urlM.params] : nil;
                                                            }
                                                            else {
                                                                PPLog(@"error = %@",error);
                                                                    //NSInteger errorCode = [PPNetErrorCodeHandle returnErrorCode:error];
                                                                    [PPNetErrorCodeHandle handleError:error finBlock:^{
                                                                        failure ? failure(error) : nil;
                                                                    }];
                                                                }
                                                        }];
    
    [sessionTask resume];

    // 添加sessionTask到数组
    sessionTask ? [[self allSessionTask] addObject:sessionTask] : nil ;
    
    return sessionTask;
}

#pragma mark - POST请求自动缓存
+ (NSURLSessionTask *)POST:(CTURLModel *)urlM
             responseCache:(PPHttpRequestCache)responseCache
                   success:(PPHttpRequestSuccess)success
                   failure:(PPHttpRequestFailed)failure {
    //读取缓存
    responseCache!=nil ? responseCache([PPNetworkCache httpCacheForURL:urlM.url parameters:urlM.params]) : nil;
    NSMutableURLRequest *urlReq = [CTAssembleRequest ctRequest:urlM method:@"POST"];
    
    NSURLSessionTask *sessionTask = nil;
    sessionTask = [_sessionManager dataTaskWithRequest:urlReq
                                                          uploadProgress:^(NSProgress * _Nonnull uploadProgress) {
                                                          }
                                                        downloadProgress:^(NSProgress * _Nonnull downloadProgress) {
                                                        } completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
                                                            
                                                            if (!error) {
                                                                NSDictionary *dic = [CTAssembleRequest praseResponse:urlReq.urlM data:responseObject];
                                                                PPLog(@"request = %@ \n response dict = %@",urlM.description, dic);
                                                                [[self allSessionTask] removeObject:sessionTask];
                                                                success ? success(dic) : nil;
                                                                //对数据进行异步缓存
                                                                responseCache!=nil ? [PPNetworkCache setHttpCache:responseObject URL:urlM.url parameters:urlM.params] : nil;
                                                            }
                                                            else {
                                                                PPLog(@"error = %@",error);
//                                                                [[self allSessionTask] removeObject:sessionTask];
                                                                    //NSInteger errorCode = [PPNetErrorCodeHandle returnErrorCode:error];
                                                                    [PPNetErrorCodeHandle handleError:error finBlock:^{
                                                                        failure ? failure(error) : nil;
                                                                    }];
                                                                }
                                                        }];

    [sessionTask resume];
    // 添加最新的sessionTask到数组
    sessionTask ? [[self allSessionTask] addObject:sessionTask] : nil ;
    return sessionTask;
}

#pragma mark - 上传文件
+ (NSURLSessionTask *)uploadFileWithURL:(CTURLModel *)urlM
                                   name:(NSString *)name
                               filePath:(NSString *)filePath
                               progress:(PPHttpProgress)progress
                                success:(PPHttpRequestSuccess)success
                                failure:(PPHttpRequestFailed)failure {

    NSURLSessionTask *sessionTask = [_sessionManager POST:urlM.url parameters:urlM.params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        NSError *error = nil;
        [formData appendPartWithFileURL:[NSURL URLWithString:filePath] name:name error:&error];
        (failure && error) ? failure(error) : nil;
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        //上传进度
        dispatch_sync(dispatch_get_main_queue(), ^{
            progress ? progress(uploadProgress) : nil;
        });
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        PPLog(@"responseObject = %@",[self jsonToString:responseObject]);
        [[self allSessionTask] removeObject:task];
        success ? success(responseObject) : nil;
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
       PPLog(@"error = %@",error);
        [[self allSessionTask] removeObject:task];
        failure ? failure(error) : nil;
    }];
        // 添加sessionTask到数组
    sessionTask ? [[self allSessionTask] addObject:sessionTask] : nil ;
    
    return sessionTask;
}

#pragma mark - 上传多张图片
+ (NSURLSessionTask *)uploadImagesWithURL:(CTURLModel *)urlM
                                     name:(NSString *)name
                                   images:(NSArray<UIImage *> *)images
                                fileNames:(NSArray<NSString *> *)fileNames
                               imageScale:(CGFloat)imageScale
                                imageType:(NSString *)imageType
                                 progress:(PPHttpProgress)progress
                                  success:(PPHttpRequestSuccess)success
                                  failure:(PPHttpRequestFailed)failure {
    NSURLSessionTask *sessionTask = [_sessionManager POST:urlM.url parameters:urlM.params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        for (NSUInteger i = 0; i < images.count; i++) {
            // 图片经过等比压缩后得到的二进制文件
            NSData *imageData = UIImageJPEGRepresentation(images[i], imageScale ?: 1.f);
            // 默认图片的文件名, 若fileNames为nil就使用
           
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            formatter.dateFormat = @"yyyyMMddHHmmss";
            NSString *str = [formatter stringFromDate:[NSDate date]];
            NSString *imageFileName = NSStringFormat(@"%@%ld.%@",str,i,imageType?:@"jpg");
       
            [formData appendPartWithFileData:imageData
                                        name:name
                                    fileName:fileNames ? NSStringFormat(@"%@.%@",fileNames[i],imageType?:@"jpg") : imageFileName
                                    mimeType:NSStringFormat(@"image/%@",imageType ?: @"jpg")];
        }
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        //上传进度
        dispatch_sync(dispatch_get_main_queue(), ^{
            progress ? progress(uploadProgress) : nil;
        });
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        PPLog(@"responseObject = %@",[self jsonToString:responseObject]);
        [[self allSessionTask] removeObject:task];
        NSDictionary *dic = [CTAssembleRequest praseResponse:urlM data:responseObject];
        success ? success(dic) : nil;
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        PPLog(@"error = %@",error);
        [[self allSessionTask] removeObject:task];
        failure ? failure(error) : nil;
    }];
    
    // 添加sessionTask到数组
    sessionTask ? [[self allSessionTask] addObject:sessionTask] : nil ;
    
    return sessionTask;
}

#pragma mark - 表单提交

+ (void)formRequestWithURL:(CTURLModel *)urlM
                   success:(PPHttpRequestSuccess)success
                   failure:(PPHttpRequestFailed)failure {

    
}

#pragma mark - 下载文件
+ (NSURLSessionTask *)downloadWithURL:(CTURLModel *)urlM
                              fileDir:(NSString *)fileDir
                             progress:(PPHttpProgress)progress
                              success:(void(^)(NSString *))success
                              failure:(PPHttpRequestFailed)failure {
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlM.url]];
    __block NSURLSessionDownloadTask *downloadTask = [_sessionManager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        //下载进度
        dispatch_sync(dispatch_get_main_queue(), ^{
            progress ? progress(downloadProgress) : nil;
        });
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        //拼接缓存目录
        NSString *downloadDir = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:fileDir ? fileDir : @"Download"];
        //打开文件管理器
        NSFileManager *fileManager = [NSFileManager defaultManager];
        //创建Download目录
        [fileManager createDirectoryAtPath:downloadDir withIntermediateDirectories:YES attributes:nil error:nil];
        //拼接文件路径
        NSString *filePath = [downloadDir stringByAppendingPathComponent:response.suggestedFilename];
        //返回文件位置的URL路径
        return [NSURL fileURLWithPath:filePath];
        
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        
        [[self allSessionTask] removeObject:downloadTask];
        if(failure && error) {failure(error) ; return ;};
        success ? success(filePath.absoluteString /** NSURL->NSString*/) : nil;
        
    }];
    //开始下载
    [downloadTask resume];
    // 添加sessionTask到数组
    downloadTask ? [[self allSessionTask] addObject:downloadTask] : nil ;
    
    return downloadTask;
}

/**
 *  json转字符串
 */
+ (NSString *)jsonToString:(id)data {
    if(data == nil) { return nil; }
    return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
}

/**
 存储着所有的请求task数组
 */
+ (NSMutableArray *)allSessionTask {
    if (!_allSessionTask) {
        _allSessionTask = [[NSMutableArray alloc] init];
    }
    return _allSessionTask;
}

#pragma mark - 初始化AFHTTPSessionManager相关属性
/**
 开始监测网络状态
 */
+ (void)load {
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
}
/**
 *  所有的HTTP请求共享一个AFHTTPSessionManager
 *  原理参考地址:http://www.jianshu.com/p/5969bbb4af9f
 */
+ (void)initialize {
    _sessionManager = [AFHTTPSessionManager manager];
    _sessionManager.requestSerializer = [CTAssembleRequest reqJsonSerializer];
    _sessionManager.responseSerializer = [CTAssembleResponse responseHttpSerializer];
    [self setNoSecurityPolicy];
    // 打开状态栏的等待菊花
    [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
}

#pragma mark - 重置AFHTTPSessionManager相关属性

+ (void)setAFHTTPSessionManagerProperty:(void (^)(AFHTTPSessionManager *))sessionManager {
    sessionManager ? sessionManager(_sessionManager) : nil;
}

+ (void)setRequestSerializer:(PPRequestSerializer)requestSerializer {
    _sessionManager.requestSerializer = requestSerializer==PPRequestSerializerHTTP ? [CTAssembleRequest reqHttpSerializer] : [CTAssembleRequest reqJsonSerializer];
}

+ (void)setResponseSerializer:(PPResponseSerializer)responseSerializer {
    _sessionManager.responseSerializer = responseSerializer==PPResponseSerializerHTTP ? [CTAssembleResponse responseHttpSerializer] : [CTAssembleResponse responseJsonSerializer];
}

+ (void)setRequestTimeoutInterval:(NSTimeInterval)time {
    _sessionManager.requestSerializer.timeoutInterval = time;
}

+ (void)setValue:(NSString *)value forHTTPHeaderField:(NSString *)field {
    [_sessionManager.requestSerializer setValue:value forHTTPHeaderField:field];
}

+ (void)openNetworkActivityIndicator:(BOOL)open {
    [[AFNetworkActivityIndicatorManager sharedManager] setEnabled:open];
}

+ (void)setSecurityPolicyWithCerPath:(NSString *)cerPath validatesDomainName:(BOOL)validatesDomainName {
    NSData *cerData = [NSData dataWithContentsOfFile:cerPath];
    // 使用证书验证模式
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate];
    // 如果需要验证自建证书(无效证书)，需要设置为YES
    securityPolicy.allowInvalidCertificates = YES;
    // 是否需要验证域名，默认为YES;
    securityPolicy.validatesDomainName = validatesDomainName;
    securityPolicy.pinnedCertificates = [[NSSet alloc] initWithObjects:cerData, nil];
    
    [_sessionManager setSecurityPolicy:securityPolicy];
}

+ (void)setNoSecurityPolicy {
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    securityPolicy.allowInvalidCertificates = YES;
    [_sessionManager.securityPolicy setValidatesDomainName:NO];
}

@end


#pragma mark - NSDictionary,NSArray的分类
/*
 ************************************************************************************
 *新建NSDictionary与NSArray的分类, 控制台打印json数据中的中文
 ************************************************************************************
 */

#ifdef DEBUG
@implementation NSArray (PP)

- (NSString *)descriptionWithLocale:(id)locale {
    NSMutableString *strM = [NSMutableString stringWithString:@"(\n"];
    [self enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [strM appendFormat:@"\t%@,\n", obj];
    }];
    [strM appendString:@")"];
    
    return strM;
}

@end

@implementation NSDictionary (PP)

- (NSString *)descriptionWithLocale:(id)locale {
    NSMutableString *strM = [NSMutableString stringWithString:@"{\n"];
    [self enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        [strM appendFormat:@"\t%@ = %@;\n", key, obj];
    }];
    
    [strM appendString:@"}\n"];
    
    return strM;
}
@end
#endif

