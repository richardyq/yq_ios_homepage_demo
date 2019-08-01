//
//  UIView+BadgeEx.m
//  ButterflyDemo
//
//  Created by 殷全 on 2019/7/29.
//  Copyright © 2019 殷全. All rights reserved.
//

#import "UIView+BadgeEx.h"

NSString* const kRedColor = @"E84536";
NSInteger const kBadgeTag = 0x8632;

@interface BadgeView : UIView

//@property (nonatomic, strong) UIView* badgeview;
@property (nonatomic, strong) UILabel* badgeLabel;

@end

@implementation BadgeView

- (id) initWithBadge:(NSString*) badge{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor colorWithHexString:kRedColor];
        if (badge && badge.length > 0) {
            [self setCornerRadius:6.5];
            [self layoutBadge];
            self.badgeLabel.text = badge;
        }
        else{
            [self setCornerRadius:2.5];
        }
    }
    return self;
}

- (void) layoutBadge{
    [self.badgeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
        make.width.lessThanOrEqualTo(self).offset(-5);
    }];
    
}

#pragma mark - settingAndGetting
- (UILabel*) badgeLabel{
    if (!_badgeLabel) {
        _badgeLabel = [self addLabel:[UIColor whiteColor] textSize:10];
        _badgeLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _badgeLabel;
}
@end

@implementation UIView (BadgeEx)

- (void) addBadge:(NSString *)badge{
    BadgeView* badgeview = [self badgeview];
    if (badgeview) {
        [badgeview removeFromSuperview];
    }
    
    badgeview = [[BadgeView alloc] initWithBadge:badge];
    badgeview.tag = kBadgeTag;
    [self addSubview:badgeview];
    __block UIView* badgeRootView = [self badgeRootView];
    if (badge && badge.length > 0) {
        [badgeview mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(@13);
            make.width.mas_greaterThanOrEqualTo(@13);
            make.top.equalTo(badgeRootView);
            make.centerX.equalTo(badgeRootView.mas_right);
        }];
    }
    else{
        [badgeview mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.right.equalTo(badgeRootView);
            make.size.mas_equalTo(CGSizeMake(5, 5));
        }];
    }
}

- (void) closeBadege{
    BadgeView* badgeview = [self badgeview];
    if (badgeview) {
        [badgeview removeFromSuperview];
    }
}

- (BadgeView*) badgeview{
    BadgeView* badgeview = [self viewWithTag:kBadgeTag];
    return badgeview;
}

- (UIView*) badgeRootView{
    return self;
}

@end
