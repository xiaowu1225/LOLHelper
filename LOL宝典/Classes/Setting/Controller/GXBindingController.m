//
//  GXBindingController.m
//  LOL宝典
//
//  Created by sgx on 14-8-9.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "GXBindingController.h"
#import "GXButton.h"
#import "GXServeInfo.h"
#import "MJExtension.h"
#import "GXCombatController.h"
#import "GXUser.h"

@interface GXBindingController ()<UIPickerViewDataSource, UIPickerViewDelegate>
@property (nonatomic, weak) UIImageView *container;
@property (nonatomic, weak) UIButton *cover;
@property (nonatomic, weak) UIButton *cloud;
@property (nonatomic, weak) UITextField *pnField;
@property (nonatomic, weak) UIButton *snBtn;
@property (nonatomic, strong) NSArray *servers;
@property (nonatomic, weak) UIPickerView *serverList;
@property (nonatomic, weak) UIView *headView;
@end

@implementation GXBindingController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (NSArray *)servers
{
    if (_servers == nil) {
        _servers = [GXServeInfo objectArrayWithFilename:@"ServeList.plist"];
    }
    return _servers;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor wheatColor];
    
    // 1.添加图片
    UIImageView *titleImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bindLogo"]];
    titleImage.x = 35;
    titleImage.y = 20;
    [self.view addSubview:titleImage];
    
    // 2.添加选择框
    UIImageView *container = [[UIImageView alloc] init];
    container.userInteractionEnabled = YES;
    CGFloat margin = 10;
    CGFloat containerX = margin;
    CGFloat containerY = CGRectGetMaxY(titleImage.frame) + margin * 2;
    CGFloat containerW = 300;
    CGFloat containerH = 150;
    container.frame = CGRectMake(containerX, containerY, containerW, containerH);
    container.image = [UIImage resizedImage:@"hero_info_bg"];
    [self.view addSubview:container];
    self.container = container;
    [self setupContainer];
    
    // 3.创建遮盖
    UIButton *cloud = [[UIButton alloc] init];
    cloud.backgroundColor = [UIColor wheatColor];
    cloud.alpha = 0.8;
    cloud.hidden = YES;
    cloud.frame = self.view.bounds;
    [cloud addTarget:self action:@selector(cloudDidClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:cloud];
    self.cloud = cloud;
    
    // 4.添加tableview
    UIPickerView *serverList = [[UIPickerView alloc] init];
    serverList.frame = CGRectMake(10, 100, 300, 380);
    serverList.hidden = YES;
    serverList.dataSource = self;
    serverList.delegate = self;
    [self.view addSubview:serverList];
    self.serverList = serverList;
    
    // 5.设置tableview的头部视图
    self.headView = [[[NSBundle mainBundle] loadNibNamed:@"GXHeaderView" owner:nil options:nil] lastObject];
    
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    // 1.显示键盘
    [center addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    // 2.隐藏键盘
    [center addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

/**
 *  键盘即将显示
 */
- (void)keyboardWillShow:(NSNotification *)notification
{
    // 1.获取键盘弹出时间（注意只有第一次有）
    CGFloat duration = [notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue];
    if (duration <= 0) {
        duration = 0.25;
    }
    
    // 2.获取键盘的Y值
    NSValue *value = notification.userInfo[UIKeyboardFrameEndUserInfoKey];
    CGRect rect = [value CGRectValue];
    [UIView animateWithDuration:duration animations:^{
        // 计算需要移动的距离
        CGFloat y = rect.origin.y - CGRectGetMaxY(self.container.frame) - 70;
        self.view.transform = CGAffineTransformMakeTranslation(0, y);
    }];
    
    // 3.添加一个朦板
    if (!self.cover) {
        UIButton *cover = [[UIButton alloc] init];
        cover.frame = CGRectMake(0, 0, GXScreenWidth, GXScreenHeight);
        cover.backgroundColor = [UIColor clearColor];
        [cover addTarget:self action:@selector(coverClick) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:cover];
        self.cover = cover;
    }
}
/**
 *  点击朦板
 */
- (void)coverClick
{
    // 删除朦板
    [self.cover removeFromSuperview];
    // 退出键盘
    [self.view endEditing:YES];
}

- (void)keyboardWillHide:(NSNotification *)notification
{
    //    1.获取键盘弹出时间
    CGFloat duration = [notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue];
    //    2.恢复所有形变
    [UIView animateWithDuration:duration animations:^{
        self.view.transform = CGAffineTransformIdentity;
    }];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)setupContainer
{
    CGFloat margin = 5;
    UILabel *pnLabel = [[UILabel alloc] init];
    pnLabel.text = @"召唤师名称";
    pnLabel.font = [UIFont systemFontOfSize:11];
    pnLabel.textColor = [UIColor darkGrayColor];
    CGFloat pnX = margin;
    CGFloat pnY = margin;
    CGSize pnSize = [pnLabel.text sizeWithFont:pnLabel.font maxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    pnLabel.frame = CGRectMake(pnX, pnY, pnSize.width, pnSize.height);
    [self.container addSubview:pnLabel];
    
    UITextField *pnField = [[UITextField alloc] init];
    pnField.placeholder = @"召唤师名称";
    pnField.backgroundColor = [UIColor whiteColor];
    pnField.frame = CGRectMake(margin, CGRectGetMaxY(pnLabel.frame) + margin, 290, 30);
    [self.container addSubview:pnField];
    self.pnField = pnField;
    
    UILabel *snLabel = [[UILabel alloc] init];
    snLabel.text = @"服务器名称";
    snLabel.font = [UIFont systemFontOfSize:11];
    snLabel.textColor = [UIColor darkGrayColor];
    CGFloat snX = margin;
    CGFloat snY = CGRectGetMaxY(pnField.frame) + margin;
    CGSize snSize = [snLabel.text sizeWithFont:snLabel.font maxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    snLabel.frame = CGRectMake(snX, snY, snSize.width, snSize.height);
    [self.container addSubview:snLabel];
    
    GXButton *snBtn = [[GXButton alloc] init];
    snBtn.frame = CGRectMake(margin, CGRectGetMaxY(snLabel.frame) + margin, 275, 30);
    snBtn.titleLabel.font = [UIFont boldSystemFontOfSize:18];
    [snBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    GXServeInfo *serverInfo = [self.servers firstObject];
    [snBtn setTitle:serverInfo.fullSn forState:UIControlStateNormal];
    [snBtn addTarget:self action:@selector(choiceServer:) forControlEvents:UIControlEventTouchUpInside];
    [self.container addSubview:snBtn];
    self.snBtn = snBtn;
    
    UIImageView *arrow = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_triangle"]];
    arrow.x = CGRectGetMaxX(snBtn.frame) + margin;
    arrow.y = snY + 30;
    [self.container addSubview:arrow];
    
    
    UIButton *bindingBtn = [[UIButton alloc] init];
    [bindingBtn setImage:[UIImage imageNamed:@"shakeBind1"] forState:UIControlStateNormal];
    [bindingBtn setImage:[UIImage imageNamed:@"shakeBind2"] forState:UIControlStateHighlighted];
    bindingBtn.frame = CGRectMake(120, CGRectGetMaxY(snBtn.frame) + margin, 70, 35);
    [bindingBtn addTarget:self action:@selector(binding) forControlEvents:UIControlEventTouchUpInside];
    [self.container addSubview:bindingBtn];
}

- (void)choiceServer:(UIButton *)button
{
    self.serverList.hidden = !self.serverList.hidden;
    self.cloud.hidden = !self.cloud.hidden;
}

- (void)cloudDidClick
{
    self.serverList.hidden = YES;
    self.cloud.hidden = YES;
}
/**
 *  绑定
 */
- (void)binding
{
    // 取出用户信息
    GXUser *user = [[GXUser alloc] init];
    user.playerName = self.pnField.text;
    NSArray *serverName = [self.snBtn.titleLabel.text componentsSeparatedByString:@" "];
    user.serverName = [serverName lastObject];
    
    // 缓存用户信息
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:[user.serverName stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] forKey:GXServerName];
    [defaults setObject:[user.playerName stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] forKey:GXPlayerName];
    // 让NSUserDefaults立刻保存数据
    [defaults synchronize];
    
    // 跳转到战斗力查询页面
    GXCombatController *combatVc = [[GXCombatController alloc] init];
    combatVc.user = user;
    [self.navigationController pushViewController:combatVc animated:YES];
}

#pragma mark - UIPickerViewDataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return self.servers.count;
}

#pragma mark - UIPickerViewDelegate
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
    return 320;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 30;
}

- (NSAttributedString *)pickerView:(UIPickerView *)pickerView attributedTitleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    GXServeInfo *serverInfo = self.servers[row];
    NSAttributedString *titleStr = [[NSAttributedString alloc] initWithString:serverInfo.fullSn attributes:@{NSFontAttributeName: [UIFont boldSystemFontOfSize:18]}];
    return titleStr;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    GXServeInfo *serverInfo = self.servers[row];
    [self.snBtn setTitle:serverInfo.fullSn forState:UIControlStateNormal];
    self.serverList.hidden = YES;
    self.cloud.hidden = YES;
}

@end
