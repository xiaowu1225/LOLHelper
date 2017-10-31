//
//  GXCurrentBattleCell.h
//  LOL宝典
//
//  Created by sgx on 14-8-15.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GXShakeHeroInfo;
@interface GXCurrentBattleCell : UITableViewCell

@property (nonatomic, strong) GXShakeHeroInfo *heroInfo;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
