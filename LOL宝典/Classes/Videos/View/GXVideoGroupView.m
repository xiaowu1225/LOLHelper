//
//  GXVideoGroupView.m
//  LOL宝典
//
//  Created by sgx on 14-8-11.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "GXVideoGroupView.h"
#import "GXVideoList.h"
#import "GXVideoListTitleCell.h"

#define GXCellCount 4

@interface GXVideoGroupView ()

@property (nonatomic, weak) UILabel *titleLabel;

@property (nonatomic, weak) UIView *containerView;
@end

@implementation GXVideoGroupView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 添加头部Label
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.font = [UIFont boldSystemFontOfSize:15];
        titleLabel.backgroundColor = [UIColor whiteColor];
        [self addSubview:titleLabel];
        self.titleLabel = titleLabel;
        
        // 添加下面containerView
        UIView *containerView = [[UIView alloc] init];
        [self addSubview:containerView];
        self.containerView = containerView;
    }
    return self;
}

- (void)setVideoList:(GXVideoList *)videoList
{
    _videoList = videoList;
    
    self.titleLabel.frame = CGRectMake(0, 0, GXScreenWidth, 25);
    self.titleLabel.text = [NSString stringWithFormat:@"  %@", _videoList.name];
    
    int count = _videoList.children.count;
    int rows = (count / GXCellCount > 0) ? count / GXCellCount : 1;
    CGFloat margin = 10;
    CGFloat cellW = 70;
    CGFloat cellH = 90;
    for (int i = 0; i < count; i ++) {
        GXVideoListTitleCell *listCell = [[GXVideoListTitleCell alloc] init];
        int row = i / GXCellCount;
        int col = i % GXCellCount;
        CGFloat cellX = margin * 0.5 + (margin + cellW) * col;
        CGFloat cellY = margin + (margin + cellH) * row;
        listCell.frame = CGRectMake(cellX, cellY, cellW, cellH);
        listCell.videoTitle = _videoList.children[i];
        [listCell addTarget:self action:@selector(listCellClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.containerView addSubview:listCell];
    }
    
    CGFloat containerX = 0;
    CGFloat containerY = CGRectGetMaxY(self.titleLabel.frame);
    CGFloat containerW = GXScreenWidth;
    CGFloat containerH = (margin + cellH) * rows;
    self.containerView.frame = CGRectMake(containerX, containerY, containerW, containerH);
    
    self.width = GXScreenWidth;
    self.height = CGRectGetMaxY(self.containerView.frame);
    
}

- (void)listCellClick:(GXVideoListTitleCell *)listCell
{
    if ([self.delegate respondsToSelector:@selector(listCellDidClick:)]) {
        [self.delegate listCellDidClick:listCell];
    }
}

@end
