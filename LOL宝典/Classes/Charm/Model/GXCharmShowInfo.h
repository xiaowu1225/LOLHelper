//
//  GXCharmShowInfo.h
//  LOL宝典
//
//  Created by siguoxi on 16/7/10.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GXCharmShowInfo : NSObject
/**
 *  符文图片地址
 */
@property (nonatomic, copy) NSString *imagePath;
/**
 *  符文顶部说明
 */
@property (nonatomic, copy) NSString *topDesc;
/**
 *  符文中部说明
 */
@property (nonatomic, copy) NSString *midDesc;
/**
 *  符文底部说明
 */
@property (nonatomic, copy) NSString *bottomDesc;
/**
 *  cell的高度
 */
@property (nonatomic, assign) CGFloat cellHeight;
@end
