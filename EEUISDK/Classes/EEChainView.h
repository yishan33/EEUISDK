//
//  EEChainView.h
//  EEMobileTest
//
//  Created by 刘赋山 on 2018/5/9.
//  Copyright © 2018年 刘赋山. All rights reserved.
//

#import <UIKit/UIKit.h>

@class EEChainView;

@protocol EEChainViewDelegate <NSObject>

@optional

- (void)chainView:(EEChainView *)chainView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
- (CGSize)chainView:(EEChainView *)chainView sizeForRowAtIndexPath:(NSIndexPath *)indexPath;

- (CGSize)chainView:(EEChainView *)chainView spaceBetweenWithLastRowAtIndexPath:(NSIndexPath *)indexPath;
- (CGPoint)chainView:(EEChainView *)chainView centerForRowAtIndexPath:(NSIndexPath *)indexPath;

@end

@protocol EEChainViewDataSource <NSObject>

@required
- (NSInteger)numberOfRowsInChainView:(EEChainView *)chainView;
- (UIControl *)chainView:(EEChainView *)chainView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
@end

@interface EEChainView : UIView

@property (nonatomic, assign) CGSize contentSize;
@property (nonatomic, assign) CGPoint startPoint;
@property (nonatomic, assign) CGPoint endPoint;
@property (nonatomic, assign) BOOL layoutAllCustom;

@property (nonatomic, weak) id <EEChainViewDelegate> delegate;
@property (nonatomic, weak) id <EEChainViewDataSource> dataSource;

- (void)reloadData;
@end

@protocol EEChainViewCellProtocol <NSObject>

@optional
- (void)updateToEmptySeatView;

@end

@interface EEChainViewCell : UIControl

@property (nonatomic, strong) NSIndexPath *indexPath;

@end


