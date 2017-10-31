//
//  GXTalentController.m
//  LOL宝典
//
//  Created by siguoxi on 16/6/16.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import "GXTalentController.h"
#import "MBProgressHUD+MJ.h"

@interface GXTalentController ()<UIWebViewDelegate>
@property (nonatomic, strong) UIWebView *webView;

@end

@implementation GXTalentController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor wheatColor];
    // 添加webView
    UIWebView *webView = [[UIWebView alloc] init];
    webView.frame = self.view.bounds;
    webView.height -= 64;
    webView.delegate = self;
    webView.backgroundColor = [UIColor wheatColor];
    webView.scalesPageToFit = YES;
    [self.view addSubview:webView];
    self.webView = webView;
    NSURLRequest *requset = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://llbox.cn/loltfs6/index.htm"]];
    [self.webView loadRequest:requset];
}

#pragma mark - UIWebViewDelegate
/**
 *  UIWebView开始加载资源的时候调用
 */
- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [MBProgressHUD showMessage:@"正在努力加载中..."];
}
/**
 *  UIWebView加载完毕的时候调用
 */
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [MBProgressHUD hideHUD];
}
/**
 *  UIWebView加载失败的时候调用
 */
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [MBProgressHUD hideHUD];
}

@end
