//
//  TownView.m
//  Ease
//
//  Created by 戴奕 on 2017/2/23.
//  Copyright © 2017年 戴奕. All rights reserved.
//

#import "TownView.h"

#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
#define kImageHeight 1.3*kScreenWidth

static NSArray *imageArr = nil;
static NSArray *imageArrUp = nil;
static NSArray *imageArrDown = nil;

@interface TownView ()

@property (nonatomic, strong) UIImageView *imgvCenter;
@property (nonatomic, strong) UIImageView *imgvUp;
@property (nonatomic, strong) UIImageView *imgvDown;

@property (nonatomic, assign) CGRect rect0;
@property (nonatomic, assign) CGRect rect1;
@property (nonatomic, assign) CGRect rect2;
@property (nonatomic, assign) CGRect rect3;
@property (nonatomic, assign) CGRect rect4;

@property (nonatomic, copy) NSArray *imageViewArr;

@property (nonatomic, strong) UITapGestureRecognizer *tapGesture;

@end

@implementation TownView

+ (void)initialize {
    if (self == TownView.class) {
        imageArrUp = @[[UIImage imageNamed:@"Town_1_1"], [UIImage imageNamed:@"Town_2_1"], [UIImage imageNamed:@"Town_3_1"], [UIImage imageNamed:@"Town_4_1"], [UIImage imageNamed:@"Town_5_1"], [UIImage imageNamed:@"Town_6_1"]];
        imageArr = @[[UIImage imageNamed:@"Town_1_2"], [UIImage imageNamed:@"Town_2_2"], [UIImage imageNamed:@"Town_3_2"], [UIImage imageNamed:@"Town_4_2"], [UIImage imageNamed:@"Town_5_2"], [UIImage imageNamed:@"Town_6_2"]];
        imageArrDown = @[[UIImage imageNamed:@"Town_1_3"], [UIImage imageNamed:@"Town_2_3"], [UIImage imageNamed:@"Town_3_3"], [UIImage imageNamed:@"Town_4_3"], [UIImage imageNamed:@"Town_5_3"], [UIImage imageNamed:@"Town_6_3"]];
    }
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.imgvCenter = [self getImageView];
        [self addSubview:self.imgvCenter];
        
        self.imgvUp = [self getImageView];
        [self addSubview:self.imgvUp];
        
        self.imgvDown = [self getImageView];
        [self addSubview:self.imgvDown];
        
        self.imageViewArr = @[self.imgvUp, self.imgvCenter, self.imgvDown];
    }
    return self;
}

// 新建一个imageView
- (UIImageView *)getImageView {
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    imageView.userInteractionEnabled = YES;
    return imageView;
}

// 根据下标一次性设置图片
- (void)setImage:(NSInteger)index {
    self.imgvCenter.image = imageArr[index];
    self.imgvUp.image = imageArrUp[index];
    self.imgvDown.image = imageArrDown[index];
}

- (void)setImageViewFrame:(CGRect)frame {
    [self.imageViewArr enumerateObjectsUsingBlock:^(UIImageView *imageView, NSUInteger idx, BOOL * _Nonnull stop) {
        imageView.frame = frame;
    }];
}

