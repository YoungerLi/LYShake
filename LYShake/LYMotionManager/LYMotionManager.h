//
//  LYMotionManager.h
//  LYShake
//
//  Created by liyang on 17/7/14.
//  Copyright © 2017年 kosienDGL. All rights reserved.
//  代码地址：https://github.com/YoungerLi/LYShake

#import <Foundation/Foundation.h>
#import <CoreMotion/CoreMotion.h>

typedef void (^LYMotionHandler)(void);

/**
 这是一个对`CMMotionManager`进行封装的类，主要实现加速计(摇一摇)
 */
@interface LYMotionManager : NSObject

/** 单例 */
+ (instancetype)defaultManager;

/** 开始更新频率 */
- (void)startMotionUpdatesWithHandler:(LYMotionHandler)handler;

/** 停止更新频率 */
- (void)stopMotion;

@end
