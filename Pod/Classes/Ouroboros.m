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
        } else if (scale.trggier > position) {
            afterScale = scale;
        } else if (scale.stop < position) {
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
    NSAssert(NO, @"Cannot find a UIScrollView on current view inheritance hierarchy");
    return nil;
}

#pragma mark - Getter/Setter

- (void)insertObject:(Scale *)currentScale inScalesAtIndex:(NSUInteger)index {
    Scale *previousScale = nil;
    Scale *afterScale = nil;
    for (Scale *scale in self.scales) {
        if ([scale isSeparateWithScale:currentScale]) {
            if (scale.trggier > currentScale.stop) {
                afterScale = scale;
            } else if (scale.stop < currentScale.trggier) {
                previousScale = scale;
            }
        } else {
            NSAssert(NO, @"Can not added an overlapping scales to the same ouroboros.");
        }
    }

    if (previousScale) {
        currentScale.fromValue = previousScale.toValue;
    } else {
        currentScale.fromValue = [self getViewStartValue];
    }
    if (afterScale) {
        afterScale.fromValue = currentScale.toValue;
    }
    [self.scales insertObject:currentScale atIndex:index];
}

- (void)removeObjectFromScalesAtIndex:(NSUInteger)index {
    [self.scales removeObjectAtIndex:index];
}

- (id)getViewStartValue {
    switch (self.property) {
        case OURAnimationPropertyViewBackgroundColor: {
            return self.view.backgroundColor;
        }
        case OURAnimationPropertyViewBounds: {
            return [NSValue valueWithCGRect:self.view.bounds];
        }
        case OURAnimationPropertyViewFrame: {
            return [NSValue valueWithCGRect:self.view.frame];
        }
        case OURAnimationPropertyViewSize: {
            return [NSValue valueWithCGSize:self.view.frame.size];
        }
        case OURAnimationPropertyViewCenter: {
            return [NSValue valueWithCGPoint:self.view.center];
        }
        case OURAnimationPropertyViewCenterX: {
            return @(self.view.center.x);
        }
        case OURAnimationPropertyViewCenterY: {
            return @(self.view.center.y);
        }
        case OURAnimationPropertyViewTintColor: {
            return self.view.tintColor;
        }
        case OURAnimationPropertyViewOrigin: {
            return [NSValue valueWithCGPoint:self.view.frame.origin];
        }
        case OURAnimationPropertyViewOriginX: {
            return @(self.view.frame.origin.x);
        }
        case OURAnimationPropertyViewOriginY: {
            return @(self.view.frame.origin.y);
        }
        case OURAnimationPropertyViewWidth: {
            return @(self.view.frame.size.width);
        }
        case OURAnimationPropertyViewHeight: {
            return @(self.view.frame.size.height);
        }
        case OURAnimationPropertyViewAlpha: {
            return @(self.view.alpha);
        }
        case OURAnimationPropertyViewTransform: {
            return [NSValue valueWithCGAffineTransform:self.view.transform];
        }
        default:
            NSAssert(NO, @"Invalid OURAnimationProperty type.");
            return [[NSValue alloc] init];
    }
}

@end
