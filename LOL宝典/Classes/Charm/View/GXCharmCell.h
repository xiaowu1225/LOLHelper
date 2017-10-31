//
//  GXCharmCell.h
//  LOL宝典
//
//  Created by siguoxi on 16/7/10.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GXCharmShowInfo;

@interface GXCharmCell : UITableViewCell

@property (nonatomic, strong) GXCharmShowInfo *charmshowInfo;
+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
