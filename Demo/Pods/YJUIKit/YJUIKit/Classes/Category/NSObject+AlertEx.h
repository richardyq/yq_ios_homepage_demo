//
//  NSObject+AlertEx.h
//  YJUIKit
//
//  Created by 殷全 on 2019/5/6.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^YJAlertHandler)(UIAlertAction* _Nonnull action);

@interface NSObject (AlertEx)

+ (void) showAlert:(NSString*) message;

+ (void) showAlert:( NSString* _Nullable ) title
           message:(NSString*) message;

+ (void) showAlert:(NSString* _Nullable) title
           message:(NSString*) message
      confirmTitle:(NSString* _Nullable) confirmTitle
    confirmHandler:(YJAlertHandler _Nullable) confirmHandler;

+ (void) showAlert:(NSString* _Nullable) title
           message:(NSString*) message
      confirmTitle:(NSString* _Nullable) confirmTitle
    confirmHandler:(YJAlertHandler _Nullable) confirmHandler
       cancelTitle:(NSString* _Nullable) cancelTitle
     cancelHandler:(YJAlertHandler _Nullable) cancelHandler;

@end

NS_ASSUME_NONNULL_END
