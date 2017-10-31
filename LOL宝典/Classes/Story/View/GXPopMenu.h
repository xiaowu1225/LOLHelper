//
//  GXPopMenu.h
//  新浪微博
//
//  Created by sgx on 14-7-4.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GXPopMenu;

typedef enum{
    GXPopMenuArrowPositionCenter = 0,
    GXPopMenuArrowPositionLeft,
    GXPopMenuArrowPositionRight
} GXPopMenuArrowPosition;

@protocol GXPopMenuDelegate <NSObject>

@optional
- (void)popMenuDidDismissed:(GXPopMenu *)popMenu;

@end

@interface GXPopMenu : UIView
/**
 *  代理
 */
@property (nonatomic, weak) id<GXPopMenuDelegate> delegate;
/**
 *  是否显示灰色背景
 */
@property (nonatomic, assign, getter = isDimBackground) BOOL dimBackground;
/**
 *  箭头方向
 */
@property (nonatomic, assign) GXPopMenuArrowPosition arrowPosition;
/**
 *  初始化方法
 */
- (instancetype)initWithContentView:(UIView *)contentView;
+ (instancetype)menuWithContentView:(UIView *)contentView;
/**
 *  设置菜单的背景图片
 */
- (void)setBackground:(UIImage *)background;
/**
 *  显示菜单
 */
- (void)showInRect:(CGRect)rect;
/**
 *  关闭菜单
 */
- (void)dismiss;
@end