- (void)updateUIByPercent:(CGFloat)percent {
    if (percent > 0) {     // 代表往上拉
        if (self.type == TownViewTypeUpup) {
            self.type = TownViewTypeDowndown;
            
            self.frame = CGRectMake(0, 3 * kScreenHeight, kScreenWidth, kScreenHeight);
            
            NSInteger index = [imageArr indexOfObject:self.imgvCenter.image];
            if (index + 4 > imageArr.count - 1) {
                [self setImage:index + 4 - imageArr.count];
            } else {
                [self setImage:index + 4];
            }
        }
    } else if (percent < 0) {                // 代表往下拉
        if (self.type == TownViewTypeDowndown) {
            self.type = TownViewTypeUpup;
            
            self.frame = CGRectMake(0, -kScreenHeight, kScreenWidth, kScreenHeight);
            
            NSInteger index = [imageArr indexOfObject:self.imgvCenter.image];
            if (index - 4 < 0) {
                [self setImage:imageArr.count + index - 4];
            } else {
                [self setImage:index - 4];
            }
        }
    }
    
    if (percent > 0) {     // 代表往上拉
        switch (self.type) {
            case TownViewTypeUpup:
            {
                [self.imageViewArr enumerateObjectsUsingBlock:^(UIImageView *imageView, NSUInteger idx, BOOL * _Nonnull stop) {
                    imageView.frame = CGRectMake(self.rect0.origin.x + (self.rect4.origin.x - self.rect0.origin.x) * percent,
                                                 self.rect0.origin.y + (self.rect4.origin.y - self.rect0.origin.y) * percent,
                                                 self.rect0.size.width + (self.rect4.size.width - self.rect0.size.width) * percent,
                                                 self.rect0.size.height + (self.rect4.size.height - self.rect0.size.height) * percent);
                }];
                
            }
                break;
            case TownViewTypeUp:
            {
                [self.imageViewArr enumerateObjectsUsingBlock:^(UIImageView *imageView, NSUInteger idx, BOOL * _Nonnull stop) {
                    imageView.frame = CGRectMake(self.rect1.origin.x + (self.rect0.origin.x - self.rect1.origin.x) * percent,
                                                 self.rect1.origin.y + (self.rect0.origin.y - self.rect1.origin.y) * percent,
                                                 self.rect1.size.width + (self.rect0.size.width - self.rect1.size.width) * percent,
                                                 self.rect1.size.height + (self.rect0.size.height - self.rect1.size.height) * percent);
                }];
                
                self.imgvUp.alpha = 1 - percent;
            }
                break;
            case TownViewTypeCenter:
            {
                [self.imageViewArr enumerateObjectsUsingBlock:^(UIImageView *imageView, NSUInteger idx, BOOL * _Nonnull stop) {
                    imageView.frame = CGRectMake(self.rect2.origin.x + (self.rect1.origin.x - self.rect2.origin.x) * percent,
                                                 self.rect2.origin.y + (self.rect1.origin.y - self.rect2.origin.y) * percent,
                                                 self.rect2.size.width + (self.rect1.size.width - self.rect2.size.width) * percent,
                                                 self.rect2.size.height + (self.rect1.size.height - self.rect2.size.height) * percent);
                }];
                
                self.imgvUp.alpha = percent;
                self.imgvCenter.alpha = 1 - percent;
            }
                break;
            case TownViewTypeDown:
            {
                [self.imageViewArr enumerateObjectsUsingBlock:^(UIImageView *imageView, NSUInteger idx, BOOL * _Nonnull stop) {
                    imageView.frame = CGRectMake(self.rect3.origin.x + (self.rect2.origin.x - self.rect3.origin.x) * percent,
                                                 self.rect3.origin.y + (self.rect2.origin.y - self.rect3.origin.y) * percent,
                                                 self.rect3.size.width + (self.rect2.size.width - self.rect3.size.width) * percent,
                                                 self.rect3.size.height + (self.rect2.size.height - self.rect3.size.height) * percent);
                }];
                
                self.imgvCenter.alpha = percent;
                self.imgvDown.alpha = 1 - percent;
            }
                break;
            case TownViewTypeDowndown:
            {
                [self.imageViewArr enumerateObjectsUsingBlock:^(UIImageView *imageView, NSUInteger idx, BOOL * _Nonnull stop) {
                    imageView.frame = CGRectMake(self.rect4.origin.x + (self.rect3.origin.x - self.rect4.origin.x) * percent,
                                                 self.rect4.origin.y + (self.rect3.origin.y - self.rect4.origin.y) * percent,
                                                 self.rect4.size.width + (self.rect3.size.width - self.rect4.size.width) * percent,
                                                 self.rect4.size.height + (self.rect3.size.height - self.rect4.size.height) * percent);
                }];
                
                self.imgvDown.alpha = percent;
            }
                break;
        }
    } else if (percent < 0) {                // 代表往下拉
        switch (self.type) {
            case TownViewTypeUpup:
            {
                [self.imageViewArr enumerateObjectsUsingBlock:^(UIImageView *imageView, NSUInteger idx, BOOL * _Nonnull stop) {
                    imageView.frame = CGRectMake(self.rect0.origin.x + (self.rect1.origin.x - self.rect0.origin.x) * fabs(percent),
                                                 self.rect0.origin.y + (self.rect1.origin.y - self.rect0.origin.y) * fabs(percent),
                                                 self.rect0.size.width + (self.rect1.size.width - self.rect0.size.width) * fabs(percent),
                                                 self.rect0.size.height + (self.rect1.size.height - self.rect0.size.height) * fabs(percent));
                }];
                
                self.imgvUp.alpha = fabs(percent);
            }
                break;
            case TownViewTypeUp:
            {
                [self.imageViewArr enumerateObjectsUsingBlock:^(UIImageView *imageView, NSUInteger idx, BOOL * _Nonnull stop) {
                    imageView.frame = CGRectMake(self.rect1.origin.x + (self.rect2.origin.x - self.rect1.origin.x) * fabs(percent),
                                                 self.rect1.origin.y + (self.rect2.origin.y - self.rect1.origin.y) * fabs(percent),
                                                 self.rect1.size.width + (self.rect2.size.width - self.rect1.size.width) * fabs(percent),
                                                 self.rect1.size.height + (self.rect2.size.height - self.rect1.size.height) * fabs(percent));
                }];
                
                self.imgvUp.alpha = 1 - fabs(percent);
                self.imgvCenter.alpha = fabs(percent);
            }
                break;
            case TownViewTypeCenter:
            {
                [self.imageViewArr enumerateObjectsUsingBlock:^(UIImageView *imageView, NSUInteger idx, BOOL * _Nonnull stop) {
                    imageView.frame = CGRectMake(self.rect2.origin.x + (self.rect3.origin.x - self.rect2.origin.x) * fabs(percent),
                                                 self.rect2.origin.y + (self.rect3.origin.y - self.rect2.origin.y) * fabs(percent),
                                                 self.rect2.size.width + (self.rect3.size.width - self.rect2.size.width) * fabs(percent),
                                                 self.rect2.size.height + (self.rect3.size.height - self.rect2.size.height) * fabs(percent));
                }];
                
                self.imgvCenter.alpha = 1 - fabs(percent);
                self.imgvDown.alpha = fabs(percent);
            }
                break;
            case TownViewTypeDown:
            {
                [self.imageViewArr enumerateObjectsUsingBlock:^(UIImageView *imageView, NSUInteger idx, BOOL * _Nonnull stop) {
                    imageView.frame = CGRectMake(self.rect3.origin.x + (self.rect4.origin.x - self.rect3.origin.x) * fabs(percent),
                                                 self.rect3.origin.y + (self.rect4.origin.y - self.rect3.origin.y) * fabs(percent),
                                                 self.rect3.size.width + (self.rect4.size.width - self.rect3.size.width) * fabs(percent),
                                                 self.rect3.size.height + (self.rect4.size.height - self.rect3.size.height) * fabs(percent));
                }];
                
                self.imgvDown.alpha = 1 - fabs(percent);
            }
                break;
            case TownViewTypeDowndown:
            {
                [self.imageViewArr enumerateObjectsUsingBlock:^(UIImageView *imageView, NSUInteger idx, BOOL * _Nonnull stop) {
                    imageView.frame = CGRectMake(self.rect4.origin.x + (self.rect0.origin.x - self.rect4.origin.x) * fabs(percent),
                                                 self.rect4.origin.y + (self.rect0.origin.y - self.rect4.origin.y) * fabs(percent),
                                                 self.rect4.size.width + (self.rect0.size.width - self.rect4.size.width) * fabs(percent),
                                                 self.rect4.size.height + (self.rect0.size.height - self.rect4.size.height) * fabs(percent));
                }];
            }
                break;
        }
    }
}

