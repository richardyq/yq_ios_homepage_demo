//
//  UIImage+ColorEx.h
//  ButterflyDemo
//
//  Created by 殷全 on 2019/7/29.
//  Copyright © 2019 殷全. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (ColorEx)

- (UIImage *)imageWithColor:(UIColor *)color;

- (UIColor *)colorAtPixel:(CGPoint)point;
@end

NS_ASSUME_NONNULL_END
