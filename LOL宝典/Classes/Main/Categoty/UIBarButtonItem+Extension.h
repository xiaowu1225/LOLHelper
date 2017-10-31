//
//  UIBarButtonItem+Extension.h
//  新浪微博
//
//  Created by sgx on 14-7-3.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Extension)
+ (UIBarButtonItem *)itemWithImageName:(NSString *)imageName highlightedImaheName:(NSString *)highlightedImageName target:(id)target action:(SEL)action;
@end
