//
//  CheckBoxControl.h
//  YJUIKit
//
//  Created by 殷全 on 2019/5/14.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^CheckBoxHandler)(BOOL selected);

@interface CheckBoxControl : UIControl

- (id) initWithTitle:(NSString*) title
     normalImageName:(NSString*) normalImageName
   selectedImageName:(NSString*) selectedImageName
             handler:(CheckBoxHandler) handler;

@end

NS_ASSUME_NONNULL_END
