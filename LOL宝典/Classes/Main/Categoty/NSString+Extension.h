//
//  NSString+Extension.h
//  01-QQ聊天
//
//  Created by sgx on 14-6-1.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Extension)

/**
 *  计算文本占用的宽高
 *
 *  @param font    文本显示的字体
 *  @param maxSize 文本最大的显示范围
 *
 *  @return 文本实际占用的宽高
 */
- (CGSize)sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize;
/**
 *  在一个字符串之前添加一段字符串
 *
 *  @param string 添加的字符串
 *
 *  @return 添加后的完整字符串
 */
- (NSString *)addStringBeforeSelf:(NSString *)string;

// 技能大写字母
- (NSString *)skillUppercaseString;

// 技能小写字母
- (NSString *)skillLowercaseString;

@end
