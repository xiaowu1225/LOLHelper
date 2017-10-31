//
//  GXTitleButton.m
//  新浪微博
//
//  Created by sgx on 14-7-4.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "GXTitleButton.h"

@implementation GXTitleButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 设置文字右对齐
        self.titleLabel.textAlignment = NSTextAlignmentRight;
        // 设置内部图标居中
        self.imageView.contentMode = UIViewContentModeCenter;
        // 设置文字颜色
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        // 设置文字字体
        self.titleLabel.font = GXTitleFont;
        // 设置高亮时不要调整内部图片为灰色
        self.adjustsImageWhenHighlighted = NO;
    }
    return self;
}

- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    CGFloat imageY = 0;
    CGFloat imageW = self.height;
    CGFloat imageH = imageW;
    CGFloat imageX = self.width - imageW;
    return CGRectMake(imageX, imageY, imageW, imageH);
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    CGFloat titleX = 0;
    CGFloat titleY = 0;
    CGFloat titleW = self.width - self.height;
    CGFloat titleH = self.height;
    return CGRectMake(titleX, titleY, titleW, titleH);
}

- (void)setTitle:(NSString *)title forState:(UIControlState)state
{
    [super setTitle:title forState:state];
    
    // 1.计算文字的尺寸
    CGSize titleSize = [title sizeWithFont:self.titleLabel.font maxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    
    // 2.计算按钮的宽度
    self.width = titleSize.width + self.height + 10;
}
@end