- (void)changeType:(TownScrollType)type {
    // 图片变更
    NSInteger index = [imageArr indexOfObject:self.imgvCenter.image];
    
    switch (type) {
        case TownScrollTypeUp:
        {
            if (index == imageArr.count - 1) {
                [self setImage:0];
            } else {
                [self setImage:index + 1];
            }
        }
            break;
        case TownScrollTypeDown:
        {
            if (index == 0) {
                [self setImage:imageArrDown.count - 1];
            } else {
                [self setImage:index - 1];
            }
        }
            break;
    }
    
    // 位置变更
    [self setType:self.type];
}

- (void)setAlphaWithType:(TownViewType)type {
    [self.imageViewArr enumerateObjectsUsingBlock:^(UIImageView *imageView, NSUInteger idx, BOOL * _Nonnull stop) {
        imageView.alpha = (idx == (type - 1));
    }];
}

- (void)setType:(TownViewType)type {
    _type = type;
    
    [self setAlphaWithType:type];
    
    switch (type) {
        case TownViewTypeUpup:
        {
            [self setImageViewFrame:self.rect0];
        }
            break;
        case TownViewTypeUp:
        {
            [self setImageViewFrame:self.rect1];
        }
            break;
        case TownViewTypeCenter:
        {
            [self setImageViewFrame:self.rect2];
        }
            break;
        case TownViewTypeDown:
        {
            [self setImageViewFrame:self.rect3];
        }
            break;
        case TownViewTypeDowndown:
        {
            [self setImageViewFrame:self.rect4];
        }
            break;
    }
}

#pragma mark - event Methods
- (void)tapAction {
    if ([self.delegate respondsToSelector:@selector(townView:didClickWithType:)]) {
        [self.delegate townView:self didClickWithType:self.type];
    }
}

#pragma mark - setter and getter Methods
// 第0个图片
- (CGRect)rect0{
    return CGRectMake(0.35*kScreenWidth, kScreenHeight * 2 - 0.3*kImageHeight, 0.3*kScreenWidth, 0.3*kImageHeight);
}

// 第一个图片
- (CGRect)rect1 {
    return CGRectMake(0.35*kScreenWidth, kScreenHeight + 40, 0.3*kScreenWidth, 0.3*kImageHeight);
}

// 第二个图片
- (CGRect)rect2{
    return CGRectMake(0.15*kScreenWidth, kScreenHeight/2.0-0.35*kImageHeight, 0.7*kScreenWidth, 0.7*kImageHeight);
}

// 第三个图片
- (CGRect)rect3{
    return CGRectMake(0, 0 - 0.4 * kImageHeight, kScreenWidth, kImageHeight);
}

// 第四个图片
- (CGRect)rect4{
    return CGRectMake(0, -0.6 * kScreenHeight,  kScreenWidth, kImageHeight);
}

- (UITapGestureRecognizer *)tapGesture {
    if (_tapGesture == nil) {
        _tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];
    }
    return _tapGesture;
}

- (void)setDelegate:(id<TownViewDelegate>)delegate {
    _delegate = delegate;
    
    if (delegate == nil) {
        [self.imgvCenter removeGestureRecognizer:self.tapGesture];
    } else {
        [self.imgvCenter addGestureRecognizer:self.tapGesture];
    }
}

@end
