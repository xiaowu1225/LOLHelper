//
//  GXHeroToolController.m
//  LOL宝典
//
//  Created by sgx on 14-8-15.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "GXHeroToolController.h"
#import "GXShakeController.h"
#import "GXWikipediaController.h"
#import "GXBindingController.h"
#import "GXAboutController.h"
#import "GXCommonArrowItem.h"
#import "GXCommonGroup.h"
#import "GXAddUrlController.h"

@interface GXHeroToolController ()

@end

@implementation GXHeroToolController

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
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addUrlStr)];
    GXCommonArrowItem *account = [GXCommonArrowItem itemWithIcon:@"icon_hero_s_h" title:@"个人账号"];
    account.destVcClass = [GXBindingController class];
    GXCommonArrowItem *wikipedia = [GXCommonArrowItem itemWithIcon:@"icon_database_s_h" title:@"游戏百科"];
    wikipedia.destVcClass = [GXWikipediaController class];
    GXCommonArrowItem *shake = [GXCommonArrowItem itemWithIcon:@"icon_shake_s_h" title:@"摇一摇"];
    shake.destVcClass = [GXShakeController class];
    
    GXCommonGroup *group1 = [[GXCommonGroup alloc] init];
    group1.items = @[account, wikipedia, shake];
    
    GXCommonArrowItem *about = [GXCommonArrowItem itemWithIcon:@"icon_about_us" title:@"关于"];
    about.destVcClass = [GXAboutController class];
    
    GXCommonGroup *group2 = [[GXCommonGroup alloc] init];
    group2.items = @[about];
    [self.groups addObject:group1];
    [self.groups addObject:group2];
}

- (void)addUrlStr
{
    GXAddUrlController *addUrlVc = [[GXAddUrlController alloc] init];
    [self.navigationController pushViewController:addUrlVc animated:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
