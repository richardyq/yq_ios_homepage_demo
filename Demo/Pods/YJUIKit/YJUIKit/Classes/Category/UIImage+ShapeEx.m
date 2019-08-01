//
//  UIImage+ShapeEx.m
//  JYUIKit
//
//  Created by 殷全 on 2019/5/6.
//

#import "UIImage+ShapeEx.h"
#import "YJUIKit.h"

@implementation UIImage (ShapeEx)

+ (UIImage*) rectImage:(UIColor*) color size:(CGSize) size{
    CGRect rect = CGRectMake(0.0f, 0.0f, size.width , size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}
@end
