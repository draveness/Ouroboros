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
            CGFloat percent = (position - scale.trigger) / scale.offset;
            return [scale calculateInternalValueWithPercent:percent];
        } else if (scale.trigger > position && (!afterScale || afterScale.trigger > scale.trigger)) {
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
    NSAssert(NO, @"FATAL ERROR, Unknown current value for property %@", @(self.property));
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
            if (scale.trigger >= currentScale.stop && (!afterScale || afterScale.trigger >= scale.stop)) {
                afterScale = scale;
            } else if (scale.stop <= currentScale.trigger && (!previousScale || previousScale.stop <= scale.trigger)) {
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
            case OURAnimationPropertyViewBackgroundColor: {
                _startValue = self.view.backgroundColor;
            }
                break;
            case OURAnimationPropertyViewBounds: {
                _startValue = [NSValue valueWithCGRect:self.view.bounds];
            }
                break;
            case OURAnimationPropertyViewFrame: {
                _startValue = [NSValue valueWithCGRect:self.view.frame];
            }
                break;
            case OURAnimationPropertyViewSize: {
                _startValue = [NSValue valueWithCGSize:self.view.frame.size];
            }
                break;
            case OURAnimationPropertyViewCenter: {
                _startValue = [NSValue valueWithCGPoint:self.view.center];
            }
                break;
            case OURAnimationPropertyViewCenterX: {
                _startValue = @(self.view.center.x);
            }
                break;
            case OURAnimationPropertyViewCenterY: {
                _startValue = @(self.view.center.y);
            }
                break;
            case OURAnimationPropertyViewOrigin: {
                _startValue = [NSValue valueWithCGPoint:self.view.frame.origin];
            }
                break;
            case OURAnimationPropertyViewOriginX: {
                _startValue = @(self.view.frame.origin.x);
            }
                break;
            case OURAnimationPropertyViewOriginY: {
                _startValue = @(self.view.frame.origin.y);
            }
                break;
            case OURAnimationPropertyViewWidth: {
                _startValue = @(self.view.frame.size.width);
            }
                break;
            case OURAnimationPropertyViewHeight: {
                _startValue = @(self.view.frame.size.height);
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
            case OURAnimationPropertyLayerFrame: {
                _startValue = [NSValue valueWithCGRect:self.view.layer.frame];
            }
                break;
            case OURAnimationPropertyLayerBounds: {
                _startValue = [NSValue valueWithCGRect:self.view.layer.bounds];
            }
                break;
            case OURAnimationPropertyLayerPosition: {
                _startValue = [NSValue valueWithCGPoint:self.view.layer.position];
            }
                break;
            case OURAnimationPropertyLayerZPosition: {
                _startValue = @(self.view.layer.zPosition);
            }
                break;
            case OURAnimationPropertyLayerAnchorPoint: {
                _startValue = [NSValue valueWithCGPoint:self.view.layer.anchorPoint];
            }
                break;
            case OURAnimationPropertyLayerAnchorPointZ: {
                _startValue = @(self.view.layer.anchorPointZ);
            }
                break;
            case OURAnimationPropertyLayerTransform: {
                _startValue = [NSValue valueWithCATransform3D:self.view.layer.transform];
            }
                break;
            case OURAnimationPropertyLayerBackgroundColor: {
                _startValue = [UIColor colorWithCGColor:self.view.layer.backgroundColor];
            }
                break;
            case OURAnimationPropertyLayerBorderColor: {
                _startValue = [UIColor colorWithCGColor:self.view.layer.borderColor];
            }
                break;
            case OURAnimationPropertyLayerBorderWidth: {
                _startValue = @(self.view.layer.borderWidth);
            }
                break;
            case OURAnimationPropertyLayerCornerRadius: {
                _startValue = @(self.view.layer.cornerRadius);
            }
                break;
            case OURAnimationPropertyLayerOpacity: {
                _startValue = @(self.view.layer.opacity);
            }
                break;

            default: {
                NSAssert(NO, @"Invalid OURAnimationProperty type. %@", @(self.property));
                _startValue = [[NSObject alloc] init];
            }
                break;
        }
    }
    return _startValue;
}

@end
