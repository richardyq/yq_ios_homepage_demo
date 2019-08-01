//
//  YJRadioGroup.h
//  YJUIKit
//
//  Created by 殷全 on 2019/5/14.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, RadioOrientation) {
    Radio_Horizontal,
    Radio_Vertical,
    
};

typedef void(^RadioGroupSelectChanged)(NSInteger index);

@interface YJRadioGroup : UIView

@property (nonatomic, assign) NSInteger selectedIndex;
@property (nonatomic, assign) BOOL editable;

- (id) initWithTitles:(NSArray<NSString*>*) titles
          orientation:(RadioOrientation) orientation
      normalImageName:(NSString*) normalImageName
    selectedImageName:(NSString*) selectedImageName
        changeHandler:(RadioGroupSelectChanged) handler;

@end

NS_ASSUME_NONNULL_END
