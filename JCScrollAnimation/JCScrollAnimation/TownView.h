//
//  TownView.h
//  JCScrollAnimation
//
//  Created by 戴奕 on 2017/2/23.
//  Copyright © 2017年 戴奕. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TownView;

typedef NS_ENUM(NSInteger, TownViewType) {
    TownViewTypeUpup = 0,   // 上面上面
    TownViewTypeUp,         // 上
    TownViewTypeCenter,     // 中间
    TownViewTypeDown,       // 下面
    TownViewTypeDowndown    // 下面下面
};

typedef NS_ENUM(NSInteger, TownScrollType) {
    TownScrollTypeUp,       // 往上滚
    TownScrollTypeDown      // 往下滚
};

@protocol TownViewDelegate <NSObject>

@optional
- (void)townView:(TownView *)townView didClickWithType:(TownViewType)type;

@end

@interface TownView : UIView

@property (nonatomic, weak) id<TownViewDelegate> delegate;

/**
 当前view类型
 */
@property (nonatomic, assign) TownViewType type;

/**
 根据滚动方向“复位”
 @param type 滚动类型
 @discussion 该方法内部会调节图片相关UI
 */
- (void)resetType:(TownScrollType)type;

/**
 根据当前滚动百分比更新UI
 @param percent 滚动一个屏幕的百分比
 @discussion 该方法内部会调节图片相关UI
 */
- (void)updateUIByPercent:(CGFloat)percent;

/**
 根据下标设置图片
 @param index 下标
 */
- (void)setImage:(NSInteger)index;

@end
