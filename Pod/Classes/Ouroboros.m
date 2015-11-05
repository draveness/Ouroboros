//
//  Ouroboros.m
//  Ouroboros
//
//  Created by Draveness on 15/10/23.
//  Copyright © 2015年 Draveness. All rights reserved.
//

#import "Ouroboros.h"
#import "MagicalScale.h"

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

CGRect CGRectFromCenterAndSize(CGPoint center, CGSize size) {
    return CGRectMake(center.x - size.width / 2.0, center.y - size.height / 2.0, size.width, size.height);
}

CGCenter CGCenterFromCGRect(CGRect rect) {
    return CGPointMake(rect.origin.x + rect.size.width / 2.0, rect.origin.y + rect.size.height / 2.0);
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

- (id)currentValueWithPosition:(CGFloat)position {
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
    return [[NSObject alloc] init];
}

- (id)toValueWithMagicalScale:(MagicalScale *)scale position:(CGFloat)position {
    CGRect toRect = [[self currentValueWithPosition:position] CGRectValue];
    CGFloat percent = [scale percentWithPosition:position];
    id value = [scale calculateInternalValueWithPercent:percent];
    CGRect magicalScaleRect = [value CGRectValue];
    switch (scale.tag) {
        case OURFrameAnimationTagX: {
            toRect.origin.x = magicalScaleRect.origin.x;
        }
            break;
        case OURFrameAnimationTagY: {
            toRect.origin.y = magicalScaleRect.origin.y;
        }
            break;
        case OURFrameAnimationTagWidth: {
            toRect.size.width = magicalScaleRect.size.width;
        }
            break;
        case OURFrameAnimationTagHeight: {
            toRect.origin.y = magicalScaleRect.size.height;
        }
            break;
        case OURFrameAnimationTagSize: {
            toRect.size = magicalScaleRect.size;
        }
            break;
        case OURFrameAnimationTagOrigin: {
            toRect.origin = magicalScaleRect.origin;
        }
            break;
        case OURFrameAnimationTagFrame: {
            toRect = magicalScaleRect;
        }
            break;
        default:
            break;
    }
    return [NSValue valueWithCGRect:toRect];
}

#pragma mark - Getter/Setter

- (void)insertObject:(Scale *)currentScale inScalesAtIndex:(NSUInteger)index {
    Scale *previousScale = nil;
    Scale *afterScale = nil;

    if ([self isChangingFrame]) {
        NSMutableSet *scalesToAdd = [[NSMutableSet alloc] init];
        NSMutableSet *scalesToDelete = [[NSMutableSet alloc] init];
        MagicalScale *magicalCurrentScale = (MagicalScale *)currentScale;
        [scalesToAdd addObject:currentScale];

        for (MagicalScale *scale in self.scales) {
            if ([scale isSeparateWithScale:currentScale]) {
                if (scale.trigger >= currentScale.stop && (!afterScale || afterScale.trigger >= scale.stop)) {
                    afterScale = scale;
                } else if (scale.stop <= currentScale.trigger && (!previousScale || previousScale.stop <= scale.trigger)) {
                    previousScale = scale;
                }
            } else if ([scale isCoverUpScale:currentScale]) {
                /**
                 *  In this condition, the original scale will devided into three / two / one part
                 *
                 *  --- 1st original scale (option) ---+++ 2nd original scale + current scale +++--- 3rd original scale (option) ---
                 */
                if (scale.tag & magicalCurrentScale.tag) NSAssert(NO, @"Can not added a magical scales with overlapping tag to the same ouroboros.");
                MagicalScale *firstScale = [[MagicalScale alloc] init];
                firstScale.tag = scale.tag;
                firstScale.fromValue = scale.fromValue;
                firstScale.toValue = [self currentValueWithPosition:magicalCurrentScale.trigger];
                firstScale.trigger = scale.trigger;
                firstScale.offset = magicalCurrentScale.trigger - firstScale.trigger;
                firstScale.function = scale.function;

                MagicalScale *secondScale = [[MagicalScale alloc] init];
                secondScale.tag = scale.tag | magicalCurrentScale.tag;
                secondScale.fromValue = firstScale.toValue;
                secondScale.toValue = [self toValueWithMagicalScale:magicalCurrentScale position:scale.stop];
                secondScale.trigger = magicalCurrentScale.trigger;
                secondScale.offset = magicalCurrentScale.offset;
                secondScale.function = magicalCurrentScale.function;

                MagicalScale *thirdScale = [[MagicalScale alloc] init];
                thirdScale.tag = scale.tag;
                thirdScale.fromValue = secondScale.toValue;
                thirdScale.toValue = scale.toValue;
                thirdScale.trigger = magicalCurrentScale.stop;
                thirdScale.offset = scale.stop - secondScale.stop;
                thirdScale.function = scale.function;

                if (firstScale.offset > 0) [scalesToAdd addObject:firstScale];
                [scalesToAdd addObject:secondScale];
                if (thirdScale.offset > 0) [scalesToAdd addObject:thirdScale];
                [scalesToDelete addObject:scale];
                [scalesToAdd removeObject:currentScale];
            } else if ([scale isContainInScale:currentScale]) {
                /**
                 *  In this condition, the original is covered by current scale
                 *
                 *  --- 1st current scale (option) ----++++ 2nd original scale + current scale ++++---- 3rd current scale(option) ---
                 */
                if (scale.tag & magicalCurrentScale.tag) NSAssert(NO, @"Can not added a magical scales with overlapping tag to the same ouroboros.");
                MagicalScale *firstScale = [[MagicalScale alloc] init];
                firstScale.tag = magicalCurrentScale.tag;
                firstScale.fromValue = magicalCurrentScale.fromValue;
                firstScale.toValue = [self toValueWithMagicalScale:magicalCurrentScale position:scale.trigger];
                firstScale.trigger = magicalCurrentScale.trigger;
                firstScale.offset = scale.trigger - magicalCurrentScale.trigger;
                firstScale.function = magicalCurrentScale.function;

                MagicalScale *secondScale = [[MagicalScale alloc] init];
                secondScale.tag = scale.tag | magicalCurrentScale.tag;
                secondScale.fromValue = firstScale.toValue;
                secondScale.toValue = [self toValueWithMagicalScale:magicalCurrentScale position:scale.stop];
                secondScale.trigger = scale.trigger;
                secondScale.offset = scale.offset;
                secondScale.function = magicalCurrentScale.function;

                MagicalScale *thirdScale = [[MagicalScale alloc] init];
                thirdScale.tag = magicalCurrentScale.tag;
                thirdScale.fromValue = secondScale.toValue;
                thirdScale.toValue = magicalCurrentScale.toValue;
                thirdScale.trigger = scale.stop;
                thirdScale.offset = magicalCurrentScale.stop - secondScale.stop;
                thirdScale.function = magicalCurrentScale.function;

                if (firstScale.offset > 0) [scalesToAdd addObject:firstScale];
                [scalesToAdd addObject:secondScale];
                if (thirdScale.offset > 0) [scalesToAdd addObject:thirdScale];
                [scalesToDelete addObject:scale];
                [scalesToAdd removeObject:currentScale];
            } else  {
                /**
                 *  In this condition, the original scale will devided into three / two part
                 *
                 *  --- 1st original scale (option) ----++++ 2nd original scale + current scale ++++---- 3rd current scale ---
                 */
                if (scale.tag & magicalCurrentScale.tag) NSAssert(NO, @"Can not added a magical scales with overlapping tag to the same ouroboros.");
                MagicalScale *firstScale = [[MagicalScale alloc] init];
                firstScale.tag = scale.tag;
                firstScale.fromValue = scale.fromValue;
                firstScale.toValue = [self currentValueWithPosition:magicalCurrentScale.trigger];
                firstScale.trigger = scale.trigger;
                firstScale.offset = magicalCurrentScale.trigger - firstScale.trigger;
                firstScale.function = scale.function;

                MagicalScale *secondScale = [[MagicalScale alloc] init];
                secondScale.tag = scale.tag | magicalCurrentScale.tag;
                secondScale.fromValue = firstScale.toValue;
                secondScale.toValue = [self toValueWithMagicalScale:magicalCurrentScale position:magicalCurrentScale.stop];
                secondScale.trigger = magicalCurrentScale.trigger;
                secondScale.offset = scale.stop - firstScale.stop;
                secondScale.function = magicalCurrentScale.function;

                MagicalScale *thirdScale = [[MagicalScale alloc] init];
                thirdScale.tag = magicalCurrentScale.tag;
                thirdScale.fromValue = secondScale.toValue;
                thirdScale.toValue = magicalCurrentScale.toValue;
                thirdScale.trigger = scale.stop;
                thirdScale.offset = magicalCurrentScale.stop - secondScale.stop;
                thirdScale.function = magicalCurrentScale.function;

                if (firstScale.offset > 0) [scalesToAdd addObject:firstScale];
                [scalesToAdd addObject:secondScale];
                [scalesToDelete addObject:scale];
                [scalesToAdd removeObject:currentScale];
            }
        }

        for (Scale *scale in scalesToAdd) {
            [self.scales insertObject:scale atIndex:[self.scales count]];
        }
        for (Scale *scale in scalesToDelete) {
            [self.scales removeObject:scale];
        }

        if (previousScale) {
            currentScale.fromValue = previousScale.toValue;
        } else {
            currentScale.fromValue = self.startValue;
        }
        if (afterScale) {
            afterScale.fromValue = currentScale.toValue;
        }
    } else {
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
            case OURAnimationPropertyViewPosition:
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

- (BOOL)isChangingFrame {
    switch (self.property) {
        case OURAnimationPropertyViewFrame:
        case OURAnimationPropertyViewBounds:
        case OURAnimationPropertyViewSize:
        case OURAnimationPropertyViewPosition:
        case OURAnimationPropertyViewCenter:
        case OURAnimationPropertyViewCenterX:
        case OURAnimationPropertyViewCenterY:
        case OURAnimationPropertyViewOrigin:
        case OURAnimationPropertyViewOriginX:
        case OURAnimationPropertyViewOriginY:
        case OURAnimationPropertyViewWidth:
        case OURAnimationPropertyViewHeight:
            return YES;
        default:
            return NO;
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
    NSAssert(NO, @"Can not find a UIScrollView on current view inheritance hierarchy");
    return nil;
}

@end
