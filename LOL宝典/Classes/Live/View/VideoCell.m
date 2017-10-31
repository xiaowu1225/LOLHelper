//
//  VideoCell.m
//  WMVideoPlayer
//
//  Created by zhengwenming on 16/1/17.
//  Copyright © 2016年 郑文明. All rights reserved.
//

#import "VideoCell.h"
#import "GXLiveInfo.h"
#import "UIImageView+WebCache.h"

@interface VideoCell ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeDurationLabel;
@property (weak, nonatomic) IBOutlet UILabel *countLabel;
@end

@implementation VideoCell

- (void)setLiveInfo:(GXLiveInfo *)liveInfo
{
    _liveInfo = liveInfo;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.titleLabel.text = _liveInfo.title;
    self.descriptionLabel.text = _liveInfo.descStr;
    [self.backgroundIV sd_setImageWithURL:[NSURL URLWithString:_liveInfo.cover] placeholderImage:[UIImage imageNamed:@"logo"]];
    self.countLabel.text = [NSString stringWithFormat:@"%.0f.%.0f万",_liveInfo.playCount.doubleValue/10000,_liveInfo.playCount.doubleValue/1000-_liveInfo.playCount.doubleValue/10000];
    self.timeDurationLabel.text = [_liveInfo.ptime substringWithRange:NSMakeRange(12, 4)];
}

@end
