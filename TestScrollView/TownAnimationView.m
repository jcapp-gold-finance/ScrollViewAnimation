//
//  TownAnimationView.m
//  Ease
//
//  Created by 戴奕 on 2017/2/24.
//  Copyright © 2017年 戴奕. All rights reserved.
//

#import "TownAnimationView.h"
#import "TownView.h"

#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

@interface TownAnimationView ()<UIScrollViewDelegate, TownViewDelegate>

@property (nonatomic, strong) UIImageView *imgvBg;
@property (nonatomic, strong) UIScrollView *scvTownShow;

@property (nonatomic, strong) TownView *vUp;
@property (nonatomic, strong) TownView *vCenter;
@property (nonatomic, strong) TownView *vDown;
@property (nonatomic, strong) TownView *vChange;

@property (nonatomic, assign) NSInteger currentPage;
@property (nonatomic, assign, getter=isDrag) BOOL drag;

@end

@implementation TownAnimationView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.imgvBg];
        [self addSubview:self.scvTownShow];
        
        [self.scvTownShow addSubview:self.vUp];
        [self.scvTownShow addSubview:self.vCenter];
        [self.scvTownShow addSubview:self.vDown];
        [self.scvTownShow addSubview:self.vChange];
        
        self.currentPage = 1;
        self.drag = NO;
    }
    return self;
}

#pragma mark - TownViewDelegate Methods
- (void)townView:(TownView *)townView didClickWithType:(TownViewType)type {
    if (type == TownViewTypeCenter) {
        if ([self.delegate respondsToSelector:@selector(townAnimationView:didClickAtIndex:)]) {
            [self.delegate townAnimationView:self didClickAtIndex:self.currentPage];
        }
    }
}

#pragma mark - UIScrollViewDelegate Methods
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView.contentOffset.y >= kScreenHeight * 2) {
        NSLog(@"向上拉，向下越界");
        scrollView.contentOffset = CGPointMake(0, kScreenHeight);
        
        [self.vUp changeType:TownScrollTypeUp];
        [self.vCenter changeType:TownScrollTypeUp];
        [self.vDown changeType:TownScrollTypeUp];
        [self.vChange changeType:TownScrollTypeUp];
        
        if (self.currentPage == 6) {
            self.currentPage = 1;
        } else {
            self.currentPage++;
        }
        if ([self.delegate respondsToSelector:@selector(townAnimationView:didChangeAtIndex:)]) {
            [self.delegate townAnimationView:self didChangeAtIndex:self.currentPage];
        }
    } else if (scrollView.contentOffset.y <= 0) {
        NSLog(@"向下拉，向上越界");
        scrollView.contentOffset = CGPointMake(0, kScreenHeight);
        
        [self.vUp changeType:TownScrollTypeDown];
        [self.vCenter changeType:TownScrollTypeDown];
        [self.vDown changeType:TownScrollTypeDown];
        [self.vChange changeType:TownScrollTypeDown];
        
        if (self.currentPage == 1) {
            self.currentPage = 6;
        } else {
            self.currentPage--;
        }
        if ([self.delegate respondsToSelector:@selector(townAnimationView:didChangeAtIndex:)]) {
            [self.delegate townAnimationView:self didChangeAtIndex:self.currentPage];
        }
    }
    
    // 百分比
    CGFloat scrollNow;
    if (scrollView.contentOffset.y > kScreenHeight) {
        scrollNow =  scrollView.contentOffset.y - kScreenHeight;
    }else{
        scrollNow = scrollView.contentOffset.y - kScreenHeight;
    }
    CGFloat percent = scrollNow / kScreenHeight;
    
    [self.vUp updateUIByPercent:percent];
    [self.vCenter updateUIByPercent:percent];
    [self.vDown updateUIByPercent:percent];
    [self.vChange updateUIByPercent:percent];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    self.drag = YES;
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    self.drag = NO;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if ([self.delegate respondsToSelector:@selector(townAnimationView:didEndDeceleratingAtIndex:)]) {
        [self.delegate townAnimationView:self didEndDeceleratingAtIndex:self.currentPage];
    }
}

#pragma mark - setter and getter Methods
- (UIImageView *)imgvBg {
    if (!_imgvBg) {
        _imgvBg = [[UIImageView alloc] initWithFrame:self.bounds];
        _imgvBg.image = [UIImage imageNamed:@"TownBg"];
        _imgvBg.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _imgvBg;
}

- (UIScrollView *)scvTownShow {
    if (!_scvTownShow) {
        _scvTownShow = [[UIScrollView alloc] initWithFrame:self.bounds];
        [_scvTownShow setShowsVerticalScrollIndicator:NO];
        _scvTownShow.contentSize = CGSizeMake(kScreenWidth, 3 * kScreenHeight);
        [_scvTownShow setContentOffset:CGPointMake(0, kScreenHeight)];
        _scvTownShow.bounces = NO;
        _scvTownShow.pagingEnabled = YES;
        _scvTownShow.delegate = self;
    }
    return _scvTownShow;
}

- (TownView *)vUp {
    if (!_vUp) {
        _vUp = [[TownView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
        [_vUp setType:TownViewTypeUp];
        [_vUp setImage:5];
        _vUp.delegate = self;
    }
    return _vUp;
}

- (TownView *)vCenter {
    if (!_vCenter) {
        _vCenter = [[TownView alloc] initWithFrame:CGRectMake(0, kScreenHeight, kScreenWidth, kScreenHeight)];
        [_vCenter setType:TownViewTypeCenter];
        [_vCenter setImage:0];
        _vCenter.delegate = self;
    }
    return _vCenter;
}

- (TownView *)vDown {
    if (!_vDown) {
        _vDown = [[TownView alloc] initWithFrame:CGRectMake(0, kScreenHeight * 2, kScreenWidth, kScreenHeight)];
        [_vDown setType:TownViewTypeDown];
        [_vDown setImage:1];
        _vDown.delegate = self;
    }
    return _vDown;
}

- (TownView *)vChange {
    if (!_vChange) {
        _vChange = [[TownView alloc] initWithFrame:CGRectMake(0, kScreenHeight * 3, kScreenWidth, kScreenHeight)];
        [_vChange setType:TownViewTypeDowndown];
        [_vChange setImage:2];
        _vChange.delegate = self;
    }
    return _vChange;
}

@end
