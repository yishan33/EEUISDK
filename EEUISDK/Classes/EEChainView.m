//
//  EEChainView.m
//  EEMobileTest
//
//  Created by 刘赋山 on 2018/5/9.
//  Copyright © 2018年 刘赋山. All rights reserved.
//

#import "EEChainView.h"
#import "Masonry.h"

static CGFloat defaultCellWidth = 44.0f;
static CGFloat defaultCellHeight = 44.0f;

@interface EEChainView ()

@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) EEChainViewCell *lastCell;

@property (nonatomic, assign) CGFloat rotateCorner;
@property (nonatomic, assign) CGPoint lastRowCenter;
@property (nonatomic, assign) CGSize lastRowSize;
@property (nonatomic, strong) NSMapTable *subViewIndexMap;

@end

@implementation EEChainView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self configUI];
    }
    return self;
}

- (void)configUI {
    
    NSInteger numberOfRows = [self numberOfRows];
    for (NSInteger i = 0; i < numberOfRows; i++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
        UIControl *cell = [self chainView:self cellForRowAtIndexPath:indexPath];
        [cell addTarget:self action:@selector(didSelectRowAtIndexPath:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:cell];
        
        CGPoint rowCenter = [self centerOfRowAtIndexPath:indexPath];
        CGSize rowSize = [self sizeForRowAtIndexPath:indexPath];
        [cell mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.mas_left).offset(rowCenter.x);
            make.centerY.mas_equalTo(self.mas_top).offset(rowCenter.y);
            make.size.mas_equalTo(rowSize);
        }];
    }
}

- (void)reloadData {
    if (!self.dataSource || [self numberOfRows] == 0) {
        return ;
    }
    [self clearData];
    [self clearViews];
    [self configUI];
}

#pragma mark -

- (void)clearViews {
    [self.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj removeFromSuperview];
    }];
}

- (void)clearData {
    _lastRowCenter = CGPointZero;
    _lastRowSize = CGSizeZero;
    [_subViewIndexMap removeAllObjects];
    _subViewIndexMap = nil;
}

- (CGPoint)centerOfRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (_layoutAllCustom && [self.delegate respondsToSelector:@selector(chainView:centerForRowAtIndexPath:)]) {
        return [self.delegate chainView:self centerForRowAtIndexPath:indexPath];
    }
    
    CGSize rowSize = [self sizeForRowAtIndexPath:indexPath];
    CGPoint rowCenter = CGPointZero;
    if (CGPointEqualToPoint(_lastRowCenter, CGPointZero)) {
    
        if(fabs(tan(_rotateCorner)) < 1.0f)  {
            CGFloat centerX = cos(_rotateCorner) > 0 ? rowSize.width / 2 : self.contentSize.width - rowSize.width / 2;
            CGFloat sign = cos(_rotateCorner) > 0 ? -1 : 1;
            CGFloat centerY = self.contentSize.height / 2 -  sign * tan(_rotateCorner) * (self.contentSize.width - rowSize.width) / 2;
            rowCenter = CGPointMake(centerX, centerY);
        }
        else {
            CGFloat centerY = sin(_rotateCorner) < 0 ? rowSize.height / 2 : self.contentSize.height - rowSize.height / 2;
            CGFloat sign = sin(_rotateCorner) < 0 ? 1 : -1;
            CGFloat centerX = self.contentSize.width / 2 + sign * (self.contentSize.height - rowSize.height) / 2 / tan(_rotateCorner);
            
            rowCenter = CGPointMake(centerX, centerY);
        }
    }
    else {
        CGSize spaceBetweenLastRow = [self spaceBetweenWithLastRowAtIndexPath:indexPath];
        CGFloat spaceX = rowSize.width / 2.0f + _lastRowSize.width / 2.0 + spaceBetweenLastRow.width;
        CGFloat spaceY  = rowSize.height / 2.0f + _lastRowSize.height / 2.0 + spaceBetweenLastRow.height;
        CGFloat spaceRadius = 0;
        if (fabs(fabs(tan(_rotateCorner)) - 1.0f) < 0.000001f) {
            spaceRadius = hypotf(spaceX, spaceY);
        }
        else if(fabs(tan(_rotateCorner)) < 1.0f)  {
            spaceRadius = hypotf(spaceX, spaceBetweenLastRow.height);
        }
        else {
            spaceRadius = hypotf(spaceY, spaceBetweenLastRow.width);
        }
        rowCenter.x  = _lastRowCenter.x + spaceRadius * cos(_rotateCorner);
        rowCenter.y = _lastRowCenter.y - spaceRadius * sin(_rotateCorner);
    }
    
    _lastRowCenter = rowCenter;
    _lastRowSize = rowSize;
    return rowCenter;
}

#pragma mark - Delegate

- (void)didSelectRowAtIndexPath:(EEChainViewCell *)sender {
    if ([self.delegate respondsToSelector:@selector(chainView:didSelectRowAtIndexPath:)]) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:sender.tag inSection:0];
        [self.delegate chainView:self didSelectRowAtIndexPath:indexPath];
    }
}

#pragma mark - DataSource
- (UIControl *)chainView:(EEChainView *)chainView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UIControl *cell = [[UIControl alloc] init];
    if ([self.dataSource respondsToSelector:@selector(chainView:cellForRowAtIndexPath:)]) {
        cell = [self.dataSource chainView:self cellForRowAtIndexPath:indexPath];
    }
    [self.subViewIndexMap setObject:@(indexPath.row) forKey:cell];
    return cell;
}

- (NSInteger)numberOfRows {
    NSUInteger numberOfRows = 0;
    numberOfRows = [self.dataSource numberOfRowsInChainView:self];
    return numberOfRows;
}

- (CGSize)sizeForRowAtIndexPath:(NSIndexPath *)indexPath {
    CGSize rowSize = CGSizeMake(defaultCellWidth, defaultCellHeight);
    if ([self.delegate respondsToSelector:@selector(chainView:sizeForRowAtIndexPath:)]) {
        rowSize = [self.delegate chainView:self sizeForRowAtIndexPath:indexPath];
    }
    return rowSize;
}

- (CGSize)spaceBetweenWithLastRowAtIndexPath:(NSIndexPath *)indexPath {
    CGSize spaceSize = CGSizeZero;
    if ([self.delegate respondsToSelector:@selector(chainView:spaceBetweenWithLastRowAtIndexPath:)]) {
        spaceSize = [self.delegate chainView:self spaceBetweenWithLastRowAtIndexPath:indexPath];
    }
    return spaceSize;
}

#pragma mark - Setter & Getter

- (void)setStartPoint:(CGPoint)startPoint {
    _startPoint = startPoint;
}

- (void)setEndPoint:(CGPoint)endPoint {
    CGPoint vectorPoint = CGPointMake(endPoint.x - _startPoint.x, endPoint.y - _startPoint.y);
    _rotateCorner = acos(vectorPoint.x / hypot(vectorPoint.x, vectorPoint.y));
}

- (NSMapTable *)subViewIndexMap {
    if (!_subViewIndexMap) {
        _subViewIndexMap = [NSMapTable mapTableWithKeyOptions:(NSPointerFunctionsOptions)NSPointerFunctionsStrongMemory valueOptions:(NSPointerFunctionsOptions)NSPointerFunctionsStrongMemory];
    }
    return _subViewIndexMap;
}

@end

@interface EEChainViewCell ()

@end

@implementation EEChainViewCell


@end

