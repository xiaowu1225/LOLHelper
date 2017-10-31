//
//  GXCombatController.m
//  LOL宝典
//
//  Created by sgx on 14-8-6.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "GXCombatController.h"
#import "GXUser.h"
#import "MBProgressHUD+MJ.h"
#import "UIBarButtonItem+Extension.h"
#import <Social/Social.h>

@interface GXCombatController ()<UIWebViewDelegate>
@property (nonatomic, strong) UIWebView *webView;
@end

@implementation GXCombatController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor wheatColor];
    
    // 添加返回按钮
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImageName:@"dwbbs_left_navi_previous" highlightedImaheName:@"nil" target:self action:@selector(back)];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"战绩列表" style:UIBarButtonItemStylePlain target:self action:@selector(loadCombatInfoList)];
    
    // 添加webView
    UIWebView *webView = [[UIWebView alloc] init];
    webView.frame = self.view.bounds;
    webView.height -= 60;
    webView.delegate = self;
    webView.backgroundColor = [UIColor wheatColor];
    [self.view addSubview:webView];
    self.webView = webView;
    
    // 读取用户缓存信息
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    // 读取用户上次输入的账号信息
    if (!self.user) {
        self.user = [[GXUser alloc] init];
        self.user.serverName = [defaults objectForKey:GXServerName];
        self.user.playerName = [defaults objectForKey:GXPlayerName];
    }
    NSString *urlStr = [NSString stringWithFormat:@"http://lolbox.duowan.com/phone/playerDetail20.php?sn=%@&target=%@&sk=92628711T&v=204&from=mainTab&timestamp=1407658583467", self.user.serverName, self.user.playerName];
    NSURLRequest *requset = [NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]];
    [self.webView loadRequest:requset];
    
    // 添加刷新按钮
    UIButton *refresh = [[UIButton alloc] init];
    refresh.backgroundColor = [UIColor darkGrayColor];
    refresh.alpha = 0.5;
    refresh.layer.cornerRadius = 3;
    [refresh setImage:[UIImage imageNamed:@"hero_refresh"] forState:UIControlStateNormal];
    refresh.frame = CGRectMake(273, GXScreenHeight - 64 - 47, 42, 42);
    [refresh addTarget:self action:@selector(refresh) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:refresh];
    
    UIButton *share = [[UIButton alloc] init];
    share.backgroundColor = [UIColor darkGrayColor];
    share.alpha = 0.5;
    share.layer.cornerRadius = 3;
    [share setImage:[UIImage imageNamed:@"shareviewhead_icon"] forState:UIControlStateNormal];
    share.frame = CGRectMake(273, 10, 42, 42);
    [share addTarget:self action:@selector(share) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:share];
}
/**
 *  加载战斗力列表信息
 */
- (void)loadCombatInfoList
{
    // 读取用户缓存信息
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    // 读取用户上次输入的账号信息
    GXUser *user = [[GXUser alloc] init];
    user.serverName = [defaults objectForKey:GXServerName];
    user.playerName = [defaults objectForKey:GXPlayerName];
    NSString *urlStr = [NSString stringWithFormat:@"http://lolbox.duowan.com/phone/matchList20.php?serverName=%@&playerName=%@&v=204&hero=&timestamp=1407657364", user.serverName, user.playerName];
    NSURLRequest *requset = [NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]];
    [self.webView loadRequest:requset];
}
/**
 *  刷新
 */
- (void)refresh
{
    // 读取用户缓存信息
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    // 读取用户上次输入的账号信息
    GXUser *user = [[GXUser alloc] init];
    user.serverName = [defaults objectForKey:GXServerName];
    user.playerName = [defaults objectForKey:GXPlayerName];
    self.user = user;
}
/**
 *  分享
 */
- (void)share
{
    // 1.开启图形上下文
    CGSize imageSize = self.webView.bounds.size;
    UIGraphicsBeginImageContextWithOptions(imageSize, NO, 0.0);
    
    // 2.将某个view的所有内容渲染到图形上下文中
    CGContextRef context = UIGraphicsGetCurrentContext();
    [self.webView.layer renderInContext:context];
    
    // 3.取得图片
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    CGImageRef subimageRef = CGImageCreateWithImageInRect(image.CGImage, CGRectMake(0, 0, 2 * self.webView.width, 2 * self.webView.height));
    UIImage *subImage = [UIImage imageWithCGImage:subimageRef];
    
    // 4.关闭上下文
    UIGraphicsEndImageContext();
    
    // 新浪微博服务不可用
    if (![SLComposeViewController isAvailableForServiceType:SLServiceTypeSinaWeibo]) return;
    
    // 1.创建分享控制器
    SLComposeViewController *cvv = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeSinaWeibo];
    // 设置初始化数据
    [cvv setInitialText:@"晒一下战斗力，快来围观吧！ 分享自@随缘78223"];
    [cvv addImage:subImage];
    
    // 2.显示控制器
    [self presentViewController:cvv animated:YES completion:nil];
    
    // 3.设置block监听
    cvv.completionHandler = ^(SLComposeViewControllerResult result){
        if (result == SLComposeViewControllerResultCancelled) {
            GXLog(@"取消发送");
        } else {
            GXLog(@"发送完毕");
        }
    };

}

/**
 *  回退
 */
- (void)back
{
    if ([self.webView canGoBack]) {
        [self.webView goBack];
    } else {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

//- (void)setUser:(GXUser *)user
//{
//    _user = user;
//    NSString *urlStr = [NSString stringWithFormat:@"http://lolbox.duowan.com/phone/playerDetail20.php?sn=%@&target=%@&sk=92628711T&v=204&from=mainTab&timestamp=1407658583467", _user.serverName, _user.playerName];
//    NSString *uri = [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//    NSURL *url = [NSURL URLWithString:uri];
//    NSURLRequest *requset = [NSURLRequest requestWithURL:url];
//    [self.webView loadRequest:requset];
//}

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
