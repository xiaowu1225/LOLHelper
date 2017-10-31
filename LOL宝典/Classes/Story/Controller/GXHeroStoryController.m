//
//  GXHeroStoryController.m
//  LOL宝典
//
//  Created by sgx on 14-8-8.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "GXHeroStoryController.h"

@interface GXHeroStoryController ()<UIGestureRecognizerDelegate>
@property (nonatomic, weak) UITextView *storyView;
@property (nonatomic, assign) int page;
@end

@implementation GXHeroStoryController

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
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UITextView *storyView = [[UITextView alloc] init];
    storyView.width = GXScreenWidth;
    storyView.height = GXScreenHeight - 64;
    [self.view addSubview:storyView];
    self.storyView = storyView;
    storyView.text = self.story;
    
    [self setupTextView];
}

- (void)setupTextView
{
    // 设置文本View的属性
    self.storyView.backgroundColor = [UIColor wheatColor];
    self.storyView.font = [UIFont systemFontOfSize:18];
    self.storyView.textColor = [UIColor blackColor];
    self.storyView.editable = NO;
    self.storyView.selectable = NO;
    self.storyView.showsHorizontalScrollIndicator = NO;
    self.storyView.showsVerticalScrollIndicator = NO;
}

@end
