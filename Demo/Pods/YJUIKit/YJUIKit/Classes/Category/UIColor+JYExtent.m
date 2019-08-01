//
//  UIColor+JYExtent.m
//  JYUIKit
//
//  Created by 殷全 on 2019/5/6.
//

#import "UIColor+JYExtent.h"
#import "YJUIKit.h"

@implementation UIColor (JYExtent)
#pragma mark - 常用颜色
+ (UIColor*) commonBackgroundColor{
    return [UIColor colorWithHexString:@"FBFBFB"];
}

+ (UIColor*) commonBoarderColor{
    return [UIColor colorWithHexString:@"EFEFEF"];
}

#pragma mark - 文本颜色
+ (UIColor*) commonTextColor{
    return [UIColor colorWithHexString:@"333333"];
}

+ (UIColor*) commonGrayTextColor{
    return [UIColor colorWithHexString:@"888888"];
}

@end

