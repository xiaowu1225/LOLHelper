//
//  GXVideoDownloadCell.m
//  LOL宝典
//
//  Created by siguoxi on 16/7/12.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import "GXVideoDownloadCell.h"
#import "GXVideoInfo.h"
#import "UIImageView+WebCache.h"
#import "GXDownLoadTool.h"

@interface GXVideoDownloadCell ()

@property (nonatomic, weak) UIView *bgView;

@property (nonatomic, weak) UIButton *markView;

@property (nonatomic, weak) UIImageView *iconView;

@property (nonatomic, weak) UILabel *titleLabel;

@property (nonatomic, weak) UILabel *detailLabel;

@property (nonatomic, weak) UILabel *timeLabel;

@property (nonatomic, weak) UILabel *viewLabel;

@property (nonatomic, weak) UIProgressView *progressView;

@property (nonatomic, weak) UIButton *pauseBtn;

@end

@implementation GXVideoDownloadCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        UIButton *markView = [[UIButton alloc] init];
        [markView setImage:[UIImage imageNamed:@"new_feature_share_false"] forState:UIControlStateNormal];
        [markView setImage:[UIImage imageNamed:@"new_feature_share_true"] forState:UIControlStateSelected];
        [markView addTarget:self action:@selector(markViewSelect:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:markView];
        self.markView = markView;
        
        UIView *bgView = [[UIView alloc] init];
        bgView.userInteractionEnabled = NO;
        [self addSubview:bgView];
        self.bgView = bgView;
        
        // 添加图片
        UIImageView *iconView = [[UIImageView alloc] init];
        iconView.userInteractionEnabled = YES;
        [self.bgView addSubview:iconView];
        self.iconView = iconView;
        
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.font = [UIFont boldSystemFontOfSize:15];
        titleLabel.numberOfLines = 0;
        [self.bgView addSubview:titleLabel];
        self.titleLabel = titleLabel;
        
        UILabel *detailLabel = [[UILabel alloc] init];
        detailLabel.font = [UIFont systemFontOfSize:12];
        detailLabel.textColor = [UIColor whiteColor];
        detailLabel.textAlignment = NSTextAlignmentCenter;
        [iconView addSubview:detailLabel];
        self.detailLabel = detailLabel;
        
        UILabel *timeLabel = [[UILabel alloc] init];
        timeLabel.font = [UIFont systemFontOfSize:12];
        timeLabel.textColor = [UIColor darkGrayColor];
        [self.bgView addSubview:timeLabel];
        self.timeLabel = timeLabel;
        
        UILabel *viewLabel = [[UILabel alloc] init];
        viewLabel.font = [UIFont systemFontOfSize:12];
        viewLabel.textColor = [UIColor darkGrayColor];
        viewLabel.textAlignment = NSTextAlignmentRight;
        [self.bgView addSubview:viewLabel];
        self.viewLabel = viewLabel;
        
        UIProgressView *progressView = [[UIProgressView alloc] init];
        progressView.progress = 0;
        progressView.tintColor = [UIColor darkGrayColor];
        [self.bgView addSubview:progressView];
        self.progressView = progressView;
        
        UIButton *pauseBtn = [[UIButton alloc] init];
        [pauseBtn addTarget:self action:@selector(pauseBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [pauseBtn setImage:[UIImage imageNamed:@"video_downloading"] forState:UIControlStateNormal];
        [pauseBtn setImage:[UIImage imageNamed:@"video_pause"] forState:UIControlStateSelected];
        [pauseBtn setImage:[UIImage imageNamed:@"video_play"] forState:UIControlStateDisabled];
        [iconView addSubview:pauseBtn];
        self.pauseBtn = pauseBtn;
        GXDownLoadTool *downloadTool = [GXDownLoadTool shareDownLoadTool];
        downloadTool.downLoadingBlock = ^(NSString *ID, CGFloat progress, int64_t totalBytesWritten, int64_t bytesWritten, int64_t totalBytesExpectedToWrite){
            self.progressView.progress = progress;
            self.timeLabel.text = [NSString stringWithFormat:@"正在下载 %.0fKB/s", bytesWritten / 1000.0];
            self.viewLabel.text = [NSString stringWithFormat:@"%.0f%%", progress * 100];
        };
    }
    return self;
}

- (void)markViewSelect:(UIButton *)markView
{
    markView.selected = !markView.selected;
    self.videoInfo.hasSelect = markView.selected;
    if ([self.delegate respondsToSelector:@selector(markBtnDidClick:)]) {
        [self.delegate markBtnDidClick:markView];
    }
}

- (void)pauseBtnClick:(UIButton *)pauseBtn
{
    GXDownLoadTool *downloadTool = [GXDownLoadTool shareDownLoadTool];
    if (!pauseBtn.selected) {
        [downloadTool cancelDownLoadFile];
    } else {
        [downloadTool resumeDownLoadFile];
    }
    pauseBtn.selected = !pauseBtn.selected;
    if ([self.delegate respondsToSelector:@selector(pauseBtnDidClick:)]) {
        [self.delegate pauseBtnDidClick:pauseBtn];
    }
}

- (void)setVideoInfo:(GXVideoInfo *)videoInfo
{
    _videoInfo = videoInfo;
    self.bgView.frame = CGRectMake(0, 0, GXScreenWidth, 100);
    self.markView.frame = CGRectMake(3, 38, 24, 24);
    CGFloat margin = 10;
    CGFloat labelWidth = GXScreenWidth - 115;
    CGFloat iconW = 100;
    CGFloat iconH = 80;
    CGFloat iconX = 5;
    CGFloat iconY = margin;
    self.iconView.frame = CGRectMake(iconX, iconY, iconW, iconH);
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:_videoInfo.ico] placeholderImage:[UIImage imageNamed:@"WMPlayerBackground"]];
    
    self.titleLabel.text = _videoInfo.title;
    CGFloat titleX = CGRectGetMaxX(self.iconView.frame) + 5;
    CGFloat titleY = iconY;
    CGFloat titleW = labelWidth;
    CGFloat titleH = 42;
    self.titleLabel.frame = CGRectMake(titleX, titleY, titleW, titleH);
    
    self.detailLabel.text = _videoInfo.des;
    self.detailLabel.frame = CGRectMake(0, iconH - 15, iconW, 15);
    
    self.progressView.frame = CGRectMake(titleX, CGRectGetMaxY(self.titleLabel.frame) + margin, labelWidth, 2);
    self.progressView.hidden = _videoInfo.hasCaching;
    
    CGFloat btnW = 32;
    CGFloat btnH = btnW;
    CGFloat btnX = (iconW - btnW) * 0.5;
    CGFloat btnY = (iconH - btnH) * 0.5;
    self.pauseBtn.frame = CGRectMake(btnX, btnY, btnW, btnH);
    self.pauseBtn.enabled = !_videoInfo.hasCaching;
    
    CGFloat timeX = titleX;
    CGFloat timeY = CGRectGetMaxY(self.progressView.frame) + margin;
    CGFloat timeW = 130;
    CGFloat timeH = 16;
    self.timeLabel.frame = CGRectMake(timeX, timeY, timeW, timeH);
    if (_videoInfo.hasCaching) {
        self.timeLabel.text = _videoInfo.videoSize;
    }
    
    CGFloat viewW = 75;
    CGFloat viewX = GXScreenWidth - viewW - 5;
    CGFloat viewY = timeY;
    CGFloat viewH = timeH;
    self.viewLabel.frame = CGRectMake(viewX, viewY, viewW, viewH);
    if (_videoInfo.hasCaching) {
        self.viewLabel.text = _videoInfo.des;
    }
    self.markView.selected = videoInfo.hasSelect;
}

+ (instancetype)cellWithTabelView:(UITableView *)tableView
{
    static NSString *identifer = @"cell";
    GXVideoDownloadCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
    if (cell == nil) {
        cell = [[GXVideoDownloadCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
    }
    return cell;
}

- (void)setIsEdit:(BOOL)isEdit
{
    _isEdit = isEdit;
    if (self.stopCell) {
        self.bgView.x += 30;
        return;
    }
    if (_isEdit) {
        [UIView animateWithDuration:0.25 animations:^{
            self.bgView.x += 30;
        }];
    } else {
        self.bgView.x += 30;
        [UIView animateWithDuration:0.25 animations:^{
            self.bgView.x -= 30;
        }];
    }
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
