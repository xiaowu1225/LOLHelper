//
//  GXSearchBar.m
//  新浪微博
//
//  Created by sgx on 14-7-4.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "GXSearchBar.h"

@implementation GXSearchBar

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        // 设置内容垂直居中
        self.contentVerticalAlignment = UIControlContentHorizontalAlignmentCenter;
        
        // 设置背景
        [self setBackground:[UIImage resizedImage:@"searchbar_textfield_background"]];
        
        // 设置左边放一个放大镜
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.image = [UIImage imageNamed:@"searchbar_textfield_search_icon"];
        imageView.width = imageView.image.size.width + 10;
        imageView.height = imageView.image.size.height;
        imageView.contentMode = UIViewContentModeCenter;
        self.leftView = imageView;
        
        // 设置左边的View永远显示
        self.leftViewMode = UITextFieldViewModeAlways;
        
        // 设置右边永远显示清除按钮
        self.clearButtonMode = UITextFieldViewModeAlways;
    }
    return self;
}

+ (instancetype)searchBar
{
    return [[self alloc] init];
}

@end
