//
//  GXCityStoryController.m
//  LOL宝典
//
//  Created by sgx on 14-8-8.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "GXCityStoryController.h"
#import "GXCitiy.h"

@interface GXCityStoryController ()
@property (nonatomic, weak) UITextView *textView;
@end

@implementation GXCityStoryController

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
    
    UITextView *textView = [[UITextView alloc] init];
    textView.width = GXScreenWidth;
    textView.height = GXScreenHeight - 64;
    
    [self.view addSubview:textView];
    self.textView = textView;
    textView.text = self.city.cityintroduce;
    
    self.textView.backgroundColor = [UIColor wheatColor];
    self.textView.font = [UIFont systemFontOfSize:18];
    self.textView.textColor = [UIColor blackColor];
    self.textView.editable = NO;
    self.textView.selectable = NO;
    self.textView.showsHorizontalScrollIndicator = NO;
    self.textView.showsVerticalScrollIndicator = NO;
}

@end
