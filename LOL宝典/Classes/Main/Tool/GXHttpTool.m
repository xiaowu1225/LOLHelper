//
//  GXHttpTool.m
//  新浪微博
//
//  Created by sgx on 14-7-11.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "GXHttpTool.h"
#import "MBProgressHUD+MJ.h"

@implementation GXHttpTool

+ (void)GET:(NSString *)url parameters:(NSDictionary *)params success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    // 1.获得请求管理者
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    mgr.responseSerializer.acceptableContentTypes = [mgr.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    mgr.responseSerializer.acceptableContentTypes = [mgr.responseSerializer.acceptableContentTypes setByAddingObject:@"text/plain"];
    // 2.没有网络加载缓存
    if ([GXService isConnectionAvailable] == NO) {
        [MBProgressHUD hideHUD];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [MBProgressHUD showError:@"网络异常，请检查网络环境"];
        });
        id responseObject = [[NSUserDefaults standardUserDefaults] objectForKey:url];
        if (responseObject) {
            success(responseObject);
        }
        return ;
    }
    // 3.发送请求
    [mgr GET:url parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        id newObject = [GXService processDictionaryIsNSNull:responseObject];
        [[NSUserDefaults standardUserDefaults] setObject:newObject forKey:url];
        [[NSUserDefaults standardUserDefaults] synchronize];
        success(newObject);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        failure(error);
    }];
}

+ (void)POST:(NSString *)url parameters:(NSDictionary *)params success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    // 1.获得请求管理者
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    // 2.没有网络加载缓存
    if ([GXService isConnectionAvailable] == NO) {
        [MBProgressHUD hideHUD];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [MBProgressHUD showError:@"网络异常，请检查网络环境"];
        });
        id responseObject = [[NSUserDefaults standardUserDefaults] objectForKey:url];
        if (responseObject) {
            success(responseObject);
        }
        return ;
    }
    // 3.发送请求
    [mgr POST:url parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        id newObject = [GXService processDictionaryIsNSNull:responseObject];
        [[NSUserDefaults standardUserDefaults] setObject:newObject forKey:url];
        [[NSUserDefaults standardUserDefaults] synchronize];
        success(newObject);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        failure(error);
    }];
}

+ (void)POST:(NSString *)url parameters:(NSDictionary *)params constructingBodyWithBlock:(void (^)(id<AFMultipartFormData>))block success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    // 1.获得请求管理者
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    // 2.没有网络加载缓存
    if ([GXService isConnectionAvailable] == NO) {
        [MBProgressHUD hideHUD];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [MBProgressHUD showError:@"网络异常，请检查网络环境"];
        });
        id responseObject = [[NSUserDefaults standardUserDefaults] objectForKey:url];
        if (responseObject) {
            success(responseObject);
        }
        return ;
    }
    // 3.发送请求
    [mgr POST:url parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        block(formData);
    } success:^(NSURLSessionDataTask *task, id responseObject) {
        id newObject = [GXService processDictionaryIsNSNull:responseObject];
        [[NSUserDefaults standardUserDefaults] setObject:newObject forKey:url];
        [[NSUserDefaults standardUserDefaults] synchronize];
        success(newObject);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        failure(error);
    }];
}
@end
