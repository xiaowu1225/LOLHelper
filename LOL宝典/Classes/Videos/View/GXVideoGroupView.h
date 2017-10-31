//
//  GXVideoGroupView.h
//  LOL宝典
//
//  Created by sgx on 14-8-11.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GXVideoList, GXVideoListTitleCell;

@protocol GXVideoGroupViewDelegate <NSObject>

- (void)listCellDidClick:(GXVideoListTitleCell *)listCell;

@end

@interface GXVideoGroupView : UIView

@property (nonatomic, strong) GXVideoList *videoList;

@property (nonatomic, assign) id<GXVideoGroupViewDelegate> delegate;

@end
