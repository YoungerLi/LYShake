//
//  ShakeViewController.m
//  LYShake
//
//  Created by liyang on 17/7/14.
//  Copyright © 2017年 kosienDGL. All rights reserved.
//  代码地址：https://github.com/YoungerLi/LYShake

#import "ShakeViewController.h"
#import "LYMotionManager.h"

// 屏幕宽高
#define SCREEN_WIDTH  [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

@interface ShakeViewController ()<UIAlertViewDelegate>

@end

@implementation ShakeViewController

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self startMotion];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveNotification:) name:UIApplicationDidEnterBackgroundNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveNotification:) name:UIApplicationWillEnterForegroundNotification object:nil];
}

- (void)viewDidDisappear:(BOOL)animated {
    [[LYMotionManager defaultManager] stopMotion];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationDidEnterBackgroundNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationWillEnterForegroundNotification object:nil];
    [super viewDidDisappear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"加速计";
    self.view.backgroundColor = [UIColor redColor];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 100, SCREEN_WIDTH, 50)];
    label.text = @"快摇动手机吧";
    label.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:label];
}




#pragma mark - 开启摇动

- (void)startMotion
{
    [[LYMotionManager defaultManager] startMotionUpdatesWithHandler:^{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"欢迎使用摇一摇" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
    }];
}




#pragma mark - UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    [self startMotion];
}




#pragma mark - NSNotification

- (void)receiveNotification:(NSNotification *)notification
{
    if ([notification.name isEqualToString:UIApplicationDidEnterBackgroundNotification]) {
        NSLog(@"进入后台");
        [[LYMotionManager defaultManager] stopMotion];
    } else {
        NSLog(@"回到前台");
        [self startMotion];
    }
}


@end
