//
//  MainStartTabbarViewController.m
//  ButterflyDemo
//
//  Created by 殷全 on 2019/7/29.
//  Copyright © 2019 殷全. All rights reserved.
//

#import "MainStartTabbarViewController.h"
#import "MainTabbarView.h"

@interface MainStartTabbarViewController ()

@property (nonatomic, strong) NSArray<UIViewController*>* controllers;

@property (nonatomic, strong) MainTabbarView* tabbarView;
@property (nonatomic, strong) NSArray<MainTabbarItem*>* tabbarItems;

@end

@implementation MainStartTabbarViewController

- (void) dealloc{
    [self.tabbarView removeObserver:self forKeyPath:@"selectedIndex"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setViewControllers:self.controllers];
    
    [self layoutElements];
    
    [self.tabbarView setItems:self.tabbarItems];
    
    //[self.tabbarView setBadge:@"12" index:2];
}

- (void) layoutElements{
    [self.tabbarView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(self.tabBar);
    }];
}

#pragma mark settingAndGetting
- (NSArray<UIViewController*>*) controllers{
    if (!_controllers) {
        NSArray<Class>* classes = @[NSClassFromString(@"MainStartViewController"),
                                    NSClassFromString(@"HistoryStartViewController"),
                                    NSClassFromString(@"DiscoveryStartViewController"),
                                    NSClassFromString(@"PersonStartViewController")];
        NSMutableArray<UINavigationController*>* controllers = [NSMutableArray<UINavigationController*> array];
        [classes enumerateObjectsUsingBlock:^(Class  _Nonnull class, NSUInteger idx, BOOL * _Nonnull stop) {
            UIViewController* controller = [[class alloc] init];
            UINavigationController* navigationController = [[BaseNavigationViewController alloc] initWithRootViewController:controller];
            navigationController.navigationBar.translucent = NO;
            [controllers addObject:navigationController];
        }];
        
        _controllers = [NSArray<UIViewController*> arrayWithArray:controllers];
    }
    return _controllers;
}

- (MainTabbarView*) tabbarView{
    if (!_tabbarView) {
        _tabbarView = [[MainTabbarView alloc] init];
        [self.view addSubview:_tabbarView];
        [_tabbarView setCenterImage:[UIImage imageNamed:@"main_tab_center"]];
        [_tabbarView addObserver:self forKeyPath:@"selectedIndex" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
    }
    return _tabbarView;
}

- (NSArray<MainTabbarItem*>*) tabbarItems{
    if (!_tabbarItems) {
        NSMutableArray<MainTabbarItem*>* items = [NSMutableArray<MainTabbarItem*> array];
        NSArray<NSString*>* names = @[@"首页", @"历史", @"发现", @"我的"];
        NSArray<UIImage*>* icons = @[[UIImage imageNamed:@"main_tab_home_high"],
                                     [UIImage imageNamed:@"main_tab_history_high"],
                                     [UIImage imageNamed:@"main_tab_dicovery_high"],
                                     [UIImage imageNamed:@"main_tab_person_high"]];
        [names enumerateObjectsUsingBlock:^(NSString * _Nonnull name, NSUInteger idx, BOOL * _Nonnull stop) {
            MainTabbarItem* item = [[MainTabbarItem alloc] initWithImage:icons[idx] title:name];
            [items addObject:item];
        }];
        
        _tabbarItems = [NSArray<MainTabbarItem*> arrayWithArray:items];
    }
    return _tabbarItems;
}

#pragma mark - observice
- (void) observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    if (object == self.tabbarView) {
        if ([keyPath isEqualToString:@"selectedIndex"]) {
            NSNumber* value = [object valueForKey:keyPath];
            NSInteger selectedIndex = value.integerValue;
            [self setSelectedIndex:selectedIndex];
        }
    }
}
@end
