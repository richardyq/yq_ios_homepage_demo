//
//  YJLabelControl.h
//  YJUIKit
//
//  Created by 殷全 on 2019/5/7.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YJLabelControl : UIControl

@property (nonatomic, readonly) NSString* placeholder;
@property (nonatomic, strong) NSString* text;

- (id) initWithPlaceholder:(NSString*) placeholder;

@end

NS_ASSUME_NONNULL_END
