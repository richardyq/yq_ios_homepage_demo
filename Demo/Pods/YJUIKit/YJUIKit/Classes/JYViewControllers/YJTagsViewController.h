//
//  YJTagsViewController.h
//  YJUIKit
//
//  Created by 殷全 on 2019/5/14.
//

#import <UIKit/UIKit.h>


NS_ASSUME_NONNULL_BEGIN

@interface YJTagsViewController : UIViewController

@property (nonatomic, strong) NSArray<UIViewController*>* controllers;

- (id) initWithTagColor:(UIColor*) color;

@end

NS_ASSUME_NONNULL_END
