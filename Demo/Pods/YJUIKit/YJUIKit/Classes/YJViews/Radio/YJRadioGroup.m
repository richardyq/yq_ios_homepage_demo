//
//  YJRadioGroup.m
//  YJUIKit
//
//  Created by 殷全 on 2019/5/14.
//

#import "YJRadioGroup.h"
#import "YJUIKit.h"

@interface RadioButton : UIControl

@property (nonatomic, strong) UIImageView* iconImageView;
@property (nonatomic, strong) UILabel* titleLabel;

@property (nonatomic, readonly) NSString* normalImageName;
@property (nonatomic, readonly) NSString* selectedImageName;

- (id) initWithTitle:(NSString*) title
     normalImageName:(NSString*) normalImageName
   selectedImageName:(NSString*) selectedImageName;

@end

@implementation RadioButton

@synthesize  normalImageName = _normalImageName;
@synthesize selectedImageName = _selectedImageName;
- (id) initWithTitle:(NSString*) title
     normalImageName:(NSString*) normalImageName
   selectedImageName:(NSString*) selectedImageName{
    self = [super init];
    if (self) {
        self.titleLabel.text = title;
        _normalImageName = normalImageName;
        _selectedImageName = selectedImageName;
        
        [self layoutElements];
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

@interface YJRadioGroup ()

@property (nonatomic, readonly) NSArray<RadioButton*>* radioButtons;
@property (nonatomic, readonly) RadioOrientation orientation;

@property (nonatomic, readonly) NSString* normalImageName;
@property (nonatomic, readonly) NSString* selectedImageName;

@property (nonatomic, copy) RadioGroupSelectChanged changeHandler;

@end

@implementation YJRadioGroup

@synthesize selectedIndex = _selectedIndex;

- (id) initWithTitles:(NSArray<NSString*>*) titles
          orientation:(RadioOrientation) orientation
      normalImageName:(NSString*) normalImageName
    selectedImageName:(NSString*) selectedImageName
        changeHandler:(RadioGroupSelectChanged) handler{
    self = [super init];
    if (self) {
        _orientation = orientation;
        _normalImageName = normalImageName;
        _selectedImageName = selectedImageName;
        _selectedIndex = 0;
        _radioButtons = [self createButtons:titles];
        _editable = YES;
        _changeHandler = handler;
        
        [self layoutElements];
    }
    return self;
}

- (NSArray<RadioButton*>*) createButtons:(NSArray<NSString*>*) titles{
    NSMutableArray<RadioButton*>* buttons = [NSMutableArray<RadioButton*> array];
    [titles enumerateObjectsUsingBlock:^(NSString * _Nonnull title, NSUInteger idx, BOOL * _Nonnull stop) {
        RadioButton* radioButton = [[RadioButton alloc] initWithTitle:title normalImageName:self.normalImageName selectedImageName:self.selectedImageName];
        [self addSubview:radioButton];
        [buttons addObject:radioButton];
        
        radioButton.selected = (idx == self.selectedIndex);
        
        [radioButton addTarget:self action:@selector(radioButtonClicked:) forControlEvents:UIControlEventAllTouchEvents];
    }];
    
    return  [NSArray<RadioButton*> arrayWithArray:buttons];
}

- (void) layoutElements{
    switch (self.orientation) {
        case Radio_Horizontal:
        {
            __block MASViewAttribute* radioLeft = self.mas_left;
            __block MASViewAttribute* radioWidth = nil;
            [self.radioButtons enumerateObjectsUsingBlock:^(RadioButton * _Nonnull radio, NSUInteger idx, BOOL * _Nonnull stop) {
                [radio mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.bottom.equalTo(self);
                    make.left.equalTo(radioLeft);
                    if (radioWidth) {
                        make.width.equalTo(radioWidth);
                    }
                    
                    if (radio == self.radioButtons.lastObject) {
                        make.right.equalTo(self);
                    }
                }];
                
                radioLeft = radio.mas_right;
                radioWidth = radio.mas_width;
            }];
            break;
        }
        case Radio_Vertical:
        {
            NSLog(@"YJRadioGroup layoutElements Radio_Vertical");
            __block MASViewAttribute* radioTop = self.mas_top;
            __block MASViewAttribute* radioHeight = nil;
            [self.radioButtons enumerateObjectsUsingBlock:^(RadioButton * _Nonnull radio, NSUInteger idx, BOOL * _Nonnull stop) {
                [radio mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.right.equalTo(self);
                    make.top.equalTo(radioTop);
                    if (radioHeight) {
                        make.height.equalTo(radioHeight);
                    }
                    
                    if (radio == self.radioButtons.lastObject) {
                        make.bottom.equalTo(self);
                        return ;
                    }
                }];
                
                radioTop = radio.mas_bottom;
                radioHeight = radio.mas_height;
            }];
            break;
            
        }
    }
}

- (void) radioButtonClicked:(RadioButton*) radioButton{
    if (!self.editable) {
        return;
    }
    if (![radioButton isKindOfClass:[RadioButton class]]) {
        return;
    }
    NSInteger selectedIndex = [self.radioButtons indexOfObject:radioButton];
    if (selectedIndex == NSNotFound ) {
        return;
    }
    [self setSelectedIndex:selectedIndex];
    
    if (self.changeHandler) {
        self.changeHandler(selectedIndex);
    }
}

#pragma mark setttingAndGetting
- (NSInteger) selectedIndex{
    __block NSInteger selectedIndex = NSNotFound;
    [self.radioButtons enumerateObjectsUsingBlock:^(RadioButton * _Nonnull button, NSUInteger idx, BOOL * _Nonnull stop) {
        if (button.selected) {
            selectedIndex = idx;
            *stop = YES;
        }
    }];
    _selectedIndex = selectedIndex;
    return selectedIndex;
}

- (void) setSelectedIndex:(NSInteger)selectedIndex{
    if (selectedIndex < 0 || selectedIndex >= self.radioButtons.count) {
        return;
    }
    _selectedIndex = selectedIndex;
    [self.radioButtons enumerateObjectsUsingBlock:^(RadioButton * _Nonnull button, NSUInteger idx, BOOL * _Nonnull stop) {
        [button setSelected:(selectedIndex == idx)];
    }];
}


@end
