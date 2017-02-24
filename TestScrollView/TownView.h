//
//  TownView.h
//  Ease
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
    TownScrollTypeUp,
    TownScrollTypeDown
};

@protocol TownViewDelegate <NSObject>

@optional
- (void)townView:(TownView *)townView didClickWithType:(TownViewType)type;

@end

@interface TownView : UIView

@property (nonatomic, weak) id<TownViewDelegate> delegate;

@property (nonatomic, assign) TownViewType type;

- (void)changeType:(TownScrollType)type;
- (void)updateUIByPercent:(CGFloat)percent;
- (void)setImage:(NSInteger)index;

@end
