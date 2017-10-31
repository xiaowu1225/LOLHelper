//
//  VideoCell.h
//  WMVideoPlayer
//
//  Created by zhengwenming on 16/1/17.
//  Copyright © 2016年 郑文明. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GXLiveInfo;
@interface VideoCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *backgroundIV;
@property (weak, nonatomic) IBOutlet UIButton *playBtn;
@property (nonatomic, strong)GXLiveInfo *liveInfo;
@end
