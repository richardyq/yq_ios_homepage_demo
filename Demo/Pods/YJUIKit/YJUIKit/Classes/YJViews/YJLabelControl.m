//
//  YJLabelControl.m
//  YJUIKit
//
//  Created by 殷全 on 2019/5/7.
//

#import "YJLabelControl.h"
#import "YJUIKit.h"

@interface YJLabelControl ()

@property (nonatomic, strong) UILabel* label;

@end

@implementation YJLabelControl

- (id) initWithPlaceholder:(NSString*) placeholder{
    self = [super init];
    if (self) {
        _placeholder = placeholder;
        [self layoutElements];
    }
    return self;
}

- (void) layoutElements{
    [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self).insets(UIEdgeInsetsMake(3, 4, 3, 4));
    }];
}
#pragma mark - settingAndGetting
- (UILabel*) label{
    if (!_label) {
        _label = [self addLabel:[UIColor commonGrayTextColor] textSize:15];
        
        if (self.text && self.text.length > 0) {
            _label.textColor = [UIColor commonTextColor];
            //_label.text = self.text;
        }
        else{
            _label.text = self.placeholder;
        }
    }
    return _label;
}

- (void) setText:(NSString *)text{
    if (text && text.length > 0) {
        _label.textColor = [UIColor commonTextColor];
        _label.text = text;
    }
    else{
        _label.text = self.placeholder;
    }
}

- (NSString*) text{
    return self.label.text;
}

@end
