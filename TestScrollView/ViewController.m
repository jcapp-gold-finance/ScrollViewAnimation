//
//  ViewController.m
//  TestScrollView
//
//  Created by 戴奕 on 2017/2/23.
//  Copyright © 2017年 戴奕. All rights reserved.
//

#import "ViewController.h"
#import "TownView.h"

#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (nonatomic, strong) TownView *view1;
@property (nonatomic, strong) TownView *view2;
@property (nonatomic, strong) TownView *view3;
@property (nonatomic, strong) TownView *view4;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _scrollView.contentSize = CGSizeMake(kScreenWidth, 3 * kScreenHeight);
    [_scrollView setShowsVerticalScrollIndicator:NO];
    [_scrollView setShowsHorizontalScrollIndicator:NO];
    
    [_scrollView setContentOffset:CGPointMake(0, kScreenHeight)];
    
    _view1 = [[TownView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    _view2 = [[TownView alloc] initWithFrame:CGRectMake(0, kScreenHeight, kScreenWidth, kScreenHeight)];
    _view3 = [[TownView alloc] initWithFrame:CGRectMake(0, kScreenHeight * 2, kScreenWidth, kScreenHeight)];
    _view4 = [[TownView alloc] initWithFrame:CGRectMake(0, kScreenHeight * 3, kScreenWidth, kScreenHeight)];
    
    [_view1 setType:TownViewTypeUp];
    [_view2 setType:TownViewTypeCenter];
    [_view3 setType:TownViewTypeDown];
    [_view4 setType:TownViewTypeDowndown];
    
    [_view1 setImage:0];
    [_view2 setImage:1];
    [_view3 setImage:2];
    [_view4 setImage:3];
    
    [_scrollView addSubview:_view1];
    [_scrollView addSubview:_view2];
    [_scrollView addSubview:_view3];
    [_scrollView addSubview:_view4];
}

#pragma mark - UIScrollViewDelegate Methods
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    //    NSLog(@"%@",NSStringFromCGPoint(scrollView.contentOffset));
    
    if (scrollView.contentOffset.y >= kScreenHeight * 2) {
        NSLog(@"向上拉，向下越界");
        //        if (_currentPage == 4) {
        //            _currentPage = 0;
        //        } else {
        //            _currentPage++;
        //        }
        //        _currentImageView.image = _imageArr[_currentPage];
        scrollView.contentOffset = CGPointMake(0, kScreenHeight);
//        [self updateImages:NO];
        
        [_view1 changeType:TownScrollTypeUp];
        [_view2 changeType:TownScrollTypeUp];
        [_view3 changeType:TownScrollTypeUp];
        [_view4 changeType:TownScrollTypeUp];
        
    } else if (scrollView.contentOffset.y <= 0) {
        NSLog(@"向下拉，向上越界");
        //        if (_currentPage == 0) {
        //            _currentPage = 4;
        //        } else {
        //            _currentPage--;
        //        }
        //        _currentImageView.image = _imageArr[_currentPage];
        scrollView.contentOffset = CGPointMake(0, kScreenHeight);
//        [self updateImages:YES];
        
        [_view1 changeType:TownScrollTypeDown];
        [_view2 changeType:TownScrollTypeDown];
        [_view3 changeType:TownScrollTypeDown];
        [_view4 changeType:TownScrollTypeDown];
    }
    
    
    // 百分比
    CGFloat scrollNow;
    if (scrollView.contentOffset.y > kScreenHeight) {
        scrollNow =  scrollView.contentOffset.y - kScreenHeight;
        NSLog(@"百分比 : %lf",scrollNow);
    }else{
        scrollNow = scrollView.contentOffset.y - kScreenHeight;
        NSLog(@"百分比 : %lf",scrollNow);
    }
    CGFloat percent = scrollNow / kScreenHeight;
    
    [_view1 updateUIByPercent:percent];
    [_view2 updateUIByPercent:percent];
    [_view3 updateUIByPercent:percent];
    [_view4 updateUIByPercent:percent];
}



@end
