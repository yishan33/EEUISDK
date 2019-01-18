//
//  EEProgressView.h
//  yykitTest
//
//  Created by 刘赋山 on 2019/1/15.
//  Copyright © 2019 刘赋山. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, EEProgressEffectType) {
    EEProgressEffectTypeNone,
    EEProgressEffectTypeImage,
    EEProgressEffectTypeView,
    EEProgressEffectTypeFrameAnimation,
};

typedef NS_ENUM(NSUInteger, EEProgressEffectDuration) {
    EEProgressEffectDurationNone,
    EEProgressEffectDurationOnMove,
    EEProgressEffectDurationAlways,
};

typedef NS_ENUM(NSUInteger, EEProgressRiseDirection) {
    EEProgressRiseDirectionRight = 1 << 0,
    EEProgressRiseDirectionLeft = 1 << 1,
    EEProgressRiseDirectionUp = 1 << 2,
    EEProgressRiseDirectionDown = 1 << 3,
    EEProgressRiseDirectionHorizontal = EEProgressRiseDirectionRight | EEProgressRiseDirectionLeft,
    EEProgressRiseDirectionVertical = EEProgressRiseDirectionUp | EEProgressRiseDirectionDown,
};

@interface EEProgressView : UIView

@property (nonatomic, readonly, strong) UIImageView *frontView;
@property (nonatomic, readonly, strong) UIImageView *backView;
@property (nonatomic, readonly,strong) UIImageView *effectAnimationView;

//必须实现
@property (nonatomic, assign) CGSize contentSize;

@property (nonatomic, assign) EEProgressRiseDirection direction;
@property (nonatomic, assign) EEProgressEffectType effectType;
@property (nonatomic, assign) EEProgressEffectDuration effectDuration;
@property (nonatomic, strong) NSArray *effectImgs;
@property (nonatomic, assign) CGSize effectViewSize;

- (void)setFrontLength:(CGFloat)fLength backLength:(CGFloat)bLength;

- (void)setProgressValue:(CGFloat)progressValue animation:(BOOL)animation;

- (void)setContentCornerRadius:(CGFloat)radius;
@end
