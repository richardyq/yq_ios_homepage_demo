//
//  MainStartHeaderView.h
//  ButterflyDemo
//
//  Created by 殷全 on 2019/7/31.
//  Copyright © 2019 殷全. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


@class MainStartSearchControl;


@interface MainStartHeaderView : UIView

@property (nonatomic, strong) MainStartSearchControl* searchControl;
@property (nonatomic, strong) UIButton* historyButton;
@property (nonatomic, strong) UIButton* filterButton;

@end

NS_ASSUME_NONNULL_END
