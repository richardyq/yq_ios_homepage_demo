//
//  BaseViewController.m
//  ButterflyDemo
//
//  Created by 殷全 on 2019/7/29.
//  Copyright © 2019 殷全. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@property (nonatomic, strong) NSDictionary* controllerIdDict;

@end

@implementation BaseViewController

@synthesize controllerId = _controllerId;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor commonBackgroundColor];
}

#pragma mark - settingAndGetting
- (NSDictionary*) controllerIdDict{
    if (!_controllerIdDict) {
        NSMutableDictionary* dict = [NSMutableDictionary dictionary];
        [dict setValue:NSStringFromClass(self.class) forKey:@"controllerName"];
        
        if (self.controllerParam) {
            [dict setValue:self.controllerParam forKey:@"param"];
        }
        _controllerIdDict = [NSDictionary dictionaryWithDictionary:dict];
        
    }
    return _controllerIdDict;
}

- (NSString*) controllerId{
    if (!_controllerId) {
        _controllerId = [self.controllerIdDict mj_JSONString];
    }
    
    return _controllerId;
}
@end
