//
//  NSObject+YJEx.h
//  YJUIKit
//
//  Created by 殷全 on 2019/5/6.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (YJEx)

+ (id<UIApplicationDelegate>) rootApp;

+ (UIWindow*) rootWindow;

+ (BOOL) isPad;

+ (UIViewController*) topMostController;

@end

NS_ASSUME_NONNULL_END
