//
//  GXWebController.m
//  LOL宝典
//
//  Created by siguoxi on 2017/8/2.
//  Copyright © 2017年 itcast. All rights reserved.
//

#import "GXWebController.h"
#import "GXMoviePlayerViewController.h"
#import <objc/runtime.h>
#import <objc/message.h>
#import <AVFoundation/AVFoundation.h>
#import "MBProgressHUD+MJ.h"

static NSString *const VideoHandlerScheme = @"videohandler";

@interface GXWebController ()<UIWebViewDelegate>
@property (nonatomic, strong)UIWebView *webView;
@property (nonatomic, retain) NSMutableURLRequest *request;
@property (nonatomic, assign) BOOL isPlaying;
@end

@implementation GXWebController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNavBar];
    [self initRequestWithUrl:self.url];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(startPlayVideo:)name:AVPlayerItemTimeJumpedNotification object:nil];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    self.isPlaying = NO;
}

- (void)startPlayVideo:(NSNotification *)note
{
    AVPlayerItem *playerItem = (AVPlayerItem *)note.object;
    AVURLAsset *asset = (AVURLAsset *)playerItem.asset;
    if (playerItem.status == AVPlayerItemStatusReadyToPlay && !self.isPlaying) {
        [self playVideoWithUrl:asset.URL.absoluteString];
    }
}

- (UIWebView *)webView
{
    if (_webView == nil) {
        _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, GXScreenWidth, GXScreenHeight - 64)];
        _webView.scalesPageToFit = YES;
        _webView.delegate = self;
        _webView.allowsInlineMediaPlayback = YES;
        [self.view addSubview:_webView];
    }
    return _webView;
}

- (void)initRequestWithUrl:(NSString *)url
{
    _request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
    [self.webView loadRequest:_request];
}

// 设置导航栏
- (void)setupNavBar
{
    self.title = @"自定义网页";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"dwbbs_left_navi_previous"] style:UIBarButtonItemStylePlain target:self action:@selector(goBack)];
}

- (void)goBack
{
    if ([self.webView canGoBack]) {
        [self.webView goBack];
    } else {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    NSLog(@"开始加载");
//    [MBProgressHUD showMessage:@"正在拼命加载中..."];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    NSLog(@"加载完成");
//    [MBProgressHUD hideHUD];
    NSString *title = [self.webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    self.title = title;
    NSString *jsPath =
    [[NSBundle mainBundle] pathForResource:@"videofullscreenhandler" ofType:@"js"];
    NSString *videoHandlerString = [NSString stringWithContentsOfFile:jsPath encoding:NSUTF8StringEncoding error:nil];
    if (videoHandlerString) {
        [webView stringByEvaluatingJavaScriptFromString:videoHandlerString];
    }
}

- (void)playVideoWithUrl:(NSString *)videoUrl
{
    self.isPlaying = YES;
    GXVideoInfo *videoInfo = [[GXVideoInfo alloc] init];
    GXMoviePlayerViewController *videoPlayVc = [[GXMoviePlayerViewController alloc] init];
    videoPlayVc.videoURL = [NSURL URLWithString:videoUrl];
    videoPlayVc.title = videoInfo.videoName;
    videoPlayVc.videoInfo = videoInfo;
    [self.navigationController pushViewController:videoPlayVc animated:YES];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    NSLog(@"加载失败");
//    [MBProgressHUD hideHUD];
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    NSLog(@"应该开始加载 调用JS");
    if ([request.URL.scheme isEqualToString:VideoHandlerScheme]) {
        NSLog(@"%@", request.URL);//こちらでイベントがフックできます。
        return NO;
    }
    
    return YES;
}

@end
