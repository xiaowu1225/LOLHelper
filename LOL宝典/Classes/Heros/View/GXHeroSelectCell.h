//
//  GXHeroSelectCell.h
//  LOL宝典
//
//  Created by sgx on 14-8-9.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GXHeroIntroduction;

@interface GXHeroSelectCell : UITableViewCell

@property (nonatomic, strong) GXHeroIntroduction *selectedModel;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
