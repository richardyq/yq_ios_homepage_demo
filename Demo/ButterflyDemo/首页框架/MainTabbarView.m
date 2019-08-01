//
//  MainTabbarView.m
//  ButterflyDemo
//
//  Created by 殷全 on 2019/7/29.
//  Copyright © 2019 殷全. All rights reserved.
//

#import "MainTabbarView.h"

@implementation MainTabbarItem

- (id) initWithImage:(UIImage*) image title:(NSString*) title{
    self = [super init];
    if (self) {
        _iconImage = image;
        _title = title;
    }
    return self;
}

@end

@interface MainTabbarCell : UIControl

@property (nonatomic, strong) UIImageView* iconImageView;
@property (nonatomic, strong) UILabel* titleLabel;

- (id) initWithItem:(MainTabbarItem*) item;

@end

@implementation MainTabbarCell

- (id) initWithItem:(MainTabbarItem*) item{
    self = [super init];
    if (self) {
        [self layoutElements];
        self.titleLabel.text = item.title;
        self.iconImageView.image = item.iconImage;
    }
    return self;
}

- (void) layoutElements{
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(21, 21));
        make.centerX.equalTo(self);
        make.top.equalTo(self).offset(5.5);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self.iconImageView.mas_bottom).offset(3);
        make.width.lessThanOrEqualTo(self).offset(-7);
    }];
}

- (UIView*) badgeRootView{
    return self.iconImageView;
}
#pragma mark - settingAndGetting
- (UIImageView*) iconImageView{
    if (!_iconImageView) {
        _iconImageView = [self addImageView];
    }
    return _iconImageView;
}

- (UILabel*) titleLabel{
    if (!_titleLabel) {
        _titleLabel = [self addLabel:[UIColor whiteColor] textSize:12];
    }
    return _titleLabel;
}

- (void) setSelected:(BOOL)selected{
    [super setSelected:selected];
    UIImage* icon = self.iconImageView.image;
    if (selected) {
        self.iconImageView.image = [icon imageWithColor:[UIColor whiteColor]];
        self.titleLabel.textColor = [UIColor whiteColor];
    }
    else{
        self.iconImageView.image = [icon imageWithColor:[UIColor commonGrayTextColor]];
        self.titleLabel.textColor = [UIColor commonGrayTextColor];
    }
}
@end

@interface MainTabbarView ()

@property (nonatomic, readonly) NSArray<MainTabbarCell*>* cells;
@property (nonatomic, readonly) UIButton* centerButton;
@end

@implementation MainTabbarView

- (id) init{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor mainThemeColor];
    }
    return self;
}

- (void) createCells{
    if (self.cells) {
        [self.cells enumerateObjectsUsingBlock:^(MainTabbarCell * _Nonnull cell, NSUInteger idx, BOOL * _Nonnull stop) {
            [cell removeFromSuperview];
        }];
        _cells = nil;
    }
    
    NSMutableArray<MainTabbarCell*>* cells = [NSMutableArray<MainTabbarCell*> array];
    
    [self.items enumerateObjectsUsingBlock:^(MainTabbarItem * _Nonnull item, NSUInteger idx, BOOL * _Nonnull stop) {
        MainTabbarCell* cell = [[MainTabbarCell alloc] initWithItem:item];
        [self addSubview:cell];
        [cells addObject:cell];
        
        [cell setSelected:(idx == self.selectedIndex)];
        
        [cell addTarget:self action:@selector(cellClicked:) forControlEvents:UIControlEventTouchUpInside];
    }];
    
    _cells = [NSArray<MainTabbarCell*> arrayWithArray:cells];
    if (!self.centerImage) {
        [self layoutCells];
    }
    else{
        [self layoutCellWithCenterButton];
    }
    
}

