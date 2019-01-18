//
//  UIView+Gradient.h
//  yykitTest
//
//  Created by 刘赋山 on 2018/12/4.
//  Copyright © 2018 刘赋山. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Gradient)

- (void)setGradientColors:(NSArray *)colors
               startPoint:(CGPoint)startPoint
                 endPoint:(CGPoint)endPoint
                locations:(NSArray <NSNumber *>*)locations;

- (void)setGradientColors:(NSArray *)colors
               startPoint:(CGPoint)startPoint
                 endPoint:(CGPoint)endPoint;

- (void)setProgressGradientColors:(NSArray *)colors
                       startPoint:(CGPoint)startPoint
                         endPoint:(CGPoint)endPoint;

- (void)setProgressImage:(UIImage *)image;

- (void)setProgressWidth:(CGFloat)width height:(CGFloat)height;

@end
