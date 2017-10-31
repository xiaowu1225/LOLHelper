//
//  GXAboutController.m
//  LOL宝典
//
//  Created by sgx on 14-8-9.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "GXAboutController.h"

@interface GXAboutController ()

@end

@implementation GXAboutController

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
    UIView *aboutView = [[[NSBundle mainBundle] loadNibNamed:@"GXAboutView" owner:nil options:nil] firstObject];
    aboutView.frame = self.view.bounds;
    aboutView.backgroundColor = [UIColor wheatColor];
    [self.view addSubview:aboutView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
