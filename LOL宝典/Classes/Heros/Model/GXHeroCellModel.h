//
//  GXHeroCellModel.h
//  LOL宝典
//
//  Created by sgx on 14-8-6.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GXHeroCellModel : NSObject
/**
 *  头部标题
 */
@property (nonatomic, copy) NSString *title;
/**
 *  出装
 */
@property (nonatomic, strong) NSArray *equipment;
/**
 *  加点
 */
@property (nonatomic, strong) NSArray *skills;
/**
 *  说明
 */
@property (nonatomic, copy) NSString *explain;
/**
 *  cell的高度
 */
@property (nonatomic, assign) CGFloat cellHeight;
@end
