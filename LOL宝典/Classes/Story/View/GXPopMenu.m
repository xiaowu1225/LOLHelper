//
//  GXPopMenu.m
//  新浪微博
//
//  Created by sgx on 14-7-4.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "GXPopMenu.h"

@interface GXPopMenu ()

@property (nonatomic, strong) UIView *contentView;
/**
 *  最底部的遮盖 ：屏蔽除菜单以外控的制事件
 */
@property (nonatomic, weak) UIButton *cover;
/**
 *  容器 ：容纳具体要显示的内容containView
 */
@property (nonatomic, weak) UIImageView *container;
@end

@implementation GXPopMenu
#pragma mark - 初始化方法
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        // 添加一个遮盖
        UIButton *cover = [[UIButton alloc] init];
        [cover addTarget:self action:@selector(coverClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:cover];
        self.cover = cover;
        
        // 添加带箭头的背景图片
        UIImageView *container = [[UIImageView alloc] init];
        container.userInteractionEnabled = YES;
        [self addSubview:container];
        self.container = container;
        self.arrowPosition = GXPopMenuArrowPositionCenter;
    }
    return self;
}

- (instancetype)initWithContentView:(UIView *)contentView
{
    if (self = [super init]) {
        self.contentView = contentView;
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.cover.frame = self.bounds;
}

+ (instancetype)menuWithContentView:(UIView *)contentView
{
    return [[self alloc] initWithContentView:contentView];
}

#pragma mark - 内部方法
- (void)coverClick
{
    [self dismiss];
}

#pragma mark - 公共方法

- (void)setArrowPosition:(GXPopMenuArrowPosition)arrowPosition
{
    _arrowPosition = arrowPosition;
    switch (_arrowPosition) {
        case GXPopMenuArrowPositionCenter:
            self.container.image = [UIImage resizedImage:@"popover_background"];
            break;
            
        case GXPopMenuArrowPositionLeft:
            self.container.image = [UIImage resizedImage:@"popover_background_left"];
            break;
            
        case GXPopMenuArrowPositionRight:
            self.container.image = [UIImage resizedImage:@"popover_background_right"];
            break;
    }
}

- (void)setDimBackground:(BOOL)dimBackground
{
    _dimBackground = dimBackground;
    if (_dimBackground) {
        self.cover.backgroundColor = [UIColor blackColor];
        self.cover.alpha = 0.3;
    } else {
        self.cover.backgroundColor = [UIColor clearColor];
        self.cover.alpha = 1.0;
    }
}

- (void)setBackground:(UIImage *)background
{
    self.container.image = background;
}

- (void)showInRect:(CGRect)rect
{
    // 添加菜单整体到窗口身上
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    self.frame = window.bounds;
    [window addSubview:self];
    
    // 设置容器的frame
    self.container.frame = rect;
    [self.container addSubview:self.contentView];
    
    // 设置容器里面内容的frame
    CGFloat topMargin = 12;
    CGFloat leftMargin = 5;
    CGFloat rightMargin = 5;
    CGFloat bottomMargin = 8;
    
    self.contentView.x = leftMargin;
    self.contentView.y = topMargin;
    self.contentView.width = self.container.width - leftMargin - rightMargin;
    self.contentView.height = self.container.height - topMargin - bottomMargin;
}

- (void)dismiss
{
    if ([self.delegate respondsToSelector:@selector(popMenuDidDismissed:)]) {
        [self.delegate popMenuDidDismissed:self];
    }
    [self removeFromSuperview];
}

@end
