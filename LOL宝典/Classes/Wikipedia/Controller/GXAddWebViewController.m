//
//  GXAddWebViewController.m
//  LOL宝典
//
//  Created by siguoxi on 2017/8/2.
//  Copyright © 2017年 itcast. All rights reserved.
//

#import "GXAddWebViewController.h"
#import "MBProgressHUD+MJ.h"
#import "GXSearchBar.h"
#import "GXWebController.h"

@interface GXAddWebViewController ()
@property (nonatomic, strong) NSMutableArray *videolist;
@property (nonatomic, assign) NSInteger currentPage;
@property (nonatomic, weak) GXSearchBar *searchBar;
@property (nonatomic, weak) UIButton *cover;
@end

@implementation GXAddWebViewController

- (NSMutableArray *)videolist
{
    if (_videolist == nil) {
        _videolist = [NSMutableArray array];
    }
    return _videolist;
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"添加网址";
    self.view.backgroundColor = [UIColor wheatColor];
    [self setupSearchBar];
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSArray *dictArr = [defaults objectForKey:@"addHtmlUrlArr"];
    if (dictArr && [dictArr isKindOfClass:[NSArray class]]) {
        [self.videolist removeAllObjects];
        [self.videolist addObjectsFromArray:dictArr];
    }
    [self.tableView reloadData];
}

- (void)setupSearchBar
{
    UIView *herderView = [[UIView alloc] init];
    herderView.backgroundColor = [UIColor wheatColor];
    herderView.frame = CGRectMake(0, 0, GXScreenWidth, 45);
    self.tableView.tableHeaderView = herderView;
    // 添加搜索框
    GXSearchBar *searchBar = [GXSearchBar searchBar];
    searchBar.width = 220;
    searchBar.height = 35;
    searchBar.x = 10;
    searchBar.y = 5;
    [herderView addSubview:searchBar];
    searchBar.font = [UIFont systemFontOfSize:13];
    searchBar.placeholder = @"请输入视频地址";
    self.searchBar = searchBar;
    // 添加搜索按钮
    UIButton *searchBtn = [[UIButton alloc] init];
    searchBtn.x = CGRectGetMaxX(searchBar.frame) + 10;
    searchBtn.y = searchBar.y;
    searchBtn.width = 70;
    searchBtn.height = 35;
    searchBtn.layer.cornerRadius = 5;
    searchBtn.backgroundColor = [UIColor orangeColor];
    [searchBtn addTarget:self action:@selector(addVideo) forControlEvents:UIControlEventTouchUpInside];
    [searchBtn setTitle:@"添加" forState:UIControlStateNormal];
    [herderView addSubview:searchBtn];
    // 监听通知
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    // 文字改变
    [center addObserver:self selector:@selector(textChange) name:UITextFieldTextDidChangeNotification object:nil];
    // 显示键盘
    [center addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
}

- (void)addVideo
{
    if (self.searchBar.text && self.searchBar.text.length > 0) {
        [self addVideoUrl];
    } else {
        [MBProgressHUD showError:@"添加内容不能为空！"];
    }
}

/**
 *  添加视频地址
 */
- (void)addVideoUrl
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSArray *dictArr = [defaults objectForKey:@"addHtmlUrlArr"];
    NSMutableArray *dictMArr = [NSMutableArray arrayWithArray:dictArr];
    __block BOOL hasContent = NO;
    [dictArr enumerateObjectsUsingBlock:^(NSString *addVideo, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([addVideo isEqualToString:self.searchBar.text]) {
            [MBProgressHUD showError:@"该视频已添加！"];
            hasContent = YES;
            *stop = YES;
        }
    }];
    if (hasContent) {
        return;
    }
    [dictMArr addObject:self.searchBar.text];
    [defaults setObject:dictMArr forKey:@"addHtmlUrlArr"];
    [defaults synchronize];
    [self.videolist addObject:self.searchBar.text];
    [self.tableView reloadData];
}

/**
 *  文字改变
 */
- (void)textChange
{
    
}

/**
 *  键盘即将显示
 */
- (void)keyboardWillShow:(NSNotification *)notification
{
    // 添加一个朦板
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
    [self.searchBar resignFirstResponder];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.videolist.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *identifer = @"addVideoUrl";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
    }
    NSString *urlStr = self.videolist[indexPath.row];
    cell.textLabel.text = urlStr;
    cell.textLabel.userInteractionEnabled = NO;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    NSString *urlStr = self.videolist[indexPath.row];
    GXWebController *webVc = [[GXWebController alloc] init];
    webVc.url = urlStr;
    [self.navigationController pushViewController:webVc animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

//先要设Cell可编辑
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

//定义编辑样式
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}
//结束编辑
- (void)tableView:(UITableView*)tableView didEndEditingRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

//进入编辑模式，按下出现的编辑按钮后
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSArray *dictArr = [defaults objectForKey:@"addHtmlUrlArr"];
    NSMutableArray *dictMArr = [NSMutableArray arrayWithArray:dictArr];
    [dictMArr removeObjectAtIndex:indexPath.row];
    [defaults setObject:dictMArr forKey:@"addHtmlUrlArr"];
    [defaults synchronize];
    [self.videolist removeObjectAtIndex:indexPath.row];
    [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]
                     withRowAnimation:UITableViewRowAnimationAutomatic];
    [tableView setEditing:NO animated:YES];
}

//修改编辑按钮文字
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
}

@end
