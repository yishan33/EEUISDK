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

typedef NS_ENUM(NSUInteger, EEprogressTagPosition) {
    EEprogressTagPositionNone = 0,
    EEprogressTagPositionUp,
    EEprogressTagPositionDown,
    EEprogressTagPositionLeft,
    EEprogressTagPositionRight
};

@interface EEProgressView : UIView

@property (nonatomic, readonly, strong) UIImageView *frontView;
@property (nonatomic, readonly, strong) UIImageView *backView;
@property (nonatomic, readonly, strong) UIImageView *effectAnimationView;
@property (nonatomic, readonly, strong) UIView *tagView;

//若通过 init方法初始化时，则必须赋值contentSize
@property (nonatomic, assign) CGSize contentSize;
@property (nonatomic, assign) EEProgressRiseDirection direction;

@property (nonatomic, assign) EEProgressEffectType effectType;
@property (nonatomic, assign) EEProgressEffectDuration effectDuration;
@property (nonatomic, strong) NSArray *effectImgs;
@property (nonatomic, assign) CGSize effectViewSize;

- (instancetype)initWithContentSize:(CGSize)size;

- (void)setFrontLength:(CGFloat)fLength backLength:(CGFloat)bLength;

- (void)setProgressValue:(CGFloat)progressValue animation:(BOOL)animation duration:(CGFloat)duration;

- (void)setContentCornerRadius:(CGFloat)radius;

- (void)setTagPosition:(EEprogressTagPosition)tagPosition size:(CGSize)size;
@end

//尽量按照示例的顺序设置属性。
//Example1. 带背景色、带图片、带特效，偏向对抗PK条

//[self.view addSubview:self.progressView];
//[self.progressView mas_makeConstraints:^(MASConstraintMaker *make) {
//    make.center.equalTo(self.view);
//    make.size.mas_equalTo(CGSizeMake(250, 15));
//}];
//self.progressView.contentSize = CGSizeMake(250, 250);
//[self.progressView setContentCornerRadius:7.5];
//self.progressView.frontView.backgroundColor = [UIColor redColor];
//self.progressView.backView.backgroundColor = [UIColor blueColor];
//self.progressView.frontView.image = [UIImage imageNamed:@"progressLeft.jpg"];
//self.progressView.backView.image = [UIImage imageNamed:@"progressRight.jpg"];
//[self.progressView setFrontLength:3 backLength:3];
//self.progressView.direction = EEProgressRiseDirectionRight;
//self.progressView.effectAnimationView.image = [UIImage imageNamed:@"pk_rocket_left_1"];
//self.progressView.effectImgs = @[[UIImage imageNamed:@"pk_rocket_left_1"],
//                                 [UIImage imageNamed:@"pk_rocket_left_2"],
//                                 [UIImage imageNamed:@"pk_rocket_left_3"]];
//self.progressView.effectType = EEProgressEffectTypeFrameAnimation;
//self.progressView.effectDuration = EEProgressEffectDurationOnMove;
//self.progressView.effectViewSize = CGSizeMake(70, 35);

//Example2. 带渐变色。偏向进度条

// self.progressView.contentSize = CGSizeMake(15, 250);
// [self.progressView.leftView setGradientColors:@[(id)[UIColor redColor].CGColor, (id)[UIColor blueColor].CGColor] startPoint:CGPointZero endPoint:CGPointMake(1, 0)];
// self.progressView.direction = EEProgressRiseDirectionRight;
