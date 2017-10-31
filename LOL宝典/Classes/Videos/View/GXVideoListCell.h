//
//  GXVideoListCell.h
//  LOL宝典
//
//  Created by sgx on 14-8-11.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GXVideoInfo;

@interface GXVideoListCell : UITableViewCell

@property (nonatomic, strong) GXVideoInfo *videoInfo;

+ (instancetype)cellWithTabelView:(UITableView *)tableView;

@end
