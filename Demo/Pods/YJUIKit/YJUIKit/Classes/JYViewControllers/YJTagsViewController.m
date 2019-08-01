//
//  YJTagsViewController.m
//  YJUIKit
//
//  Created by 殷全 on 2019/5/14.
//

#import "YJTagsViewController.h"
#import "YJUIKit.h"
#import "YJTagView.h"

           
@interface YJTagsViewController ()
<UIPageViewControllerDelegate,
UIPageViewControllerDataSource>

@property (nonatomic, strong) YJTagView* tagView;
@property (nonatomic, strong) UIPageViewController* pageViewController;

@property (nonatomic, readonly) UIColor* selectTagColor;
@end

@implementation YJTagsViewController



- (id) initWithTagColor:(UIColor*) color{
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        _selectTagColor = color;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if (self.controllers && self.controllers.count > 0) {
        NSArray<NSString*>* titles = [self.controllers valueForKey:@"title"];
        [self.tagView createTagCells:titles];
        [self.pageViewController setViewControllers:@[self.controllers.firstObject] direction:UIPageViewControllerNavigationDirectionReverse animated:NO completion:nil];
    }
    
    [self layoutElements];
    
    
}


- (void) layoutElements{
    [self.tagView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.view);
        make.height.mas_equalTo(@45);
    }];
    
    [self.pageViewController.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(self.tagView.mas_bottom);
    }];
}



#pragma mark - settingAndGetting
- (YJTagView*) tagView{
    if (!_tagView ) {
        _tagView = [[YJTagView alloc] initWithSelectedColor:self.selectTagColor];
        [self.view addSubview:_tagView];
        [_tagView addObserver:self forKeyPath:@"selectIndex" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
    }
    return _tagView;
}

- (UIPageViewController*) pageViewController{
    if (!_pageViewController) {
        _pageViewController = [[UIPageViewController alloc]initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
        _pageViewController.delegate = self;
        _pageViewController.dataSource = self;
        [self addChildViewController:_pageViewController];
        [self.view addSubview:_pageViewController.view];
        
        
    }
    return _pageViewController;
}

- (void) setControllers:(NSArray<UIViewController *> *)controllers{
    _controllers = controllers;
    NSArray<NSString*>* titles = [controllers valueForKey:@"title"];
    [self.tagView createTagCells:titles];
    [self.pageViewController setViewControllers:@[controllers.firstObject] direction:UIPageViewControllerNavigationDirectionReverse animated:NO completion:nil];
}



#pragma mark - UIPageViewControllerDataSource
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController{
    
    
    NSInteger controlIndex = [self.controllers indexOfObject:viewController];
    if (controlIndex == 0 || controlIndex == NSNotFound) {
        return nil;
    }
    
    return self.controllers[--controlIndex];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController{
    
    NSInteger controlIndex = [self.controllers indexOfObject:viewController];
    if (controlIndex == NSNotFound || controlIndex == (self.controllers.count - 1)) {
        return nil;
    }
    
    return self.controllers[++controlIndex];
}

#pragma mark - UIPageViewControllerDelegate


- (void) pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray<UIViewController *> *)previousViewControllers transitionCompleted:(BOOL)completed{
    if (!finished) {
        return;
    }
    UIViewController* controller = pageViewController.viewControllers.firstObject;
    NSInteger index = [self.controllers indexOfObject:controller];
    [self.tagView setSelectIndex:index];
}



#pragma mark - observice
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    
    if (object == self.tagView) {
        if ([keyPath isEqualToString:@"selectIndex"]) {
            UIPageViewControllerNavigationDirection direction = UIPageViewControllerNavigationDirectionReverse;
            NSInteger index = [self.controllers indexOfObject: [self.pageViewController.viewControllers firstObject] ];
            if (index == self.tagView.selectIndex) {
                return;
            }
            if (index < self.tagView.selectIndex) {
                direction = UIPageViewControllerNavigationDirectionForward;
            }
            [self.pageViewController setViewControllers:@[self.controllers[self.tagView.selectIndex]] direction:direction animated:YES completion:nil];
        }
    }
    
}

@end
