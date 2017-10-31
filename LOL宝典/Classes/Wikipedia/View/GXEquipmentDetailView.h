//
//  GXEquipmentDetailView.h
//  LOL宝典
//
//  Created by sgx on 14-8-13.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GXEquipmentDetailInfo;

@protocol GXEquipmentDetailViewDelegate <UIScrollViewDelegate>

- (void)equipmentDidClick:(NSString *)ID;

@end

@interface GXEquipmentDetailView : UIScrollView

@property (nonatomic, strong) GXEquipmentDetailInfo *detailInfo;
@property (nonatomic, weak) id<GXEquipmentDetailViewDelegate> delegate;

@end
