//
//  UIImage+Extension.h
//  新浪微博
//
//  Created by sgx on 14-7-3.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Extension)
+ (UIImage *)imageWithColor:(UIColor *)color;
+ (UIImage *)resizedImage:(NSString *)imageName;
@end
