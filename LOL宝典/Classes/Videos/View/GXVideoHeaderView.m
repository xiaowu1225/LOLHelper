//
//  GXVideoHeaderView.m
//  LOL宝典
//
//  Created by siguoxi on 16/6/8.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import "GXVideoHeaderView.h"

@interface GXVideoHeaderView ()

@property (nonatomic, weak) UILabel *titleLable;

@end

@implementation GXVideoHeaderView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.frame = CGRectMake(10, 0, 310, 25);
        titleLabel.font = [UIFont boldSystemFontOfSize:15];
        titleLabel.backgroundColor = [UIColor whiteColor];
        [self addSubview:titleLabel];
        self.titleLable = titleLabel;
    }
    return self;
}

- (void)setLabelText:(NSString *)labelText
{
    _labelText = [labelText copy];
    self.titleLable.text = _labelText;
}

@end
