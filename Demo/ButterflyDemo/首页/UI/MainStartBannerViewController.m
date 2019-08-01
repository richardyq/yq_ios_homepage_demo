//
//  MainStartBannerViewController.m
//  ButterflyDemo
//
//  Created by 殷全 on 2019/7/31.
//  Copyright © 2019 殷全. All rights reserved.
//

#import "MainStartBannerViewController.h"

@implementation MainStartBannerItem

- (id) initWithImageUrl:(NSString*) imageUrl{
    self = [super init];
    if (self) {
        _imageUrl = imageUrl;
    }
    return self;
}

@end

@interface MainStartBannerContentViewController : UIViewController

@property (nonatomic, readonly) MainStartBannerItem* bannerItem;
@property (nonatomic, strong) UIImageView* backgroundImageView;
@property (nonatomic, strong) UIColor* imageColor;

- (id) initWithBannerItem:(MainStartBannerItem*) bannerItem;

@end

@implementation MainStartBannerContentViewController

- (id) initWithBannerItem:(MainStartBannerItem*) bannerItem{
    self = [super init];
    if (self) {
        _bannerItem = bannerItem;
    }
    return self;
}

- (void) viewDidLoad{
    [super viewDidLoad];
    [self layoutElements];
}

- (void) layoutElements{
    [self.backgroundImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

#pragma mark - settingAndGetting
- (UIImageView*) backgroundImageView{
    if (!_backgroundImageView) {
        _backgroundImageView = [self.view addImageView:@"defaultImage"];
        NSURL* url = [NSURL URLWithString:self.bannerItem.imageUrl];
        WEAK_SELF(weakSelf)
        [_backgroundImageView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"defaultImage"] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
            if (!weakSelf) {
                return ;
            }
            [weakSelf imageLoaded];
        }];
    }
    return _backgroundImageView;
}

- (void) imageLoaded{
    UIImage* image = self.backgroundImageView.image;
    UIColor* color = [image colorAtPixel:CGPointMake(1, 1)];
    NSString* colorHex = [color hexString];
    if (colorHex.length == 6) {
        colorHex = [colorHex stringByAppendingString:@"88"];
    }
    else if (colorHex.length == 8){
        colorHex = [colorHex stringByReplacingCharactersInRange:NSMakeRange(6, 2) withString:@"88"];
    }
    if (!_imageColor) {
        //_imageColor = [UIColor colorWithHexString:colorHex];
        [self setImageColor:[UIColor colorWithHexString:colorHex]];
    }
}
@end


@interface MainStartBannerViewController ()
<UIPageViewControllerDataSource, UIPageViewControllerDelegate>{
    NSTimer* changeNextTimer;
}
@property (nonatomic, strong) UIPageViewController* bannerPageController;
@property (nonatomic, readonly) NSMutableArray<MainStartBannerContentViewController*>* contentControllers;
@property (nonatomic, strong) UIPageControl* pageControl;
@property (nonatomic, strong) UIView* pagecontrolview;
@end

@implementation MainStartBannerViewController

- (void) dealloc{
    if (changeNextTimer) {
        [changeNextTimer invalidate];
        changeNextTimer = nil;
    }
    
    [self.contentControllers enumerateObjectsUsingBlock:^(MainStartBannerContentViewController * _Nonnull controller, NSUInteger idx, BOOL * _Nonnull stop) {
        [controller removeObserver:self forKeyPath:@"imageColor"];
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor clearColor];
    [self layoutElements];
    
    changeNextTimer = [NSTimer scheduledTimerWithTimeInterval:4 target:self selector:@selector(changeToNextPage) userInfo:nil repeats:YES];
}

- (void) layoutElements{
    [self.bannerPageController.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).insets(UIEdgeInsetsMake(10, 15, 10, 15));
        make.height.mas_offset(@132);
    }];
    
    [self.pagecontrolview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view).offset(-23);
        make.height.mas_equalTo(@16);
        make.right.equalTo(self.view).offset(-24);
    }];
    
    [self.pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.pagecontrolview).insets(UIEdgeInsetsMake(0, 5, 0, 5));
    }];
}

#pragma mark - settingAndGetting
- (UIPageViewController*) bannerPageController{
    if (!_bannerPageController) {
        _bannerPageController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
        [self addChildViewController:_bannerPageController];
        [self.view addSubview:_bannerPageController.view];
        
        [_bannerPageController.view setCornerRadius:7];
        
        _bannerPageController.dataSource = self;
        _bannerPageController.delegate = self;
    }
    return _bannerPageController;
}

- (UIView*) pagecontrolview{
    if (!_pagecontrolview) {
        _pagecontrolview = [UIView new];
        [self.view addSubview:_pagecontrolview];
        _pagecontrolview.backgroundColor = [UIColor colorWithHexString:@"88888888"];
        [_pagecontrolview setCornerRadius:8];
    }
    return _pagecontrolview;
}

