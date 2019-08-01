//
//  MainStartBannerViewController.h
//  ButterflyDemo
//
//  Created by 殷全 on 2019/7/31.
//  Copyright © 2019 殷全. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MainStartBannerItem : NSObject
@property (nonatomic, readonly) NSString* imageUrl;

- (id) initWithImageUrl:(NSString*) imageUrl;
@end

@protocol MainStartBannerDataSource <NSObject>

@required
- (NSInteger) numberOfBannerItems;
- (MainStartBannerItem*) itemOfBanner:(NSInteger) index;

@end

@interface MainStartBannerViewController : UIViewController

@property (nonatomic, strong) UIColor* bannerColor;

@property (nonatomic, weak) id<MainStartBannerDataSource> dataSource;

- (void) reloadData;
@end

NS_ASSUME_NONNULL_END
