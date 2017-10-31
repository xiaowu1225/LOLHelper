//
//  GXDownLoadTool.h
//  LOL宝典
//
//  Created by siguoxi on 16/7/11.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GXVideoInfo.h"

typedef void(^DownLoading) (NSString *ID, CGFloat progress, int64_t totalBytesWritten, int64_t bytesWritten, int64_t totalBytesExpectedToWrite);

typedef void(^DownLoadPath) (NSString *ID, NSString *path, NSString *fileName);

typedef void(^ResumeData) (NSString *ID, NSData *resumeData, NSError *error);

@interface GXDownLoadTool : NSObject
@property (nonatomic, retain) NSURLSession *session;
@property (nonatomic, copy) DownLoading downLoadingBlock;
@property (nonatomic, copy) DownLoadPath filePathBlock;
@property (nonatomic, copy) ResumeData resumeBlock;
@property (nonatomic, retain) NSData *resumeData;
@property (nonatomic, copy) NSString *ID;
@property (nonatomic, strong) NSMutableArray *downLoadingList;
@property (nonatomic, strong) GXVideoInfo *videoInfo;

+ (instancetype)shareDownLoadTool;

// 开始下载
- (void)downLoadFileWith:(NSString *)url saveForFileName:(NSString *)fileName;
// 暂停
- (void)cancelDownLoadFile;
// 断点续传
- (void)resumeDownLoadFile;

@end
