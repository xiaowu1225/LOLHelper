//
//  GXHeroStoryCell.h
//  LOL宝典
//
//  Created by sgx on 14-8-7.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GXPeople, GXWuqi;

@interface GXHeroStoryCell : UICollectionViewCell

@property (nonatomic, strong) GXPeople *people;

@property (nonatomic, strong) GXWuqi *wuqi;
@end