- (void) layoutCells{
    __block MASViewAttribute* cellLeft = self.mas_left;
    __block MASViewAttribute* cellWidth = nil;
    [self.cells enumerateObjectsUsingBlock:^(MainTabbarCell * _Nonnull cell, NSUInteger idx, BOOL * _Nonnull stop) {
        [cell mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(self);
            make.left.equalTo(cellLeft);
            if (cellWidth) {
                make.width.equalTo(cellWidth);
            }
            if (cell == self.cells.lastObject) {
                make.right.equalTo(self);
            }
            
           
        }];
        cellLeft = cell.mas_right;
        cellWidth = cell.mas_width;
    }];
}

- (void) layoutCellWithCenterButton{
    [self.centerButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(64, 64));
        make.centerX.equalTo(self);
        make.top.equalTo(self).offset(-16);
    }];
    
    __block MASViewAttribute* cellLeft = self.mas_left;
    __block MASViewAttribute* cellWidth = nil;
    [self.cells enumerateObjectsUsingBlock:^(MainTabbarCell * _Nonnull cell, NSUInteger idx, BOOL * _Nonnull stop) {
        if (idx >= self.cells.count/2) {
            *stop = YES;
            return ;
        }
        [cell mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(self);
            make.left.equalTo(cellLeft);
            if (cellWidth) {
                make.width.equalTo(cellWidth);
            }
            
            if (idx == (self.cells.count)/2 - 1) {
                make.right.equalTo(self.centerButton.mas_left);
            }
            
        }];
        
        cellLeft = cell.mas_right;
        cellWidth = cell.mas_width;
        
        [cell setContentHuggingPriority:UILayoutPriorityDefaultLow
                                  forAxis:UILayoutConstraintAxisHorizontal];
    }];
    
    cellLeft = self.centerButton.mas_right;
    [self.cells enumerateObjectsUsingBlock:^(MainTabbarCell * _Nonnull cell, NSUInteger idx, BOOL * _Nonnull stop) {
        if (idx < self.cells.count/2) {
            return ;
        }
        [cell mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(self);
            make.left.equalTo(cellLeft);
            if (cellWidth) {
                make.width.equalTo(cellWidth);
            }
            
            if (cell == self.cells.lastObject) {
                make.right.equalTo(self);
            }
            
        }];
        cellLeft = cell.mas_right;
        cellWidth = cell.mas_width;
    }];
    
    
    [self.centerButton setContentHuggingPriority:UILayoutPriorityDefaultHigh
                                         forAxis:UILayoutConstraintAxisHorizontal];
}

- (void) setSelectedIndex:(NSInteger)selectedIndex{
    _selectedIndex = selectedIndex;
    
    [self.cells enumerateObjectsUsingBlock:^(MainTabbarCell * _Nonnull cell, NSUInteger idx, BOOL * _Nonnull stop) {
        [cell setSelected:(idx == selectedIndex)];
    }];
}

- (void) setBadge:(NSString*) badge index:(NSInteger) index{
    if (index < 0 || index >= self.cells.count) {
        return;
    }
    MainTabbarCell* cell = self.cells[index];
    
    [cell addBadge:badge];
    
    NSArray<UIView*>* subviews = [cell subviews];
    [subviews enumerateObjectsUsingBlock:^(UIView * _Nonnull view, NSUInteger idx, BOOL * _Nonnull stop) {
        NSLog(@"cell subview: %@", [view class]);
    }];
}

#pragma mark - settingAndGetting
- (void) setCenterImage:(UIImage *)centerImage{
    _centerImage = centerImage;
    if (centerImage) {
        _centerButton = [self addButton:UIButtonTypeCustom];
        [_centerButton setImage:self.centerImage forState:UIControlStateNormal];
        [_centerButton setBackgroundColor:[UIColor mainThemeColor]];
        [_centerButton setCornerRadius:32 color:[UIColor mainThemeColor] boarderwidth:1.5];
    }
}

- (void) setItems:(NSArray<MainTabbarItem *> *)items{
    _items = items;
    
    [self createCells];
}

#pragma mark events
- (void) cellClicked:(id) sender{
    if (![sender isKindOfClass:[MainTabbarCell class]]) {
        return;
    }
    NSInteger index = [self.cells indexOfObject:sender];
    if (index == NSNotFound) {
        return;
    }
    [self setSelectedIndex:index];
}

@end
