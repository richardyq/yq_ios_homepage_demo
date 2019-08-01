//
//  MainStartViewController.m
//  ButterflyDemo
//
//  Created by 殷全 on 2019/7/29.
//  Copyright © 2019 殷全. All rights reserved.
//

#import "MainStartViewController.h"
#import "MainStartHeaderView.h"
#import "MainStartBannerViewController.h"
#import "MainStartCategoriesViewController.h"


NSString* const StartBannerTableCellIdentifier = @"StartBannerTableCell";
NSString* const StartCategoryTableCellIdentifier = @"StartCategoryTableCell";

typedef NS_ENUM(NSUInteger, MainStartTableSection) {
    MainStart_BannerSection,
    MainStart_CategorySection,
    MainStartSectionCount,
};

@interface MainStartViewController ()
<MainStartBannerDataSource, UITableViewDataSource>

@property (nonatomic, strong) MainStartHeaderView* nagigationHeaderView;
@property (nonatomic, strong) UIImageView* navigationBackgroundImageView;
@property (nonatomic, strong) UIImageView* navigationColorImageView;
@property (nonatomic, strong) MainStartBannerViewController* bannerViewController;
@property (nonatomic, strong) NSArray<MainStartBannerItem*>* bannerItems;

@property (nonatomic, strong) MainStartCategoriesViewController* categoryViewController;
@property (nonatomic, strong) UITableView* tableview;

@end

@implementation MainStartViewController

- (void) dealloc{
    [self.bannerViewController removeObserver:self forKeyPath:@"bannerColor"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"Butterfly";
    [self setFd_prefersNavigationBarHidden:YES];
    [self layoutElements];
    
    [self.bannerViewController addObserver:self forKeyPath:@"bannerColor" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
    
}

- (void) layoutElements{
    __block CGFloat navigationHeight = 64;
    if (isPhoneX) {
        navigationHeight += 20;
    }
    
    [self.navigationBackgroundImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.view);
        make.height.mas_equalTo(@154);
    }];
    
    [self.navigationColorImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.navigationBackgroundImageView);
    }];
    
    [self.nagigationHeaderView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.view);
        make.height.mas_equalTo(@(navigationHeight));
    }];
    
    [self.tableview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(self.nagigationHeaderView.mas_bottom);
    }];
    
}

#pragma mark - settingAndGetting
- (UIImageView*) navigationBackgroundImageView{
    if (!_navigationBackgroundImageView) {
        _navigationBackgroundImageView = [self.view addImageView:@"banner_bg"];
    }
    return _navigationBackgroundImageView;
}

- (UIImageView*) navigationColorImageView{
    if (!_navigationColorImageView) {
        _navigationColorImageView = [self.view addImageView];
    }
    return _navigationColorImageView;
}

- (MainStartHeaderView*) nagigationHeaderView{
    if (!_nagigationHeaderView) {
        _nagigationHeaderView = [[MainStartHeaderView alloc] init];
        [self.view addSubview:_nagigationHeaderView];
    }
    return _nagigationHeaderView;
}

- (UITableView*) tableview{
    if (!_tableview) {
        _tableview = [[UITableView alloc] init];
        [self.view addSubview:_tableview];
        _tableview.dataSource = self;
        _tableview.backgroundColor = [UIColor clearColor];
    }
    return _tableview;
}

- (MainStartBannerViewController*) bannerViewController{
    if (!_bannerViewController) {
        _bannerViewController = [[MainStartBannerViewController alloc] init];
        [self addChildViewController:_bannerViewController];
        //[_bannerView setDataSource:self];
    }
    return _bannerViewController;
}

- (MainStartCategoriesViewController*) categoryViewController{
    if (!_categoryViewController) {
        _categoryViewController = [[MainStartCategoriesViewController alloc] init];
        [self addChildViewController:_categoryViewController];
    }
    return _categoryViewController;
}

- (NSArray<MainStartBannerItem*>*) bannerItems{
    if (!_bannerItems) {
        NSArray<NSString*>* imageUrls = @[@"http://img1.imgtn.bdimg.com/it/u=2282886292,1180391925&fm=26&gp=0.jpg", @"http://img.aiimg.com/uploads/allimg/161030/1-161030004542.jpg", @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1564571708604&di=03493a4d0f18c2b43cbf0d82c1e7d292&imgtype=0&src=http%3A%2F%2Fpic74.nipic.com%2Ffile%2F20150807%2F14145720_114538071000_2.jpg", @"http://img02.tooopen.com/images/20160427/tooopen_sy_160705159562.jpg"];
        NSMutableArray<MainStartBannerItem*>* items = [NSMutableArray<MainStartBannerItem*> array];
        [imageUrls enumerateObjectsUsingBlock:^(NSString * _Nonnull imageUrl, NSUInteger idx, BOOL * _Nonnull stop) {
            MainStartBannerItem* item = [[MainStartBannerItem alloc] initWithImageUrl:imageUrl];
            [items addObject:item];
        }];
        
        _bannerItems = [NSArray<MainStartBannerItem*> arrayWithArray:items];
    }
    return _bannerItems;
}

#pragma mark - table view data source
- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
    return MainStartSectionCount;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    switch (section) {
        case MainStart_BannerSection:
        case MainStart_CategorySection:{
            return 1;
            break;
        }
    }
    return 0;
}

- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell* cell = nil;
    switch (indexPath.section) {
        case MainStart_BannerSection:{
            cell = [self startBannerTableViewCell];
            break;
        }
        case MainStart_CategorySection:{
            cell = [self startCategoryTableViewCell];
            break;
        }
    }
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MainStartTableViewCell"];
    }
    return cell;
}

- (UITableViewCell*) startBannerTableViewCell{
    UITableViewCell* cell = [self.tableview dequeueReusableCellWithIdentifier:StartBannerTableCellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:StartBannerTableCellIdentifier];
        cell.backgroundColor = [UIColor clearColor];
        cell.contentView.backgroundColor = [UIColor clearColor];
        [cell.contentView addSubview:self.bannerViewController.view];
        
        [self.bannerViewController.view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(cell.contentView);
        }];
        
        self.bannerViewController.dataSource = self;
    }
    return cell;
}

- (UITableViewCell*) startCategoryTableViewCell{
    UITableViewCell* cell = [self.tableview dequeueReusableCellWithIdentifier:StartCategoryTableCellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:StartCategoryTableCellIdentifier];
        [cell.contentView addSubview:self.categoryViewController.view];
        cell.contentView.backgroundColor = [UIColor whiteColor];
        [self.categoryViewController.view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(cell.contentView);
        }];
    }
    return cell;
}

#pragma mark - MainStartBannerDataSource
- (NSInteger) numberOfBannerItems{
    return self.bannerItems.count;
}

- (MainStartBannerItem*) itemOfBanner:(NSInteger) index{
    return self.bannerItems[index];
}

#pragma mark -
- (void) observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    if (object == self.bannerViewController) {
        if ([keyPath isEqualToString:@"bannerColor"]) {
            UIColor* bannerColor = self.bannerViewController.bannerColor;
            if (bannerColor) {
                self.navigationColorImageView.backgroundColor = bannerColor;
            }
        }
    }
}
@end
