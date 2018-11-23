//
//  LYMotionManager.m
//  LYShake
//
//  Created by liyang on 17/7/14.
//  Copyright © 2017年 kosienDGL. All rights reserved.
//  代码地址：https://github.com/YoungerLi/LYShake

#import "LYMotionManager.h"

@interface LYMotionManager ()

@property (nonatomic, strong) CMMotionManager *motionManager;

@end

@implementation LYMotionManager

+ (instancetype)defaultManager
{
    static id manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[[self class] alloc] init];
    });
    return manager;
}

- (CMMotionManager *)motionManager
{
    if (_motionManager == nil) {
        _motionManager = [[CMMotionManager alloc] init];
        _motionManager.deviceMotionUpdateInterval = 0.1;   //加速计更新频率，以秒为单位
    }
    return _motionManager;
}


#pragma mark - 开始更新频率
- (void)startMotionUpdatesWithHandler:(LYMotionHandler)handler
{
    if (![self.motionManager isDeviceMotionActive] && [self.motionManager isDeviceMotionAvailable]) {
        
        [self.motionManager startDeviceMotionUpdatesToQueue:[[NSOperationQueue alloc] init] withHandler:^(CMDeviceMotion * _Nullable motion, NSError * _Nullable error) {
            
            //该属性返回地球重力对该设备在X、Y、Z轴上施加的重力加速度（只是地球重力，手动晃的再厉害也不管用）
            //CMAcceleration gravity = motion.gravity;
            
            //该属性只是用户手动为设备提供的加速度，不包含地球重力加速度
            CMAcceleration userAcceleration = motion.userAcceleration;
            NSLog(@"%f, %f, %f", userAcceleration.x, userAcceleration.y, userAcceleration.z);
            
            //值越大说明摇动的幅度越大
            double num = 1.0f;
            if (fabs(userAcceleration.x) > num || fabs(userAcceleration.y) > num ||fabs(userAcceleration.z) > num) {
                //停止更新
                [self stopMotion];
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    handler();
                });
            }
        }];
    }
}


#pragma mark - 停止更新频率

- (void)stopMotion {
    [self.motionManager stopDeviceMotionUpdates];
}


@end
