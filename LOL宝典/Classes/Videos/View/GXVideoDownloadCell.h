//
//  GXVideoDownloadCell.h
//  LOL宝典
//
//  Created by siguoxi on 16/7/12.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol GXVideoDownloadCellDelegate <NSObject>

- (void)pauseBtnDidClick:(UIButton *)pauseBtn;

- (void)markBtnDidClick:(UIButton *)markBtn;

@end

@class GXVideoInfo;

@interface GXVideoDownloadCell : UITableViewCell

@property (nonatomic, assign) BOOL isEdit;

@property (nonatomic, assign) BOOL stopCell;

@property (nonatomic, strong) GXVideoInfo *videoInfo;

@property (nonatomic, weak) id<GXVideoDownloadCellDelegate> delegate;

+ (instancetype)cellWithTabelView:(UITableView *)tableView;

@end
