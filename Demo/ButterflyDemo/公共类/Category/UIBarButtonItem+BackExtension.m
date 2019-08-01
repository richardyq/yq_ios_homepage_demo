//
//  UIBarButtonItem+BackExtension.m
//  ButterflyDemo
//
//  Created by 殷全 on 2019/7/29.
//  Copyright © 2019 殷全. All rights reserved.
//

#import "UIBarButtonItem+BackExtension.h"

@implementation UIBarButtonItem (BackExtension)

+ (UIBarButtonItem *)itemWithImageNamed:(NSString *)imageNamed targe:(id)targe action:(SEL)action
{
    UIButton *button = [[UIButton alloc] init];
    [button setBackgroundImage:[UIImage imageNamed:imageNamed] forState:UIControlStateNormal];
    
    CGFloat width = button.currentBackgroundImage.size.width;
    CGFloat height = 30;
    if (width < 31) {
        width = 31;
    }
    
    button.frame = CGRectMake(0, 0, width, height);
    
    [button addTarget:targe action:action forControlEvents:UIControlEventTouchUpInside];
    
    return [[UIBarButtonItem alloc] initWithCustomView:button];
}


@end
