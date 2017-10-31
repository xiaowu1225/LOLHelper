//
//  GXSkillDetailController.m
//  LOL宝典
//
//  Created by sgx on 14-8-14.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "GXSkillDetailController.h"
#import "GXSkillDetailView.h"
#import "GXSkillsInfo.h"

@interface GXSkillDetailController ()
@property (nonatomic, strong) GXSkillDetailView *detailView;
@end

@implementation GXSkillDetailController

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
    
    GXSkillDetailView *detailView = [[GXSkillDetailView alloc] init];
    detailView.frame = self.view.bounds;
    detailView.skillSinfo = self.skillsInfo;
    [self.view addSubview:detailView];
    self.detailView = detailView;
}




@end
