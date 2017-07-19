# LYShake
iOS 一款通过CoreMotion.framework封装的，实现手机摇一摇功能。
主要原理是通过监测手机设备的加速度来获取手机摇动的幅度从而确定手机是否被摇动。
更多原理介绍来我的[简书](http://www.jianshu.com/p/c4fff00b50ff)看看吧！！！

# 使用方法
1、首先将LYMotionManager文件夹拖入到你的工程中，引入头文件
```objective-c
#import "LYMotionManager.h"
```

2、然后在你需要开启摇一摇功能的地方调用
```objective-c
//开启摇一摇
- (void)startAccelerometer
{
    [[LYMotionManager defaultManager] startAccelerometerUpdatesWithHandler:^(CMAcceleration acceleration, NSError *error) {
        // 处理你自己的事情...
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"欢迎使用摇一摇" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
    }];
}
```

> 注：当摇动成功时，手机加速计会关闭。也就是当上面的弹窗弹起后，再摇动手机就不会再弹窗了，直至再次开启摇一摇。

```objective-c
// UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    //点击确定，关闭弹窗，再次开启摇一摇。
    [self startAccelerometer];
}
```

3、当手机回到后台或离开当前页面的时候应关闭加速计
```objective-c
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self startAccelerometer];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveNotification:) name:UIApplicationDidEnterBackgroundNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveNotification:) name:UIApplicationWillEnterForegroundNotification object:nil];
}
- (void)viewDidDisappear:(BOOL)animated {
    [[LYMotionManager defaultManager] stopAccelerometerUpdates];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationDidEnterBackgroundNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationWillEnterForegroundNotification object:nil];
    [super viewDidDisappear:animated];
}

//对应上面的通知中心回调的消息接收
- (void)receiveNotification:(NSNotification *)notification
{
    if ([notification.name isEqualToString:UIApplicationDidEnterBackgroundNotification]) {
        NSLog(@"进入后台");
        [[LYMotionManager defaultManager] stopAccelerometerUpdates];//关闭加速计
    } else {
        NSLog(@"回到前台");
        [self startAccelerometer];
    }
}
```

