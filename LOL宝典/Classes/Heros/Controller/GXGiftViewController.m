//
//  GXGiftViewController.m
//  LOL宝典
//
//  Created by sgx on 14-8-14.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "GXGiftViewController.h"
#import "GXGift.h"
#import "UIImageView+WebCache.h"

@interface GXGiftViewController ()
@property (nonatomic, weak) UIScrollView *scrollView;
@property (nonatomic, weak) UIImageView *imageView;
@property (nonatomic, assign) CGRect lastFrame;
@end

@implementation GXGiftViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor wheatColor];
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.backgroundColor = [UIColor wheatColor];
    scrollView.frame = self.view.bounds;
    scrollView.pagingEnabled = YES;
    scrollView.contentSize = CGSizeMake(2 * GXScreenWidth, 0);
    [self.view addSubview:scrollView];
    self.scrollView = scrollView;
    self.title = self.gift.title;
    [self setupScrollView];
}

- (void)setupScrollView
{
    UILabel *giftTitle = [[UILabel alloc] init];
    giftTitle.textAlignment = NSTextAlignmentCenter;
    giftTitle.text = @"天赋";
    giftTitle.font = [UIFont systemFontOfSize:15];
    giftTitle.frame = CGRectMake(0, 0, GXScreenWidth, 30);
    [self.scrollView addSubview:giftTitle];
    UIImageView *giftView = [[UIImageView alloc] init];
    giftView.userInteractionEnabled = YES;
    giftView.contentMode = UIViewContentModeScaleAspectFit;
    [self.scrollView addSubview:giftView];
    
    UILabel *giftLabel = [[UILabel alloc] init];
    giftLabel.numberOfLines = 0;
    giftLabel.text = self.gift.tianDes;
    giftLabel.font = [UIFont systemFontOfSize:13];
    CGSize giftSize = [giftLabel.text sizeWithFont:giftLabel.font maxSize:CGSizeMake(GXScreenWidth - 20, MAXFLOAT)];
    [giftView sd_setImageWithURL:[NSURL URLWithString:self.gift.tianPic] placeholderImage:[UIImage imageNamed:@"icon_downloading"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        CGSize size = image.size;
        giftView.frame = CGRectMake(0, CGRectGetMaxY(giftTitle.frame), GXScreenWidth, GXScreenWidth * size.height / size.width);
        giftLabel.frame = CGRectMake(10, CGRectGetMaxY(giftView.frame) + 10, giftSize.width, giftSize.height);
    }];
    [self.scrollView addSubview:giftLabel];
    
    UILabel *runeTitle = [[UILabel alloc] init];
    runeTitle.textAlignment = NSTextAlignmentCenter;
    runeTitle.text = @"符文";
    runeTitle.font = [UIFont systemFontOfSize:15];
    runeTitle.frame = CGRectMake(GXScreenWidth, 0, GXScreenWidth, 30);
    [self.scrollView addSubview:runeTitle];
    UIImageView *runeView = [[UIImageView alloc] init];
    runeView.userInteractionEnabled = YES;
    runeView.contentMode = UIViewContentModeScaleAspectFit;
    [self.scrollView addSubview:runeView];
    
    UILabel *runeLabel = [[UILabel alloc] init];
    runeLabel.numberOfLines = 0;
    runeLabel.text = self.gift.fuDes;
    runeLabel.font = [UIFont systemFontOfSize:13];
    CGSize runeSize = [runeLabel.text sizeWithFont:runeLabel.font maxSize:CGSizeMake(GXScreenWidth - 20, MAXFLOAT)];
    [runeView sd_setImageWithURL:[NSURL URLWithString:self.gift.fuPic] placeholderImage:[UIImage imageNamed:@"icon_downloading"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        CGSize size = image.size;
        runeView.frame = CGRectMake(GXScreenWidth, CGRectGetMaxY(runeTitle.frame), GXScreenWidth, GXScreenWidth * size.height / size.width);
        runeLabel.frame = CGRectMake(GXScreenWidth + 10, CGRectGetMaxY(runeView.frame) + 10, runeSize.width, runeSize.height);
    }];
    [self.scrollView addSubview:runeLabel];
    
    // 添加手势识别器(一个手势识别器只能监听对应的一个View)
    UITapGestureRecognizer *gift = [[UITapGestureRecognizer alloc] init];
    [gift addTarget:self action:@selector(tapPhoto:)];
    [giftView addGestureRecognizer:gift];
    
    UITapGestureRecognizer *rune = [[UITapGestureRecognizer alloc] init];
    [rune addTarget:self action:@selector(tapPhoto:)];
    [runeView addGestureRecognizer:rune];
}

/**
 *  监听图片的点击
 */
- (void)tapPhoto:(UITapGestureRecognizer *)recognizer
{
    // 1.添加一个遮盖
    UIScrollView *cover = [[UIScrollView alloc] init];
    cover.frame = [UIScreen mainScreen].bounds;
    
    cover.backgroundColor = [UIColor blackColor];
    [cover addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapCover:)]];
    [[UIApplication sharedApplication].keyWindow addSubview:cover];
    
    // 2.添加图片到遮盖上
    UIImageView *photoView = (UIImageView *)recognizer.view;
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.image = photoView.image;
    // 将photoView.frame从self坐标系转为cover坐标系
    imageView.frame = [cover convertRect:photoView.frame fromView:self.scrollView];
    self.lastFrame = imageView.frame;
    [cover addSubview:imageView];
    self.imageView = imageView;
    cover.contentSize = CGSizeMake(cover.height * (imageView.image.size.width / imageView.image.size.height), 0);
    
    // 3.放大
    [UIView animateWithDuration:0.25 animations:^{
        CGRect frame = imageView.frame;
        frame.size.height = cover.height; // 占据整个屏幕;
        frame.size.width = cover.height * (imageView.image.size.width / imageView.image.size.height);
        frame.origin.x = 0;
        frame.origin.y = (cover.height - frame.size.height) * 0.5;
        imageView.frame = frame;
    }];
}

- (void)tapCover:(UITapGestureRecognizer *)recognizer
{
    [UIView animateWithDuration:0.25 animations:^{
        recognizer.view.backgroundColor = [UIColor clearColor];
        self.imageView.frame = self.lastFrame;
    } completion:^(BOOL finished) {
        [recognizer.view removeFromSuperview];
        self.imageView = nil;
    }];
}

@end
