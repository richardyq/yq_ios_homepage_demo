//
//  AlbumTableViewCell.h
//  ButterflyDemo
//
//  Created by 殷全 on 2019/8/1.
//  Copyright © 2019 殷全. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AlbumModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface AlbumTableViewCell : UITableViewCell

- (void) setAlbumModel:(AlbumModel*) album;
@end

NS_ASSUME_NONNULL_END
