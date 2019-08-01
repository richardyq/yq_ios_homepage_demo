//
//  CheckBoxControl.m
//  YJUIKit
//
//  Created by 殷全 on 2019/5/14.
//

#import "CheckBoxControl.h"
#import "YJUIKit.h"

@interface CheckBoxControl ()

@property (nonatomic, strong) UIImageView* iconImageView;
@property (nonatomic, strong) UILabel* titleLabel;

@property (nonatomic, readonly) NSString* normalImageName;
@property (nonatomic, readonly) NSString* selectedImageName;

@property (nonatomic, copy) CheckBoxHandler selectedHandler;
@end

@implementation CheckBoxControl

@synthesize  normalImageName = _normalImageName;
@synthesize selectedImageName = _selectedImageName;

- (id) initWithTitle:(NSString*) title
     normalImageName:(NSString*) normalImageName
   selectedImageName:(NSString*) selectedImageName
             handler:(CheckBoxHandler) handler{
    self = [super init];
    if (self) {
        self.titleLabel.text = title;
        _normalImageName = normalImageName;
        _selectedImageName = selectedImageName;
        _selectedHandler = handler;
        
        [self layoutElements];
        [self addTarget:self action:@selector(clickHanlder) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

- (void) layoutElements{

    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(15, 15));
        make.centerY.equalTo(self);
        make.left.equalTo(self).offset(7.5);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.iconImageView.mas_right).offset(7);
        make.centerY.equalTo(self);
        make.right.lessThanOrEqualTo(self).offset(-3);
    }];
}

#pragma mark - settingAndGetting
- (UIImageView*) iconImageView{
    if (!_iconImageView) {
        _iconImageView = [self addImageView:self.normalImageName];
    }
    return _iconImageView;
}

- (UILabel*) titleLabel{
    if (!_titleLabel) {
        _titleLabel = [self addLabel];
        _titleLabel.font = [UIFont systemFontOfSize:14];
        _titleLabel.textColor = [UIColor commonTextColor];
    }
    return _titleLabel;
}

- (void) clickHanlder{
    //NSLog(@"checkbox clickHanlder ...");
    self.selected = !self.selected;
    
    if (self.selectedHandler) {
        self.selectedHandler(self.selected);
    }
}

- (void) setSelected:(BOOL)selected{
    [super setSelected:selected];
    if (selected) {
        [self.iconImageView setImage:[UIImage imageNamed:self.selectedImageName]];
    }
    else{
        [self.iconImageView setImage:[UIImage imageNamed:self.normalImageName]];
    }
}


@end
