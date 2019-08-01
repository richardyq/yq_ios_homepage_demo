//
//  MainTabbarView.h
//  ButterflyDemo
//
//  Created by 殷全 on 2019/7/29.
//  Copyright © 2019 殷全. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MainTabbarItem : NSObject

@property (nonatomic, strong) UIImage* iconImage;
@property (nonatomic, strong) NSString* title;

- (id) initWithImage:(UIImage*) image title:(NSString*) title;

@end

@interface MainTabbarView : UIView

@property (nonatomic) NSInteger selectedIndex;
@property (nonatomic, strong) UIImage* centerImage;
@property (nonatomic, strong) NSArray<MainTabbarItem*>* items;

- (void) setBadge:(NSString*) badge index:(NSInteger) index;

@end

NS_ASSUME_NONNULL_END
