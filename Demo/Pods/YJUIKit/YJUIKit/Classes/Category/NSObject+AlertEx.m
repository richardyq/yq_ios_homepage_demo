//
//  NSObject+AlertEx.m
//  YJUIKit
//
//  Created by 殷全 on 2019/5/6.
//

#import "NSObject+AlertEx.h"
#import "YJUIKit.h"

@implementation NSObject (AlertEx)

+ (void) showAlert:(NSString* ) message{
    [self showAlert:nil message:message];
}

+ (void) showAlert:( NSString* _Nullable ) title
           message:(NSString*) message;{
    [self showAlert:title message:message confirmTitle:@"确定" confirmHandler:nil];
}

+ (void) showAlert:(NSString* _Nullable) title
           message:(NSString*) message
      confirmTitle:(NSString* _Nullable) confirmTitle
    confirmHandler:(YJAlertHandler _Nullable) confirmHandler{
    [self showAlert:title message:message confirmTitle:confirmTitle confirmHandler:confirmHandler cancelTitle:nil cancelHandler:nil];
}

+ (void) showAlert:(NSString* _Nullable) title
           message:(NSString*) message
      confirmTitle:(NSString* _Nullable) confirmTitle
    confirmHandler:(YJAlertHandler _Nullable) confirmHandler
       cancelTitle:(NSString* _Nullable) cancelTitle
    cancelHandler:(YJAlertHandler _Nullable) cancelHandler{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    if (!confirmTitle || confirmTitle.length == 0) {
        confirmTitle = @"确定";
    }
    
    UIAlertAction* action = [UIAlertAction actionWithTitle:confirmTitle style:UIAlertActionStyleDefault handler:confirmHandler];
    [alertController addAction:action];
    
    if (!cancelTitle || cancelTitle.length == 0) {
        confirmTitle = @"取消";
    }
    if (cancelHandler) {
        UIAlertAction* action = [UIAlertAction actionWithTitle:confirmTitle style:UIAlertActionStyleCancel handler:cancelHandler];
        [alertController addAction:action];
    }
    [[self topMostController] presentViewController:alertController animated:YES completion:nil];
}

@end
