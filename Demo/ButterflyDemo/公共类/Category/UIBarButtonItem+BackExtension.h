//
//  UIBarButtonItem+BackExtension.h
//  ButterflyDemo
//
//  Created by 殷全 on 2019/7/29.
//  Copyright © 2019 殷全. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIBarButtonItem (BackExtension)

+ (UIBarButtonItem *)itemWithImageNamed:(NSString *)imageNamed targe:(id)targe action:(SEL)action;

@end

NS_ASSUME_NONNULL_END
