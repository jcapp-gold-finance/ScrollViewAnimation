//
//  ViewController.m
//  JCScrollAnimation
//
//  Created by 戴奕 on 2017/2/24.
//  Copyright © 2017年 戴奕. All rights reserved.
//

#import "ViewController.h"
#import "TownAnimationView.h"

@interface ViewController ()<TownAnimationViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    TownAnimationView *view = [[TownAnimationView alloc] initWithFrame:self.view.bounds];
    view.delegate = self;
    [self.view addSubview:view];
}

- (void)townAnimationView:(TownAnimationView *)townAnimationView didChangeAtIndex:(NSInteger)index {
    NSLog(@"现在是第 %ld 张",(long)index);
}


- (void)townAnimationView:(TownAnimationView *)townAnimationView didClickAtIndex:(NSInteger)index {
    NSLog(@"点击了第 %ld 张",(long)index);
}


@end
