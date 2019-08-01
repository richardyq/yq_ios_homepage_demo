//
//  AlbumTableViewCell.m
//  ButterflyDemo
//
//  Created by 殷全 on 2019/8/1.
//  Copyright © 2019 殷全. All rights reserved.
//

#import "AlbumTableViewCell.h"

@interface AlbumTableViewCell ()

@property (nonatomic, strong) UIImageView* coverImageview;
@property (nonatomic, strong) UILabel* nameLabel;
@property (nonatomic, strong) UILabel* summaryLabel;
@property (nonatomic, strong) UILabel* authorLabel;
@property (nonatomic, strong) UILabel* playCountLabel;

@end

@implementation AlbumTableViewCell

- (id) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self layoutElements];
    }
    return self;
}

- (void) layoutElements{
    [self.coverImageview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(102, 84));
        make.centerY.equalTo(self.contentView);
        make.left.equalTo(self.contentView).offset(12.5);
        make.top.equalTo(self.contentView).offset(10);
        make.bottom.equalTo(self.contentView).offset(-10);
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.coverImageview.mas_right).offset(8);
        make.top.equalTo(self.coverImageview);
        make.right.lessThanOrEqualTo(self.contentView).offset(-10);
    }];
    
    [self.summaryLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nameLabel);
        make.top.equalTo(self.nameLabel.mas_bottom).offset(4);
        make.right.lessThanOrEqualTo(self.contentView).offset(-10);
    }];
    
    [self.authorLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nameLabel);
        make.bottom.equalTo(self.coverImageview);
    }];
    
    [self.playCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.coverImageview);
        make.right.equalTo(self.contentView).offset(-10);
    }];
}

#pragma mark - settingAndGetting
- (UIImageView*) coverImageview{
    if (!_coverImageview) {
        _coverImageview = [self.contentView addImageView:@"defaultImage"];
        [_coverImageview setCornerRadius:4];
    }
    return _coverImageview;
}

- (UILabel*) nameLabel{
    if (!_nameLabel) {
        _nameLabel = [self.contentView addLabel:[UIColor commonTextColor] textSize:15];
        _nameLabel.numberOfLines = 2;
    }
    return _nameLabel;
}

- (UILabel*) summaryLabel{
    if (!_summaryLabel) {
        _summaryLabel = [self.contentView addLabel:[UIColor commonGrayTextColor] textSize:12];
        _summaryLabel.numberOfLines = 2;
    }
    return _summaryLabel;
}

- (UILabel*) authorLabel{
    if (!_authorLabel) {
        _authorLabel = [self.contentView addLabel:[UIColor commonGrayTextColor] textSize:10];
    }
    return _authorLabel;
}

- (UILabel*) playCountLabel{
    if (!_playCountLabel) {
        _playCountLabel = [self.contentView addLabel:[UIColor commonTextColor] textSize:10];
    }
    return _playCountLabel;
}

- (void) setAlbumModel:(AlbumModel*) album{
    [self.coverImageview sd_setImageWithURL:[NSURL URLWithString:album.coverUrl] placeholderImage:[UIImage imageNamed:@"defaultImage"]];
    
    self.nameLabel.text = album.name;
    self.summaryLabel.text = album.summary;
    self.authorLabel.text = album.author;
    NSString* playCountText = [NSString stringWithFormat:@"%ld", album.playCount];
    if (album.playCount > 10000) {
        playCountText = [NSString stringWithFormat:@"%.1f万", ((CGFloat)album.playCount/10000)];
    }
    
    self.playCountLabel.text = [NSString stringWithFormat:@"播放:%@次", playCountText];
}

@end
