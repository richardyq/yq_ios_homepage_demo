//
//  YJTagView.h
//  YJUIKit
//
//  Created by 殷全 on 2019/5/14.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YJTagView : UIView

@property (nonatomic, assign) NSInteger selectIndex;

- (instancetype)initWithSelectedColor:(UIColor*) color;
- (void) createTagCells:(NSArray<NSString*>*) titles;

@end

NS_ASSUME_NONNULL_END
