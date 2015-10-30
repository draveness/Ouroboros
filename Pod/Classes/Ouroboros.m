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

@end

@implementation Ouroboros

- (instancetype)initWithView:(UIView *)view {
    if (self = [super init]) {
        _view = view;
    }
    return self;
}

- (void)animateWithProperty:(OURAnimationProperty)property configureBlock:(OuroborosAnimationBlock)configureBlock {
    [[NSNotificationCenter defaultCenter] addObserver:self.view selector:@selector(updateState:) name:@"ScrollView" object:nil];

    self.property = property;
    configureBlock(self);
    [self.view.ouroboroses addObject:self];
}

- (void)pinWithConfigureBlock:(OuroborosAnimationBlock)configureBlock {
    __weak typeof(self) weakSelf = self;
    OURAnimationProperty property = [[self closestScrollView] ou_scrollDirection] ? OURAnimationPropertyViewCenterX : OURAnimationPropertyViewCenterY;
    [self animateWithProperty:property configureBlock:^(Ouroboros * _Nonnull ouroboros) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if (strongSelf) {
            configureBlock(ouroboros);
            ouroboros.toValue = @([strongSelf.fromValue floatValue] + strongSelf.offset);
        }
    }];
}

- (id)calculateInternalValueWithPercent:(CGFloat)percent {
    percent= [self justifyPercent:percent];

    id result = [[NSValue alloc] init];
    if ([self.fromValue isKindOfClass:[NSNumber class]]) {
        CGFloat fromValue = [self.fromValue floatValue];
        CGFloat toValue = [self.toValue floatValue];

        CGFloat resultValue = fromValue + (toValue - fromValue) * percent;
        result = @(resultValue);
    } else if ([self.fromValue isKindOfClass:[UIColor class]]) {
        UIColor *fromValue = self.fromValue;
        UIColor *toValue = self.toValue;

        const CGFloat *fromComponents = CGColorGetComponents(fromValue.CGColor);
        const CGFloat *toComponents = CGColorGetComponents(toValue.CGColor);

        CGFloat redComponent = fromComponents[0] + (toComponents[0] - fromComponents[0]) * percent;
        CGFloat greenComponent = fromComponents[1] + (toComponents[1] - fromComponents[1]) * percent;
        CGFloat blueComponent = fromComponents[2] + (toComponents[2] - fromComponents[2]) * percent;
        CGFloat alphaComponent = fromComponents[3] + (toComponents[3] - fromComponents[3]) * percent;

        result = [UIColor colorWithRed:redComponent green:greenComponent blue:blueComponent alpha:alphaComponent];
    } else if ([self.fromValue isKindOfClass:[NSValue class]]) {
        NSString *valueType = [NSString stringWithCString:[self.fromValue objCType] encoding:NSStringEncodingConversionAllowLossy];
        if ([valueType containsString:@"CGRect"]) {
            CGRect fromValue = [self.fromValue CGRectValue];
            CGRect toValue = [self.toValue CGRectValue];

            CGRect resultValue =
            CGRectMake(
                       fromValue.origin.x + (toValue.origin.x - fromValue.origin.x) * percent,
                       fromValue.origin.y + (toValue.origin.y - fromValue.origin.y) * percent,
                       fromValue.size.width + (toValue.size.width - fromValue.size.width) * percent,
                       fromValue.size.height + (toValue.size.height - fromValue.size.height) * percent
                       );
            result = [NSValue valueWithCGRect:resultValue];
        } else if ([valueType containsString:@"CGSize"]) {
            CGSize fromValue = [self.fromValue CGSizeValue];
            CGSize toValue = [self.toValue CGSizeValue];

            CGSize resultValue =
            CGSizeMake(
                       fromValue.width + (toValue.width - fromValue.width) * percent,
                       fromValue.height + (toValue.height - fromValue.height) * percent
                       );
            result = [NSValue valueWithCGSize:resultValue];
        } else if ([valueType containsString:@"CGPoint"]) {
            CGPoint fromValue = [self.fromValue CGPointValue];
            CGPoint toValue = [self.toValue CGPointValue];

            CGPoint resultValue =
            CGPointMake(
                       fromValue.x + (toValue.x - fromValue.x) * percent,
                       fromValue.y + (toValue.y - fromValue.y) * percent
                       );
            result = [NSValue valueWithCGPoint:resultValue];
        } else if ([valueType containsString:@"CATransform3D"]) {
            CATransform3D fromTransform = [self.fromValue CATransform3DValue];
            CATransform3D toTransform = [self.toValue CATransform3DValue];

            CATransform3D resultValue = CATransform3DIdentity;
            CGFloat m11 = fromTransform.m11 + (toTransform.m11 - fromTransform.m11) * percent;
            CGFloat m12 = fromTransform.m12 + (toTransform.m12 - fromTransform.m12) * percent;
            CGFloat m13 = fromTransform.m13 + (toTransform.m13 - fromTransform.m13) * percent;
            CGFloat m14 = fromTransform.m14 + (toTransform.m14 - fromTransform.m14) * percent;
            CGFloat m21 = fromTransform.m21 + (toTransform.m21 - fromTransform.m21) * percent;
            CGFloat m22 = fromTransform.m22 + (toTransform.m22 - fromTransform.m22) * percent;
            CGFloat m23 = fromTransform.m23 + (toTransform.m23 - fromTransform.m23) * percent;
            CGFloat m24 = fromTransform.m24 + (toTransform.m24 - fromTransform.m24) * percent;
            CGFloat m31 = fromTransform.m31 + (toTransform.m31 - fromTransform.m31) * percent;
            CGFloat m32 = fromTransform.m32 + (toTransform.m32 - fromTransform.m32) * percent;
            CGFloat m33 = fromTransform.m33 + (toTransform.m33 - fromTransform.m33) * percent;
            CGFloat m34 = fromTransform.m34 + (toTransform.m34 - fromTransform.m34) * percent;
            CGFloat m41 = fromTransform.m41 + (toTransform.m41 - fromTransform.m41) * percent;
            CGFloat m42 = fromTransform.m42 + (toTransform.m42 - fromTransform.m42) * percent;
            CGFloat m43 = fromTransform.m43 + (toTransform.m43 - fromTransform.m43) * percent;
            CGFloat m44 = fromTransform.m44 + (toTransform.m44 - fromTransform.m44) * percent;

            resultValue.m11 = m11;
            resultValue.m12 = m12;
            resultValue.m13 = m13;
            resultValue.m14 = m14;
            resultValue.m21 = m21;
            resultValue.m22 = m22;
            resultValue.m23 = m23;
            resultValue.m24 = m24;
            resultValue.m31 = m31;
            resultValue.m32 = m32;
            resultValue.m33 = m33;
            resultValue.m34 = m34;
            resultValue.m41 = m41;
            resultValue.m42 = m42;
            resultValue.m43 = m43;
            resultValue.m44 = m44;

            result = [NSValue valueWithCATransform3D:resultValue];
        }
    }

    return result;
}

