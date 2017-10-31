//
//  NSString+Extension.m
//  01-QQ聊天
//
//  Created by sgx on 14-6-1.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "NSString+Extension.h"

@implementation NSString (Extension)


-(CGSize)sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize
{
    NSDictionary *dict = @{NSFontAttributeName: font};
    CGSize textSize = [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil].size;
    return textSize;
}

- (NSString *)addStringBeforeSelf:(NSString *)string
{
    NSString *newStr = [NSString stringWithFormat:@"%@%@", string, self];
    return newStr;
}

// 技能大写字母
- (NSString *)skillUppercaseString
{
    NSArray *heroSkill = [self componentsSeparatedByString:@"_"];
    return [NSString stringWithFormat:@"%@_%@", heroSkill.firstObject, [heroSkill.lastObject uppercaseString]];
}

// 技能小写字母
- (NSString *)skillLowercaseString
{
    NSArray *heroSkill = [self componentsSeparatedByString:@"_"];
    return [NSString stringWithFormat:@"%@_%@", heroSkill.firstObject, [heroSkill.lastObject lowercaseString]];
}

@end