- (UIPageControl*) pageControl{
    if (!_pageControl) {
        _pageControl = [[UIPageControl alloc] init];
        [self.pagecontrolview addSubview:_pageControl];
        
        [_pageControl setCurrentPageIndicatorTintColor:[UIColor mainThemeColor]];
    }
    return _pageControl;
}

- (void) setDataSource:(id<MainStartBannerDataSource>)dataSource{
    _dataSource = dataSource;
    [self performSelector:@selector(reloadData) withObject:nil afterDelay:0.04];
}

- (void) reloadData{
    _contentControllers = [NSMutableArray<MainStartBannerContentViewController*> array];
    if (!self.dataSource) {
        return;
    }
    if (![self.dataSource respondsToSelector:@selector(numberOfBannerItems)] ||
        ![self.dataSource respondsToSelector:@selector(itemOfBanner:)]) {
        return;
    }
    
    NSInteger count = [self.dataSource numberOfBannerItems];
    if (count == 0) {
        return;
    }
    for (NSInteger index = 0; index < count; ++index) {
        MainStartBannerItem* item = [self.dataSource itemOfBanner:index];
        MainStartBannerContentViewController* controller = [[MainStartBannerContentViewController alloc] initWithBannerItem:item];
        [_contentControllers addObject:controller];
        
        [controller addObserver:self forKeyPath:@"imageColor" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
    }
    
    [self.bannerPageController setViewControllers:@[self.contentControllers.firstObject] direction:UIPageViewControllerNavigationDirectionReverse animated:NO completion:nil];
    
    [self.pageControl setNumberOfPages:count];
}

#pragma mark - UIPageViewControllerDataSource
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController{
    NSInteger controlIndex = [self.contentControllers indexOfObject:viewController];
    if ( controlIndex == NSNotFound) {
        return nil;
    }
    if (controlIndex == 0) {
        return self.contentControllers.lastObject;
    }
    
    return self.contentControllers[--controlIndex];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController{
    
    NSInteger controlIndex = [self.contentControllers indexOfObject:viewController];
    if (controlIndex == NSNotFound ) {
        return nil;
    }
    if (controlIndex == (self.contentControllers.count - 1)) {
        return self.contentControllers.firstObject;
    }
    
    return self.contentControllers[++controlIndex];
}

#pragma mark - page view controller delegate


- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray<UIViewController *> *)previousViewControllers transitionCompleted:(BOOL)completed{
  
    MainStartBannerContentViewController* contentController = (MainStartBannerContentViewController*) pageViewController.viewControllers.firstObject;
    NSInteger index = [self.contentControllers indexOfObject:contentController];
    NSLog(@"didFinishAnimating %ld", index);
    UIColor* color = contentController.imageColor;
    if (color) {
        [self setBannerColor:color];
    }
    
    if (changeNextTimer) {
        [changeNextTimer invalidate];
        changeNextTimer = nil;
    }
    
    [self pageChanged];
    
    changeNextTimer = [NSTimer scheduledTimerWithTimeInterval:4 target:self selector:@selector(changeToNextPage) userInfo:nil repeats:YES];
}

- (void) changeToNextPage{
    MainStartBannerContentViewController* contentController = (MainStartBannerContentViewController*) self.bannerPageController.viewControllers.firstObject;
    NSInteger index = [self.contentControllers indexOfObject:contentController];
    MainStartBannerContentViewController* nextController = nil;
    if (contentController == self.contentControllers.lastObject) {
        nextController = self.contentControllers.firstObject;
    }
    else {
        nextController = self.contentControllers[index + 1];
    }
    
    [self.bannerPageController setViewControllers:@[nextController] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
    
    if (nextController.imageColor) {
        [self setBannerColor:nextController.imageColor];
    }
    
    [self pageChanged];
}

- (void) pageChanged{
    MainStartBannerContentViewController* contentController = (MainStartBannerContentViewController*) self.bannerPageController.viewControllers.firstObject;
    NSInteger index = [self.contentControllers indexOfObject:contentController];
    [self.pageControl setCurrentPage:index];
}

#pragma mark - observice
- (void) observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    if ([object isKindOfClass:[MainStartBannerContentViewController class]]) {
        if ([keyPath isEqualToString:@"imageColor"]) {
            MainStartBannerContentViewController* controller = (MainStartBannerContentViewController*) object;
            MainStartBannerContentViewController* contentController = self.bannerPageController.viewControllers.firstObject;
            if (controller == contentController) {
                [self setBannerColor:controller.imageColor];
            }
        }
    }
}

@end
