//
//  TownAnimationView.h
//  JCScrollAnimation
//
//  Created by 戴奕 on 2017/2/24.
//  Copyright © 2017年 戴奕. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TownAnimationView;

@protocol TownAnimationViewDelegate <NSObject>

@optional
/**
 改变当前显示图片
 @param townAnimationView 当前自身view
 @param index 改变到的下标
 */
- (void)townAnimationView:(TownAnimationView *)townAnimationView didChangeAtIndex:(NSInteger)index;

/**
 点击了图片
 @param townAnimationView 当前自身view
 @param index 点击图片的下标
 */
- (void)townAnimationView:(TownAnimationView *)townAnimationView didClickAtIndex:(NSInteger)index;

/**
 停止滚动
 @param townAnimationView 当前自身view
 @param index 停止滚动后，停留的图片下标
 */
- (void)townAnimationView:(TownAnimationView *)townAnimationView didEndDeceleratingAtIndex:(NSInteger)index;

@end

@interface TownAnimationView : UIView

@property (nonatomic, weak) id<TownAnimationViewDelegate> delegate;
/**
 是否在拖拽中
 */
@property (nonatomic, assign, getter=isDrag, readonly) BOOL drag;
/**
 当前页
 */
@property (nonatomic, assign, readonly) NSInteger currentPage;

@end
