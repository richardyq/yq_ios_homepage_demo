//
//  CommonMarco.h
//  ButterflyDemo
//
//  Created by 殷全 on 2019/7/31.
//  Copyright © 2019 殷全. All rights reserved.
//

#ifndef CommonMarco_h
#define CommonMarco_h

#define WEAK_SELF(weakSelf) __weak __typeof(self) (weakSelf) = self;

//判断是否是iPhoneX
#define isPhoneX \
({BOOL isphoneX = NO;\
if (@available(iOS 11.0, *)) {\
isphoneX = [[UIApplication sharedApplication] delegate].window.safeAreaInsets.bottom > 0.0;\
}\
(isphoneX);})

#endif /* CommonMarco_h */