- (CGFloat)justifyPercent:(CGFloat)percent {
    if (percent < 0) {
        return 0;
    } else if (percent > 1) {
        return 1;
    } else {
        return percent;
    }
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


- (id)fromValue {
    if (!_fromValue) {
        switch (self.property) {
            case OURAnimationPropertyViewBackgroundColor: {
                _fromValue = self.view.backgroundColor;
            }
                break;
            case OURAnimationPropertyViewBounds: {
                _fromValue = [NSValue valueWithCGRect:self.view.bounds];
            }
                break;
            case OURAnimationPropertyViewFrame: {
                _fromValue = [NSValue valueWithCGRect:self.view.frame];
            }
                break;
            case OURAnimationPropertyViewSize: {
                _fromValue = [NSValue valueWithCGSize:self.view.frame.size];
            }
                break;
            case OURAnimationPropertyViewCenter: {
                _fromValue = [NSValue valueWithCGPoint:self.view.center];
            }
                break;
            case OURAnimationPropertyViewCenterX: {
                _fromValue = @(self.view.center.x);
            }
                break;
            case OURAnimationPropertyViewCenterY: {
                _fromValue = @(self.view.center.y);
            }
                break;
            case OURAnimationPropertyViewTintColor: {
                _fromValue = self.view.tintColor;
            }
                break;
            case OURAnimationPropertyViewOrigin: {
                _fromValue = [NSValue valueWithCGPoint:self.view.frame.origin];
            }
                break;
            case OURAnimationPropertyViewOriginX: {
                _fromValue = @(self.view.frame.origin.x);
            }
                break;
            case OURAnimationPropertyViewOriginY: {
                _fromValue = @(self.view.frame.origin.y);
            }
                break;
            case OURAnimationPropertyViewWidth: {
                _fromValue = @(self.view.frame.size.width);
            }
                break;
            case OURAnimationPropertyViewHeight: {
                _fromValue = @(self.view.frame.size.height);
            }
                break;
            case OURAnimationPropertyViewAlpha: {
                _fromValue = @(self.view.alpha);
            }
                break;
            case OURAnimationPropertyViewTransform: {
                _fromValue = [NSValue valueWithCGAffineTransform:self.view.transform];
            }
                break;
            default:
                break;
        }
    }
    return _fromValue;
}

@end
