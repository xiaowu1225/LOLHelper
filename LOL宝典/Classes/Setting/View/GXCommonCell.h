//
//  GXCommonCell.h
//  新浪微博
//
//  Created by sgx on 14-7-21.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GXCommonItem;

@interface GXCommonCell : UITableViewCell

@property (nonatomic, strong) GXCommonItem *item;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

- (void)setIndexPath:(NSIndexPath *)indexPath rowsInSection:(int)rows;

@end
