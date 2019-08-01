//
//  UIView+SubViewEx.h
//  JYUIKit
//
//  Created by 殷全 on 2019/5/6.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (SubViewEx)

/*
 addLabel
 add a UILabel to this view
 */
- (UILabel*) addLabel;
- (UILabel*) addLabel:(UIColor*) textColor textSize:(CGFloat) textSize;

/*
 addImageView
 add a UIImageView to this view
 */
- (UIImageView*) addImageView;
- (UIImageView*) addImageView:(NSString*) imageName;

/*
 addTextField
 add TextField to this view
 */
- (UITextField*) addTextField:(NSString*) placeholder;
- (UITextField*) addTextField:(NSString*) placeholder class:(Class) class;

- (UITextField*) addTextField:(NSString*) placeholder
                    textColor:(UIColor*) textColor
                     textSize:(CGFloat) textSize;
- (UITextField*) addTextField:(NSString*) placeholder
                        class:(Class) classtextColor:(UIColor*) textColor
                     textSize:(CGFloat) textSize;

/*
 addButton
 add UIButton to this view
 */
- (UIButton*) addButton:(UIButtonType) buttonType;
- (UIButton*) addSolidButton:(UIColor*) color size:(CGSize) size title:(NSString*) title titleSize:(CGFloat) titleSize;
- (UIButton*) addStokeButton:(UIColor*) color size:(CGSize) size title:(NSString*) title titleSize:(CGFloat) titleSize;
@end

NS_ASSUME_NONNULL_END
