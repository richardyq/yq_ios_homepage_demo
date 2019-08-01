//
//  UIView+BadgeEx.h
//  ButterflyDemo
//
//  Created by 殷全 on 2019/7/29.
//  Copyright © 2019 殷全. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (BadgeEx)

- (void) addBadge:(NSString*) badge;

- (void) closeBadege;
@end

NS_ASSUME_NONNULL_END
