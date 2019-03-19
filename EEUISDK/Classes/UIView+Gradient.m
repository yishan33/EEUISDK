//
//  UIView+Gradient.m
//  yykitTest
//
//  Created by 刘赋山 on 2018/12/4.
//  Copyright © 2018 刘赋山. All rights reserved.
//

#import "UIView+Gradient.h"
#import <objc/runtime.h>

static NSString * const kProgressLayer = @"kProgressLayer";

@interface UIView ()

@property (nonatomic, strong) CAGradientLayer *progressLayer;

@end

@implementation UIView (Gradient)

+ (Class)layerClass {
    return [CAGradientLayer class];
}

- (void)setGradientColors:(NSArray *)colors
               startPoint:(CGPoint)startPoint
                 endPoint:(CGPoint)endPoint
                locations:(NSArray <NSNumber *>*)locations
{
    CAGradientLayer *layer = (CAGradientLayer *)self.layer;
    layer.colors = colors;
    layer.startPoint = startPoint;
    layer.endPoint = endPoint;
    if (locations.count > 0) {
        layer.locations = locations;
    }
}

- (void)setGradientColors:(NSArray *)colors
               startPoint:(CGPoint)startPoint
                 endPoint:(CGPoint)endPoint {
    [self setGradientColors:colors startPoint:startPoint endPoint:endPoint locations:@[]];
}

- (void)setProgressGradientColors:(NSArray *)colors
                       startPoint:(CGPoint)startPoint
                         endPoint:(CGPoint)endPoint
                        locations:(NSArray <NSNumber *>*)locations {
    if (!self.progressLayer) {
        self.progressLayer = [[CAGradientLayer alloc] init];
        [self.layer addSublayer:self.progressLayer];
    }
    self.progressLayer.colors = colors;
    self.progressLayer.startPoint = startPoint;
    self.progressLayer.endPoint = endPoint;
    if (locations.count > 0) {
        self.progressLayer.locations = locations;
    }
}

- (void)setProgressGradientColors:(NSArray *)colors
                       startPoint:(CGPoint)startPoint
                         endPoint:(CGPoint)endPoint {
    [self setProgressGradientColors:colors startPoint:startPoint endPoint:endPoint locations:@[]];
}

- (void)setProgressImage:(UIImage *)image {
    if (!self.progressLayer) {
        self.progressLayer = [[CAGradientLayer alloc] init];
        [self.layer addSublayer:self.progressLayer];
    }
    self.progressLayer.contents = (id)image.CGImage;
}

- (void)setProgressWidth:(CGFloat)width height:(CGFloat)height {
    self.progressLayer.frame = CGRectMake(0, 0, width, height);
}

#pragma mark -

- (void)setProgressLayer:(CAGradientLayer *)progressLayer {
    objc_setAssociatedObject(self, &kProgressLayer, progressLayer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CAGradientLayer *)progressLayer {
    return objc_getAssociatedObject(self, &kProgressLayer);
}

@end

@implementation UILabel (Gradient)

+ (Class)layerClass {
    return [CAGradientLayer class];
}

@end

