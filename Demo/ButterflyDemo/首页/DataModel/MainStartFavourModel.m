//
//  MainStartFavourModel.m
//  ButterflyDemo
//
//  Created by 殷全 on 2019/8/1.
//  Copyright © 2019 殷全. All rights reserved.
//

#import "MainStartFavourModel.h"

@implementation MainStartFavourModel

- (id) initWithName:(NSString*) name imageUrl:(NSString*) imageUrl{
    self = [super init];
    if (self) {
        _name = name;
        _imageUrl = imageUrl;
    }
    return self;
}
@end
