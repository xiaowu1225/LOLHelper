//
//  GXShakeController.m
//  LOL宝典
//
//  Created by sgx on 14-8-10.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "GXShakeController.h"
#import "GXShakeView.h"
#import "GXCurrentCombatController.h"
#import "HMAudioTool.h"
#import "GXShakeTool.h"
#import "GXShakeResult.h"
#import "GXShakeHeroInfo.h"
#import "GXUser.h"
#import "MBProgressHUD+MJ.h"

@interface GXShakeController ()<GXShakeViewDelegate>
@property (nonatomic, strong) UIButton *voiceBtn;
@end

@implementation GXShakeController

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
    
    self.view.backgroundColor = [UIColor wheatColor];
    self.title = @"摇一摇";
    
    GXShakeView *shakeView = [[[NSBundle mainBundle] loadNibNamed:@"ShakeView" owner:nil options:nil] firstObject];
    shakeView.delegate = self;
    shakeView.backgroundColor = [UIColor wheatColor];
    [self.view addSubview:shakeView];
}

/**
 *  摇一摇
 */
- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    [self shakeBtnClick];
}

- (void)voiceBtnClick:(UIButton *)button
{
    button.selected = !button.selected;
    self.voiceBtn = button;
}

- (void)shockBtnClick:(UIButton *)button
{
    button.selected = !button.selected;
}

- (void)shakeBtnClick
{
    if (!self.voiceBtn.selected) {
        [HMAudioTool playSound:@"shake.mp3"];
    }
    
    // 读取用户缓存信息
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    // 读取用户上次输入的账号信息
    GXUser *user = [[GXUser alloc] init];
    user.serverName = [defaults objectForKey:GXServerName];
    user.playerName = [defaults objectForKey:GXPlayerName];
    
    [MBProgressHUD showMessage:@"正在努力加载中..."];
    [GXShakeTool loadCurrentCombatInfoWithUser:user success:^(GXShakeResult *result) {
        [MBProgressHUD hideHUD];
        if (!self.voiceBtn.selected) {
            [HMAudioTool playSound:@"garen.mp3"];
        }
        if (result == nil) {
            [MBProgressHUD showMessage:@"没有进行中的比赛!"];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [MBProgressHUD hideHUD];
            });
            return ;
        }
        GXCurrentCombatController *currentVc = [[GXCurrentCombatController alloc] init];
        currentVc.shakeResult = result;
        currentVc.title = @"摇一摇";
        [self.navigationController pushViewController:currentVc animated:YES];
    } failure:^(NSError *error) {
        [MBProgressHUD hideHUD];
        [MBProgressHUD showError:@"加载失败，请检查网络"];
    }];
    
}


@end
