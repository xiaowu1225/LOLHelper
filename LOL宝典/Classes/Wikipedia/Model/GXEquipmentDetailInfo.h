//
//  GXEquipmentDetailInfo.h
//  LOL宝典
//
//  Created by sgx on 14-8-13.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GXEquipmentDetailInfo : NSObject
/**
 *  装备id
 */
@property (nonatomic, copy) NSString *id;
/**
 *  装备名称
 */
@property (nonatomic, copy) NSString *name;
/**
 *  装备描述
 */
@property (nonatomic, copy) NSString *descStr;
/**
 *  装备合成价格
 */
@property (nonatomic, copy) NSString *price;
/**
 *  装备总价格
 */
@property (nonatomic, copy) NSString *allPrice;
/**
 *  装备出售价格
 */
@property (nonatomic, copy) NSString *sellPrice;
/**
 *  装备tags
 */
@property (nonatomic, copy) NSString *tags;
/**
 *  装备附加属性
 */
@property (nonatomic, copy) NSString *extAttrs;
/**
 *  合成需要的装备
 */
@property (nonatomic, copy) NSString *need;
/**
 *  可合成的装备
 */
@property (nonatomic, copy) NSString *compose;
/**
 *  装备附加描述
 */
@property (nonatomic, copy) NSString *extDesc;
/**
 *  装备图标
 */
@property (nonatomic, copy) NSString *icon;
/**
 *  合成需要的装备
 */
@property (nonatomic, strong) NSMutableArray *needEquitment;
/**
 *  可以合成的装备
 */
@property (nonatomic, strong) NSMutableArray *composeEquitment;
@end
