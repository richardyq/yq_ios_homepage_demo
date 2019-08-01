//
//  AlbumModel.h
//  ButterflyDemo
//
//  Created by 殷全 on 2019/8/1.
//  Copyright © 2019 殷全. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AlbumModel : NSObject

@property (nonatomic, strong) NSString* coverUrl;
@property (nonatomic, strong) NSString* name;
@property (nonatomic, strong) NSString* author;
@property (nonatomic, strong) NSString* updateDate;
@property (nonatomic, strong) NSString* summary;
@property (nonatomic) NSInteger playCount;

@end

NS_ASSUME_NONNULL_END
