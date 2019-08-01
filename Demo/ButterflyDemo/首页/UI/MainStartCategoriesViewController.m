//
//  MainStartCategoriesViewController.m
//  ButterflyDemo
//
//  Created by 殷全 on 2019/8/1.
//  Copyright © 2019 殷全. All rights reserved.
//

#import "MainStartCategoriesViewController.h"

@interface MainStartCategoriesViewController ()

@property (nonatomic, strong) NSArray<IconButton*>* categoryButtons;
@property (nonatomic, strong) UIView* headlineView;

@end

@implementation MainStartCategoriesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self layoutElements];
}

- (void) layoutElements{
    
    __block MASViewAttribute* buttonLeft = self.view.mas_left;
    __block MASViewAttribute* buttonWidth = nil;
    [self.categoryButtons enumerateObjectsUsingBlock:^(IconButton * _Nonnull button, NSUInteger idx, BOOL * _Nonnull stop) {
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(buttonLeft);
            make.top.equalTo(self.view);
            make.height.mas_equalTo(@68);
            if (buttonWidth) {
                make.width.equalTo(buttonWidth);
            }
            if (button == self.categoryButtons.lastObject) {
                make.right.equalTo(self.view);
            }
        }];
        
        buttonLeft = button.mas_right;
        buttonWidth = button.mas_width;
    }];
    
    [self.headlineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.categoryButtons.lastObject.mas_bottom);
        make.left.right.bottom.equalTo(self.view);
        make.height.mas_equalTo(@31);
    }];
    
}

#pragma mark - settingAndGetting
- (NSArray<IconButton*>*) categoryButtons{
    if (!_categoryButtons) {
        NSArray<NSString*>* titles = @[@"经典", @"必听", @"私人", @"精品", @"新品"];
        NSArray<NSString*>* iconNames = @[@"bookimg", @"lifering", @"rocket", @"sun", @"telescope"];
        NSMutableArray<IconButton*>* buttons = [NSMutableArray<IconButton*> array];
        [titles enumerateObjectsUsingBlock:^(NSString * _Nonnull title, NSUInteger idx, BOOL * _Nonnull stop) {
            IconButton* button = [[IconButton alloc] initWithIconName:iconNames[idx] title:title];
            [self.view addSubview:button];
            [buttons addObject:button];
        }];
        _categoryButtons = [NSArray<IconButton*> arrayWithArray:buttons];
    }
    return _categoryButtons;
}

- (UIView*) headlineView{
    if (!_headlineView) {
        _headlineView = [UIView new];
        [self.view addSubview:_headlineView];
    }
    return _headlineView;
}

@end
