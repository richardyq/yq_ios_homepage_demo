//
//  IconButton.m
//  ButterflyDemo
//
//  Created by 殷全 on 2019/8/1.
//  Copyright © 2019 殷全. All rights reserved.
//

#import "IconButton.h"

@interface IconButton ()

@property (nonatomic, strong) UIImageView* iconImageView;
@property (nonatomic, strong) UILabel* titleLabel;

@end

@implementation IconButton

- (id) initWithIconName:(NSString*) iconName title:(NSString*) title{
    self = [super init];
    if (self) {
        self.titleLabel.text = title;
        self.iconImageView.image = [UIImage imageNamed:iconName];
        
        [self layoutElements];
    }
    return self;
}

- (void) layoutElements{
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(23, 23));
        make.centerX.equalTo(self);
        make.centerY.equalTo(self).offset(-10);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self.iconImageView.mas_bottom).offset(5);
        make.width.lessThanOrEqualTo(self).offset(-3);
    }];
}

#pragma mark - settingAndGetting
- (UILabel*) titleLabel{
    if (!_titleLabel) {
        _titleLabel = [self addLabel:[UIColor commonTextColor] textSize:13];
    }
    return _titleLabel;
}

- (UIImageView*) iconImageView{
    if (!_iconImageView) {
        _iconImageView = [self addImageView];
    }
    return _iconImageView;
}

@end
