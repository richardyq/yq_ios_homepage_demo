//
//  MainStartFavourModel.h
//  ButterflyDemo
//
//  Created by 殷全 on 2019/8/1.
//  Copyright © 2019 殷全. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MainStartFavourModel : NSObject

@property (nonatomic, strong) NSString* name;
@property (nonatomic, strong) NSString* imageUrl;
@property (nonatomic, strong) id;

- (id) initWithName:(NSString*) name imageUrl:(NSString*) imageUrl;
@end

NS_ASSUME_NONNULL_END
