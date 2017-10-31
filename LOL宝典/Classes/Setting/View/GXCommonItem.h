//
//  GXCommonItem.h
//  新浪微博
//
//  Created by sgx on 14-7-21.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GXCommonItem : NSObject
/**
 *  图标
 */
@property (nonatomic, copy) NSString *icon;
/**
 *  标题
 */
@property (nonatomic, copy) NSString *title;
/**
 *  子标题
 */
@property (nonatomic, copy) NSString *subTitle;
/**
 *  右边显示的数字标记
 */
@property (nonatomic, copy) NSString *badgeValue;
/**
 *  点击这行cell需要跳转到哪个控制器
 */
@property (nonatomic, assign) Class destVcClass;
/**
 *  点击这行cell想要执行的代码（block只能用copy策略）
 */
@property (nonatomic, copy) void(^operation)();

+ (instancetype)itemWithIcon:(NSString *)icon title:(NSString *)title subTitle:(NSString *)subTitle;
+ (instancetype)itemWithIcon:(NSString *)icon title:(NSString *)title;
+ (instancetype)itemWithTitle:(NSString *)title;
@end
