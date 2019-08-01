//
//  UIView+BoarderEx.h
//  JYUIKit
//
//  Created by 殷全 on 2019/5/6.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, UIViewBorderLineType) {
    UIViewBorderLineTypeTop,
    UIViewBorderLineTypeRight,
    UIViewBorderLineTypeBottom,
    UIViewBorderLineTypeLeft,
};

@interface UIView (BoarderEx)

- (void) showBoarder;

- (void) showBoarder:(UIViewBorderLineType) boarderType;

- (void) setCornerRadius:(CGFloat) radius;

- (void) setCornerRadius:(CGFloat) radius color:(UIColor*) color boarderwidth:(CGFloat) boarderwidth;

@end

NS_ASSUME_NONNULL_END
