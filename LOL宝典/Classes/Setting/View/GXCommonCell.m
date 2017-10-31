//
//  GXCommonCell.m
//  新浪微博
//
//  Created by sgx on 14-7-21.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "GXCommonCell.h"
#import "GXCommonItem.h"
#import "GXBadgeView.h"
#import "GXCommonArrowItem.h"
#import "GXCommonLabelItem.h"
#import "GXCommonSwitchItem.h"
#import "GXCommonMarkItem.h"

@interface GXCommonCell ()
/**
 *  箭头
 */
@property (nonatomic, strong) UIImageView *rightArrow;
/**
 *  打钩
 */
@property (nonatomic, strong) UIImageView *rightMark;
/**
 *  开关
 */
@property (nonatomic, strong) UISwitch *rightSwitch;
/**
 *  标签
 */
@property (nonatomic, strong) UILabel *rightLabel;
/**
 *  提醒数字
 */
@property (nonatomic, strong) GXBadgeView *bageView;
@end

@implementation GXCommonCell

- (UIImageView *)rightArrow
{
    if (_rightArrow == nil) {
        _rightArrow = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"common_icon_arrow"]];
    }
    return _rightArrow;
}

- (UIImageView *)rightMark
{
    if (_rightMark == nil) {
        _rightMark = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"common_icon_checkmark"]];
    }
    return _rightMark;
}


- (UISwitch *)rightSwitch
{
    if (_rightSwitch == nil) {
        _rightSwitch = [[UISwitch alloc] init];
    }
    return _rightSwitch;
}

- (UILabel *)rightLabel
{
    if (_rightLabel == nil) {
        _rightLabel = [[UILabel alloc] init];
        _rightLabel.textColor = [UIColor lightGrayColor];
        _rightLabel.font = [UIFont systemFontOfSize:13];
    }
    return _rightLabel;
}

- (GXBadgeView *)bageView
{
    if (_bageView == nil) {
        _bageView = [[GXBadgeView alloc] init];
    }
    return _bageView;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // 设置标题字体
        self.textLabel.font = [UIFont boldSystemFontOfSize:13];
        self.detailTextLabel.font = [UIFont systemFontOfSize:11];
        
        // 取出cell的默认背景色
        self.backgroundColor = [UIColor whiteColor];
        
        // 设置背景View
        self.backgroundView = [[UIImageView alloc] init];
        self.selectedBackgroundView = [[UIImageView alloc] init];
    }
    return self;
}

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *identifer = @"cell";
    GXCommonCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
    if (cell == nil) {
        cell = [[GXCommonCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifer];
    }
    return cell;
}

- (void)setIndexPath:(NSIndexPath *)indexPath rowsInSection:(int)rows
{
    // 1.取出背景view
    UIImageView *bgView = (UIImageView *)self.backgroundView;
    UIImageView *selectedBgView = (UIImageView *)self.selectedBackgroundView;
    
    if (rows == 1) { // 只有一行
        bgView.image = [UIImage resizedImage:@"common_card_background"];
        selectedBgView.image = [UIImage resizedImage:@"common_card_background_highlighted"];
    } else if (indexPath.row == 0) { // 首行
        bgView.image = [UIImage resizedImage:@"common_card_top_background"];
        selectedBgView.image = [UIImage resizedImage:@"common_card_top_background_highlighted"];
    } else if (indexPath.row == rows - 1) { // 末行
        bgView.image = [UIImage resizedImage:@"common_card_middle_background"];
        selectedBgView.image = [UIImage resizedImage:@"common_card_middle_background_highlighted"];
    } else { // 中间行
        bgView.image = [UIImage resizedImage:@"common_card_middle_background"];
        selectedBgView.image = [UIImage resizedImage:@"common_card_middle_background_highlighted"];
    }
}

- (void)setItem:(GXCommonItem *)item
{
    _item = item;
    
    // 1.设置基本数据
    self.imageView.image = [UIImage imageNamed:item.icon];
    self.textLabel.text = item.title;
    self.detailTextLabel.text = item.subTitle;
    
    // 2.设置右边的内容
    if (item.badgeValue) { // 紧急情况，右边有提醒文字
        self.bageView.badgeValue = item.badgeValue;
        self.accessoryView = self.bageView;
    } else if ([item isKindOfClass:[GXCommonArrowItem class]]) {
        self.accessoryView = self.rightArrow;
        
    } else if ([item isKindOfClass:[GXCommonSwitchItem class]]) {
        self.accessoryView = self.rightSwitch;
        
    } else if ([item isKindOfClass:[GXCommonLabelItem class]]) {
        GXCommonLabelItem *labelItem = (GXCommonLabelItem *)item;
        // 设置文字
        self.rightLabel.text = labelItem.text;
        // 根据文字计算尺寸
        self.rightLabel.size = [labelItem.text sizeWithFont:self.rightLabel.font maxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
        self.accessoryView = self.rightLabel;
    } else if ([item isKindOfClass:[GXCommonMarkItem class]]) {
        GXCommonMarkItem *markItem = (GXCommonMarkItem *)item;
        if (markItem.isMark) {
            self.accessoryView = self.rightMark;
        } else {
            self.accessoryView = nil;
        }
    } else { // 取消右边显示的内容
        self.accessoryView = nil;
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.imageView.width = 30;
    self.imageView.height = 30;
    self.imageView.y = 7;
    self.imageView.x = 10;
}

@end
