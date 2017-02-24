//
//  DYViewController.m
//  TestScrollView
//
//  Created by 戴奕 on 2017/2/24.
//  Copyright © 2017年 戴奕. All rights reserved.
//

#import "DYViewController.h"
#import "TownAnimationView.h"

@interface DYViewController ()<TownAnimationViewDelegate>

@end

@implementation DYViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    TownAnimationView *view = [[TownAnimationView alloc] initWithFrame:self.view.bounds];
    view.delegate = self;
    [self.view addSubview:view];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)townAnimationView:(TownAnimationView *)townAnimationView didChangeAtIndex:(NSInteger)index {
    NSLog(@"现在是第 %d 张",index);
}


- (void)townAnimationView:(TownAnimationView *)townAnimationView didClickAtIndex:(NSInteger)index {
    NSLog(@"点击了第 %d 张",index);
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
