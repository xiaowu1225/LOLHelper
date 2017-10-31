//
//  UIBarButtonItem+Extension.m
//  新浪微博
//
//  Created by sgx on 14-7-3.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "UIBarButtonItem+Extension.h"

@implementation UIBarButtonItem (Extension)

+ (UIBarButtonItem *)itemWithImageName:(NSString *)imageName highlightedImaheName:(NSString *)highlightedImageName target:(id)target action:(SEL)action
{
    UIButton *button = [[UIButton alloc] init];
    [button setBackgroundImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:highlightedImageName] forState:UIControlStateHighlighted];
    
    // 设置按钮的尺寸为背景图片的尺寸
    button.size = button.currentBackgroundImage.size;
    
    // 监听按钮点击
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc] initWithCustomView:button];
}

@end
