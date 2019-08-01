//
//  MainStartFavourViewController.m
//  ButterflyDemo
//
//  Created by 殷全 on 2019/8/1.
//  Copyright © 2019 殷全. All rights reserved.
//

#import "MainStartFavourViewController.h"
#import "MainStartFavourModel.h"

@interface MainStartFavourCell : UIControl

@property (nonatomic, strong) UIImageView* imageview;
@property (nonatomic, strong) UILabel* nameLabel;

- (id) initWithName:(NSString*) name imageUrl:(NSString*) imageUrl;

@end

@implementation MainStartFavourCell

- (id) initWithName:(NSString *)name imageUrl:(NSString *)imageUrl{
    self = [super init];
    if (self) {
        [self layoutElements];
        
        self.nameLabel.text = name;
        [self.imageview sd_setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:[UIImage imageNamed:@"defaultImage"]];
    }
    return self;
}

- (void) layoutElements{
    [self.imageview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(3);
        make.width.equalTo(self).offset(-5);
        make.centerX.equalTo(self);
        make.height.equalTo(self.mas_width);
        make.bottom.equalTo(self).offset(-34);
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.imageview.mas_bottom).offset(5);
        make.left.equalTo(self.imageview);
        make.right.lessThanOrEqualTo(self.imageview);
    }];
}



#pragma mark - settingAndGetting
- (UILabel*) nameLabel{
    if (!_nameLabel) {
        _nameLabel = [self addLabel:[UIColor commonTextColor] textSize:12];
        _nameLabel.numberOfLines = 2;
    }
    return _nameLabel;
}

- (UIImageView*) imageview{
    if (!_imageview) {
        _imageview = [self addImageView];
        [_imageview setCornerRadius:3];
    }
    return _imageview;
}

@end

@interface MainStartFavourViewController ()

@property (nonatomic, strong) UIView* favourView;
@property (nonatomic, strong) UIButton* changeButton;
@property (nonatomic, strong) NSMutableArray<MainStartFavourCell*>* cells;

@end

@implementation MainStartFavourViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self layoutElements];
    [self startLoadFavours];
}

- (void) layoutElements{
    [self.favourView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.view);
        make.bottom.equalTo(self.changeButton.mas_top).offset(-5);
    }];
    
    [self.changeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(62, 28));
        make.centerX.equalTo(self.view);
        make.bottom.equalTo(self.view).offset(-5);
    }];
}

- (void) startLoadFavours{
    NSMutableArray<MainStartFavourModel*>* models = [NSMutableArray<MainStartFavourModel*> array];
    
    NSArray<NSString*>* names = @[@"习近平新时代中国特色社会主义思想学习纲要", @"糗事播报", @"宝宝巴士·睡前故事|4-7岁儿童", @"《夜色钢琴曲》", @"米小圈上学记：一二三年级", @"摸金天师【紫襟演播】", @"易中天品三国", @"绝世高手【头陀渊&小桃红】免费"];
    NSArray<NSString*>* imageUrls = @[@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1564638908029&di=98022f608b6fe65b54189a4c67916fa6&imgtype=0&src=http%3A%2F%2Fhbimg.b0.upaiyun.com%2F1b73e20638ba8cc15677e4ceb9f64f14137402a31a646-CZt5rk_fw658", @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1564638936688&di=4ebea6e28b2905f1950cd4dbdcac2ee0&imgtype=jpg&src=http%3A%2F%2Fimg2.imgtn.bdimg.com%2Fit%2Fu%3D1996672522%2C1675386698%26fm%3D214%26gp%3D0.jpg", @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1564638908024&di=23840183b223675e998e025c043f2705&imgtype=0&src=http%3A%2F%2Fimg.ylq.com%2F2016%2F1227%2F20161227032309406.png", @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1564638971960&di=5407150d5150c3687b66f8fbbdeb16f7&imgtype=jpg&src=http%3A%2F%2Fimg0.imgtn.bdimg.com%2Fit%2Fu%3D2654568910%2C985787723%26fm%3D214%26gp%3D0.jpg", @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1564638908015&di=83e24865cc0ce8d1e8394c586a82d7a0&imgtype=0&src=http%3A%2F%2Fupload.newhua.com%2F2014%2F0925%2F1411609953636.jpg", @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1564638908000&di=a1827aa68a1e59399010407393111d8e&imgtype=0&src=http%3A%2F%2Fa2.att.hudong.com%2F86%2F91%2F01200000165120134428918420944_s.jpg", @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1564638907990&di=c0e0b96cd3eeebcb6d6ed0ad02b93805&imgtype=0&src=http%3A%2F%2Fimg5.duitang.com%2Fuploads%2Fitem%2F201309%2F19%2F20130919210738_55EES.thumb.700_0.jpeg", @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1564639016422&di=8ff72535277ae68e2cc6e0154c41b092&imgtype=0&src=http%3A%2F%2Fimg1.cache.netease.com%2Fent%2F2008%2F9%2F12%2F20080912153424eafa9.jpg"];
    
    [names enumerateObjectsUsingBlock:^(NSString * _Nonnull name, NSUInteger idx, BOOL * _Nonnull stop) {
        MainStartFavourModel* model = [[MainStartFavourModel alloc] initWithName:name imageUrl:imageUrls[idx]];
        [models addObject:model];
    }];
    
    [self favoursLoaded:models];
}

- (void) favoursLoaded:(NSArray<MainStartFavourModel*>*) models{
    [self.cells enumerateObjectsUsingBlock:^(MainStartFavourCell * _Nonnull cell, NSUInteger idx, BOOL * _Nonnull stop) {
        [cell removeFromSuperview];
    }];
    [self.cells removeAllObjects];
    
    [models enumerateObjectsUsingBlock:^(MainStartFavourModel * _Nonnull model, NSUInteger idx, BOOL * _Nonnull stop) {
        MainStartFavourCell* cell = [[MainStartFavourCell alloc] initWithName:model.name imageUrl:model.imageUrl];
        [self.cells addObject:cell];
        [self.favourView addSubview:cell];
    }];
    
    __block MASViewAttribute* cellLeft = self.favourView.mas_left;
    __block MASViewAttribute* cellTop = self.favourView.mas_top;
    
    [self.cells enumerateObjectsUsingBlock:^(MainStartFavourCell * _Nonnull cell, NSUInteger idx, BOOL * _Nonnull stop) {
        [cell mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(cellLeft);
            make.top.equalTo(cellTop);
            make.width.equalTo(self.favourView).dividedBy(4);
            
            if (cell == self.cells.lastObject) {
                make.bottom.equalTo(self.favourView);
            }
        }];
        
        if ((idx % 4) == 3) {
            cellLeft = self.favourView.mas_left;
            cellTop = cell.mas_bottom;
        }
        else{
            cellLeft = cell.mas_right;
        }
    }];
}

#pragma mark - settingAndGetting
- (UIView*) favourView{
    if (!_favourView) {
        _favourView = [UIView new];
        [self.view addSubview:_favourView];
    }
    return _favourView;
}

- (UIButton*) changeButton{
    if (!_changeButton) {
        _changeButton = [self.view addSolidButton:[UIColor mainThemeColor] size:CGSizeMake(62, 28) title:@"换一批" titleSize:12];
    }
    return _changeButton;
}

- (NSMutableArray<MainStartFavourCell*>*) cells{
    if (!_cells) {
        _cells = [NSMutableArray<MainStartFavourCell*> array];
    }
    return _cells;
}

@end
