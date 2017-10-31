//
//  GXDownLoadTool.m
//  LOL宝典
//
//  Created by siguoxi on 16/7/11.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import "GXDownLoadTool.h"
#import "MJExtension.h"
#import "GXLocalNoteTool.h"

@interface GXDownLoadTool()<NSURLSessionDownloadDelegate>

@property (nonatomic, retain) NSURLSessionDownloadTask *downLoadTask;
@property (nonatomic, copy) NSString *urlStr;
@property (nonatomic, copy) NSString *fileName;
@property (nonatomic, assign) CGFloat progress;

@end

@implementation GXDownLoadTool

- (NSMutableArray *)downLoadingList
{
    if (_downLoadingList == nil) {
        _downLoadingList = [NSMutableArray array];
    }
    return _downLoadingList;
}

+ (instancetype)shareDownLoadTool
{
    static id _sharedInstance = nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate,^{
        _sharedInstance = [[self alloc] init];
    });
    return _sharedInstance;
}

- (NSURLSession *)session
{
    if (!_session) {
        NSURLSessionConfiguration *config = [NSURLSessionConfiguration backgroundSessionConfigurationWithIdentifier:@"downloadIdentifer"];
        config.sessionSendsLaunchEvents = YES;
        config.discretionary = YES;
        _session = [NSURLSession sessionWithConfiguration:config delegate:self delegateQueue:[NSOperationQueue mainQueue]];
    }
    return _session;
}

// 开始下载
- (void)downLoadFileWith:(NSString *)urlStr saveForFileName:(NSString *)fileName
{
    _urlStr = urlStr;
    _fileName = fileName;
    // 创建下载链接
    [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url = [NSURL URLWithString:urlStr];
    
    // 创建下载任务
    self.downLoadTask = [self.session downloadTaskWithURL:url];
    // 启动下载任务
    [self.downLoadTask resume];
    
}

// 暂停
- (void)cancelDownLoadFile
{
    if (self.downLoadTask == nil )return;
    
#pragma mark 暂存断点数据
    // 暂停任务
    // 停止下载任务, 保存数据
    [self.downLoadTask cancelByProducingResumeData:^(NSData *resumeData) {
        self.resumeData = resumeData;
    }];
}

// 断点续传
- (void)resumeDownLoadFile
{
    [self resumeDownFileWith:self.resumeData with:self.urlStr withFileName:self.fileName];
}

// 断点续传
- (void)resumeDownFileWith:(NSData *)resumeData with:(NSString *)urlStr withFileName:(NSString *)fileName
{
    _fileName = fileName;
    if (self.resumeData == nil) return ;
    // 建立续传下载任务
    
    // 创建下载链接
    [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url = [NSURL URLWithString:urlStr];
    // 创建下载任务
    self.downLoadTask = [self.session downloadTaskWithURL:url];
    
    self.downLoadTask = [self.session downloadTaskWithResumeData:self.resumeData];
    [self.downLoadTask resume];
    // 清除续传数据
    self.resumeData = nil;
}

#pragma mark 下载代理方法  NSURLSessionDownloadDelegate
// 下载中
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didWriteData:(int64_t)bytesWritten totalBytesWritten:(int64_t)totalBytesWritten totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite
{
    float progress = (float) totalBytesWritten / totalBytesExpectedToWrite;
    self.progress = progress;
    self.videoInfo.videoSize = [NSString stringWithFormat:@"大小: %.1lldM", totalBytesWritten / 1000000];
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        // 主线程更新UI等操作
        if (self.downLoadingBlock) {
            self.downLoadingBlock(self.ID, progress, totalBytesWritten, bytesWritten, totalBytesExpectedToWrite);
        }
    }];
}

// 下载完成
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didFinishDownloadingToURL:(NSURL *)location
{
    // 把下载完成的文件转移走, 避免被系统删除
    // 1. 获取系统沙盒路径
    NSString *cache = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    // 2. downloadTask.response.suggestedFilename 使用服务器使用的名字
    NSString *savePath = [cache stringByAppendingPathComponent:@"Videos"];
    
    // 3. 创建NSFileMagager  进行文件转移
    BOOL isDir = NO;
    NSFileManager *fm = [NSFileManager defaultManager];
    // 创建目录
    if(!([fm fileExistsAtPath:savePath isDirectory:&isDir] && isDir))
    {
        [fm createDirectoryAtPath:savePath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    NSString *videoPath = [savePath stringByAppendingPathComponent:self.fileName];
    NSError *error = nil;
    [fm moveItemAtPath:location.path toPath:videoPath error:&error];
    [self.downLoadingList removeObject:self.videoInfo];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSMutableArray *downLoadArr = [NSMutableArray arrayWithArray:[defaults objectForKey:@"downLoadVideoArr"]];
    if (downLoadArr == nil) {
        downLoadArr = [NSMutableArray array];
    }
    self.videoInfo.videoName = self.fileName;
    self.videoInfo.hasCaching = YES;
    NSDictionary *videoInfo = [self.videoInfo keyValues];
    [downLoadArr addObject:videoInfo];
    [defaults setObject:downLoadArr forKey:@"downLoadVideoArr"];
    // 手动添加
    NSArray *dictArr = [defaults objectForKey:@"addVideoUrlArr"];
    NSMutableArray *dictMArr = [NSMutableArray array];
    [dictArr enumerateObjectsUsingBlock:^(NSDictionary *addVideo, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([addVideo[@"url"] isEqualToString:self.videoInfo.url]) {
            NSMutableDictionary *dictM = [NSMutableDictionary dictionaryWithDictionary:addVideo];
            dictM[@"hasCaching"] = @(YES);
            [dictMArr addObject:dictM];
        } else {
            [dictMArr addObject:addVideo];
        }
    }];
    [defaults setObject:dictMArr forKey:@"addVideoUrlArr"];
    [defaults synchronize];
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        // 主线程更新UI等操作
        if (self.filePathBlock) {
            self.filePathBlock(self.ID, savePath, self.fileName);
        }
    }];
}

/** 续传的代理方法 */
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didResumeAtOffset:(int64_t)fileOffset expectedTotalBytes:(int64_t)expectedTotalBytes
{
    
}

// 成功失败都会走的方法
- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error
{
    if (error) {
        NSLog(@"下载失败 = %@", error);
        
        self.resumeData = error.userInfo[NSURLSessionDownloadTaskResumeData];
        // 保存断点
        if (self.resumeBlock) {
            self.resumeBlock(self.ID, self.resumeData, error);
        }
        // 清除当前下载任务
        self.downLoadTask = nil;
    }else{
        NSLog(@"下载成功");
        NSDate *currentDate = [NSDate date];
        GXLocalNoteTool *noteTool = [GXLocalNoteTool localNoteTool];
        [noteTool registerLocalNotification:currentDate];
    }
}

@end
