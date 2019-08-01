//
//  MainStartHeaderView.m
//  ButterflyDemo
//
//  Created by 殷全 on 2019/7/31.
//  Copyright © 2019 殷全. All rights reserved.
//

#import "MainStartHeaderView.h"

@interface MainStartSearchControl : UIControl

@property (nonatomic, strong) UIImageView* iconImageView;

@end

@implementation MainStartSearchControl

- (id) init{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor colorWithHexString:@"79797979"];
        [self setCornerRadius:14 color:[UIColor whiteColor] boarderwidth:1];
        [self layoutElements];
    }
    return self;
}

- (void) layoutElements{
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(8.5);
        make.centerY.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(13, 13));
    }];
}

#pragma mark - settingAndGetting
- (UIImageView*) iconImageView{
    if (!_iconImageView) {
        _iconImageView = [self addImageView:@"search_icon"];
    }
    return _iconImageView;
}

@end

@interface MainStartHeaderView ()

@end

@implementation MainStartHeaderView

- (id) init{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        [self layoutElements];
    }
    return self;
}

- (void) layoutElements{
    [self.searchControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(12.5);
        make.bottom.equalTo(self).offset(-7);
        make.height.mas_equalTo(@28);
        make.right.equalTo(self.historyButton.mas_left).offset(-25);
    }];
    
    [self.historyButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(28, 28));
        make.centerY.equalTo(self.searchControl);
        make.right.equalTo(self.filterButton.mas_left).offset(-14);
    }];
    
    [self.filterButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(28, 28));
        make.centerY.equalTo(self.searchControl);
        make.right.equalTo(self).offset(-12.5);
    }];
}

#pragma mark - settingAndGetting
- (MainStartSearchControl*) searchControl{
    if (!_searchControl) {
        _searchControl = [[MainStartSearchControl alloc] init];
        [self addSubview:_searchControl];
    }
    return _searchControl;
}

- (UIButton*) historyButton{
    if (!_historyButton) {
        _historyButton = [self addButton:UIButtonTypeCustom];
        [_historyButton setImage:[UIImage imageNamed:@"closeicon"] forState:UIControlStateNormal];
    }
    return _historyButton;
}

- (UIButton*) filterButton{
    if (!_filterButton) {
        _filterButton = [self addButton:UIButtonTypeCustom];
        [_filterButton setImage:[UIImage imageNamed:@"filter_icon"] forState:UIControlStateNormal];
    }
    return _filterButton;
}

@end
