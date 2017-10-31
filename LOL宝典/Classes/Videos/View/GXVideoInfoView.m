//
//  GXVideoInfoView.m
//  LOL宝典
//
//  Created by siguoxi on 16/7/12.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import "GXVideoInfoView.h"
#import "GXDownLoadTool.h"
#import "GXPieChartView.h"

@interface GXVideoInfoView ()
@property (nonatomic, weak) UILabel *titleLabel;
@property (nonatomic, weak) UILabel *timeLabel;
@property (nonatomic, weak) UIButton *dowloadBtn;
@property (nonatomic, weak) GXPieChartView *progressView;
@property (nonatomic, assign) BOOL hasStart;
@end

@implementation GXVideoInfoView
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.font = [UIFont systemFontOfSize:13];
        titleLabel.textColor = [UIColor blackColor];
        titleLabel.numberOfLines = 0;
        [self addSubview:titleLabel];
        self.titleLabel = titleLabel;
        
        UILabel *timeLabel = [[UILabel alloc] init];
        timeLabel.font = [UIFont systemFontOfSize:9];
        timeLabel.textColor = [UIColor darkGrayColor];
        [self addSubview:timeLabel];
        self.timeLabel = timeLabel;
        
        UIButton *dowloadBtn = [[UIButton alloc] init];
        [dowloadBtn setImage:[UIImage imageNamed:@"video_downloading"] forState:UIControlStateNormal];
        [dowloadBtn setImage:[UIImage imageNamed:@"video_pause"] forState:UIControlStateSelected];
        [dowloadBtn setImage:[UIImage imageNamed:@"video_play"] forState:UIControlStateDisabled];
        [dowloadBtn addTarget:self action:@selector(downloadBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:dowloadBtn];
        self.dowloadBtn = dowloadBtn;
        
        GXPieChartView *progressView = [[GXPieChartView alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
        progressView.showsText = YES;
        progressView.hidden = YES;
        [dowloadBtn addSubview:progressView];
        self.progressView = progressView;
        
        GXDownLoadTool *downloadTool = [GXDownLoadTool shareDownLoadTool];
        downloadTool.downLoadingBlock = ^(NSString *ID, CGFloat progress, int64_t totalBytesWritten, int64_t bytesWritten, int64_t totalBytesExpectedToWrite){
            self.progressView.hidden = NO;
            self.progressView.progress = progress;
        };
        downloadTool.filePathBlock = ^(NSString *ID, NSString *path, NSString *fileName){
            self.progressView.hidden = YES;
            self.dowloadBtn.enabled = NO;
        };
    }
    return self;
}

- (void)setVideoInfo:(GXVideoInfo *)videoInfo
{
    _videoInfo = videoInfo;
    self.titleLabel.text = _videoInfo.title;
    CGFloat margin = 5;
    CGFloat labelWidth = 250;
    self.titleLabel.frame = CGRectMake(margin, margin, labelWidth, 40);
    self.timeLabel.text = _videoInfo.datetime;
    self.timeLabel.frame = CGRectMake(margin, CGRectGetMaxY(self.titleLabel.frame), labelWidth, 10);
    self.dowloadBtn.frame = CGRectMake(CGRectGetMaxX(self.titleLabel.frame) + margin * 2, margin, 50, 50);
    self.dowloadBtn.enabled = !_videoInfo.hasCaching;
}

- (void)downloadBtnClick:(UIButton *)pauseBtn
{
    if (self.hasStart) {
        GXDownLoadTool *downloadTool = [GXDownLoadTool shareDownLoadTool];
        if (!pauseBtn.selected) {
            [downloadTool cancelDownLoadFile];
        } else {
            [downloadTool resumeDownLoadFile];
        }
        pauseBtn.selected = !pauseBtn.selected;
    } else {
        GXDownLoadTool *downLoadTool = [GXDownLoadTool shareDownLoadTool];
        NSString * fileName = [NSString stringWithFormat:@"%@.mp4", [GXService getMd5_32Bit_String:self.videoInfo.url]];
        self.videoInfo.hasCaching = NO;
        downLoadTool.videoInfo = self.videoInfo;
        [downLoadTool downLoadFileWith:self.videoInfo.url saveForFileName:fileName];
        self.hasStart = YES;
        [downLoadTool.downLoadingList addObject:self.videoInfo];
    }
    if ([self.delegate respondsToSelector:@selector(downloadBtnDidClick)]) {
        [self.delegate downloadBtnDidClick];
    }
}

@end
