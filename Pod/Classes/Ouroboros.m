//
//  Ouroboros.m
//  Ouroboros
//
//  Created by Draveness on 15/10/23.
//  Copyright © 2015年 Draveness. All rights reserved.
//

#import "Ouroboros.h"

@interface Ouroboros ()

@property (nonatomic, assign, readwrite) OURAnimationProperty property;
@property (nonatomic, strong, readwrite) NSMutableArray<Scale *> *scales;
@property (nonatomic, strong) id startValue;

@end

@implementation Ouroboros

NSValue *NSValueFromCGRectParameters(CGFloat x, CGFloat y, CGFloat width, CGFloat height) {
    return [NSValue valueWithCGRect:CGRectMake(x, y, width, height)];
}

NSValue *NSValueFromCGPointParameters(CGFloat x, CGFloat y) {
    return [NSValue valueWithCGPoint:CGPointMake(x, y)];
}

NSValue *NSValueFromCGSizeParameters(CGFloat width, CGFloat height) {
    return [NSValue valueWithCGSize:CGSizeMake(width, height)];
}

- (instancetype)initWithView:(UIView *)view property:(OURAnimationProperty)property {
    if (self = [super init]) {
        _view = view;
        _property = property;
        _scales =  [[NSMutableArray alloc] init];
        _startValue = [self startValue];
    }
    return self;
}

- (id)getCurrentValueWithPosition:(CGFloat)position {
    Scale *previousScale = nil;
    Scale *afterScale = nil;
    for (Scale *scale in self.scales) {
        if ([scale isCurrentPositionOnScale:position]) {
            CGFloat percent = (position - scale.trggier) / scale.offset;
            return [scale calculateInternalValueWithPercent:percent];
        } else if (scale.trggier > position && (!afterScale || afterScale.trggier > scale.trggier)) {
            afterScale = scale;
        } else if (scale.stop < position && (!previousScale || previousScale.stop < scale.stop)) {
            previousScale = scale;
        }
    }
    if (previousScale) {
        return previousScale.toValue;
    } else if (afterScale) {
        return afterScale.fromValue;
    }
    return [[NSObject alloc] init];
}

- (UIScrollView *)closestScrollView {
    UIView *superview = self.view.superview;
    while (superview) {
        if ([superview isKindOfClass:[UIScrollView class]]) {
            return (UIScrollView *)superview;
        }
        superview = superview.superview;
    }
    NSAssert(NO, @"Can not find a UIScrollView on current view inheritance hierarchy");
    return nil;
}

#pragma mark - Getter/Setter

- (void)insertObject:(Scale *)currentScale inScalesAtIndex:(NSUInteger)index {
    Scale *previousScale = nil;
    Scale *afterScale = nil;
    for (Scale *scale in self.scales) {
        if ([scale isSeparateWithScale:currentScale]) {
            if (scale.trggier >= currentScale.stop && (!afterScale || afterScale.trggier >= scale.stop)) {
                afterScale = scale;
            } else if (scale.stop <= currentScale.trggier && (!previousScale || previousScale.stop <= scale.trggier)) {
                previousScale = scale;
            }
        } else {
            NSAssert(NO, @"Can not added an overlapping scales to the same ouroboros.");
        }
    }

    if (previousScale) {
        currentScale.fromValue = previousScale.toValue;
    } else {
        currentScale.fromValue = self.startValue;
    }
    if (afterScale) {
        afterScale.fromValue = currentScale.toValue;
    }
    [self.scales insertObject:currentScale atIndex:index];
}

- (void)removeObjectFromScalesAtIndex:(NSUInteger)index {
    [self.scales removeObjectAtIndex:index];
}

- (id)startValue {
    if (!_startValue) {
        switch (self.property) {
            case OURAnimationPropertyViewFrame:
            case OURAnimationPropertyViewBounds:
            case OURAnimationPropertyViewSize:
            case OURAnimationPropertyViewCenter: 
            case OURAnimationPropertyViewCenterX: 
            case OURAnimationPropertyViewCenterY: 
            case OURAnimationPropertyViewOrigin: 
            case OURAnimationPropertyViewOriginX: 
            case OURAnimationPropertyViewOriginY: 
            case OURAnimationPropertyViewWidth: 
            case OURAnimationPropertyViewHeight: {
                _startValue = [NSValue valueWithCGRect:self.view.frame];
            }
                break;
            case OURAnimationPropertyViewBackgroundColor: {
                _startValue = self.view.backgroundColor;
            }
                break;
            case OURAnimationPropertyViewTintColor: {
                _startValue = self.view.tintColor;
            }
                break;
            case OURAnimationPropertyViewAlpha: {
                _startValue = @(self.view.alpha);
            }
                break;
            case OURAnimationPropertyViewTransform: {
                _startValue = [NSValue valueWithCGAffineTransform:self.view.transform];
            }
                break;
            default: {
                NSAssert(NO, @"Invalid OURAnimationProperty type.");
                _startValue = [[NSObject alloc] init];
            }
                break;
        }
    }
    return _startValue;
}

@end
