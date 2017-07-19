//
//  ViewController.m
//  LYShake
//
//  Created by liyang on 17/7/14.
//  Copyright © 2017年 kosienDGL. All rights reserved.
//  代码地址：https://github.com/YoungerLi/LYShake

#import "ViewController.h"
#import "ShakeViewController.h"

// 屏幕宽高
#define SCREEN_WIDTH  [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

@interface ViewController ()

@property (nonatomic, strong) UIButton *button1;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"首页";
    self.view.backgroundColor = [UIColor magentaColor];
    
    _button1 = [[UIButton alloc] initWithFrame:CGRectMake(50, 100, SCREEN_WIDTH-100, 50)];
    _button1.backgroundColor = [UIColor redColor];
    [_button1 setTitle:@"加速计（实现摇一摇）" forState:UIControlStateNormal];
    [_button1 addTarget:self action:@selector(click1) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_button1];
}


- (void)click1
{
    ShakeViewController *VC = [[ShakeViewController alloc] init];
    [self.navigationController pushViewController:VC animated:YES];
}



@end
