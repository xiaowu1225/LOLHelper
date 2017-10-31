//
//  GXHeroIntroduction.h
//  LOL宝典
//
//  Created by sgx on 14-8-6.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GXHeroIntroduction : NSObject
/**
 *  cell是否为选择状态
 */
@property (nonatomic, assign, getter = isSelected) BOOL selected;
/**
 *  英雄英文名
 */
@property (nonatomic, copy) NSString *en_name;
/**
 *  英雄中文名
 */
@property (nonatomic, copy) NSString *ch_name;
/**
 *  图片地址
 */
@property (nonatomic, copy) NSString *img;
/**
 *  记录id
 */
@property (nonatomic, copy) NSString *record_id;
/**
 *  标题
 */
@property (nonatomic, copy) NSString *title;
/**
 *  作者
 */
@property (nonatomic, copy) NSString *author;
/**
 *  技能加点
 */
@property (nonatomic, copy) NSString *skill;
/**
 *  前期说明
 */
@property (nonatomic, copy) NSString *pre_explain;
/**
 *  中期说明
 */
@property (nonatomic, copy) NSString *mid_explain;
/**
 *  后期说明
 */
@property (nonatomic, copy) NSString *end_explain;
/**
 *  逆风说明
 */
@property (nonatomic, copy) NSString *nf_explain;
/**
 *  前期出装
 */
@property (nonatomic, copy) NSString *pre_cz;
/**
 *  中期出装
 */
@property (nonatomic, copy) NSString *mid_cz;
/**
 *  后期出装
 */
@property (nonatomic, copy) NSString *end_cz;
/**
 *  逆风出装
 */
@property (nonatomic, copy) NSString *nf_cz;
/**
 *  顺风装备成本
 */
@property (nonatomic, copy) NSString *cost;
/**
 *  逆风装备成本
 */
@property (nonatomic, copy) NSString *cost_nf;
/**
 *  战斗力
 */
@property (nonatomic, copy) NSString *combat;
/**
 *  游戏所在区
 */
@property (nonatomic, copy) NSString *server;
/**
 *  游戏类型
 */
@property (nonatomic, copy) NSString *game_type;
/**
 *  赞
 */
@property (nonatomic, copy) NSString *good;
/**
 *  踩
 */
@property (nonatomic, copy) NSString *bad;
/**
 *  时间
 */
@property (nonatomic, copy) NSString *time;
/**
 *  前期出装
 */
@property (nonatomic, strong) NSMutableArray *pre_equipment;
/**
 *  中期出装
 */
@property (nonatomic, strong) NSMutableArray *mid_equipment;
/**
 *  后期出装
 */
@property (nonatomic, strong) NSMutableArray *end_equipment;
/**
 *  逆风出装
 */
@property (nonatomic, strong) NSMutableArray *nf_equipment;
/**
 *  加点
 */
@property (nonatomic, strong) NSMutableArray *skills;
@end
