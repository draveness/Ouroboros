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
//@property (nonatomic, strong) NSMutableArray *fromValues;
//@property (nonatomic, strong) NSMutableArray *toValues;

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

- (NSMutableArray<Scale *> *)scales {
    if (!_scales) {
        _scales = [[NSMutableArray alloc] init];
    }
    return _scales;
}

//- (id)fromValue {
//    if (!_fromValue) {
//        switch (self.property) {
//            case OURAnimationPropertyViewBackgroundColor: {
//                _fromValue = self.view.backgroundColor;
//            }
//                break;
//            case OURAnimationPropertyViewBounds: {
//                _fromValue = [NSValue valueWithCGRect:self.view.bounds];
//            }
//                break;
//            case OURAnimationPropertyViewFrame: {
//                _fromValue = [NSValue valueWithCGRect:self.view.frame];
//            }
//                break;
//            case OURAnimationPropertyViewSize: {
//                _fromValue = [NSValue valueWithCGSize:self.view.frame.size];
//            }
//                break;
//            case OURAnimationPropertyViewCenter: {
//                _fromValue = [NSValue valueWithCGPoint:self.view.center];
//            }
//                break;
//            case OURAnimationPropertyViewCenterX: {
//                _fromValue = @(self.view.center.x);
//            }
//                break;
//            case OURAnimationPropertyViewCenterY: {
//                _fromValue = @(self.view.center.y);
//            }
//                break;
//            case OURAnimationPropertyViewTintColor: {
//                _fromValue = self.view.tintColor;
//            }
//                break;
//            case OURAnimationPropertyViewOrigin: {
//                _fromValue = [NSValue valueWithCGPoint:self.view.frame.origin];
//            }
//                break;
//            case OURAnimationPropertyViewOriginX: {
//                _fromValue = @(self.view.frame.origin.x);
//            }
//                break;
//            case OURAnimationPropertyViewOriginY: {
//                _fromValue = @(self.view.frame.origin.y);
//            }
//                break;
//            case OURAnimationPropertyViewWidth: {
//                _fromValue = @(self.view.frame.size.width);
//            }
//                break;
//            case OURAnimationPropertyViewHeight: {
//                _fromValue = @(self.view.frame.size.height);
//            }
//                break;
//            case OURAnimationPropertyViewAlpha: {
//                _fromValue = @(self.view.alpha);
//            }
//                break;
//            case OURAnimationPropertyViewTransform: {
//                _fromValue = [NSValue valueWithCGAffineTransform:self.view.transform];
//            }
//                break;
//            default:
//                break;
//        }
//    }
//    return _fromValue;
//}
//
//- (void)setFromValue:(id)fromValue {
//    if (!self.fromValues) {
//        self.fromValues = [[NSMutableArray alloc] init];
//    }
//    [self.fromValues addObject:fromValue];
//    _fromValue = fromValue;
//}
//
//- (void)setToValue:(id)toValue {
//    if (!self.toValues) {
//        self.toValues = [[NSMutableArray alloc] init];
//    }
//    [self.toValues addObject:toValue];
//    _toValue = toValue;
//}

@end
