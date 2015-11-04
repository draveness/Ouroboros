//
//  UIView+Ouroboros.m
//  Ouroboros
//
//  Created by Draveness on 15/10/5.
//  Copyright © 2015年 Draveness. All rights reserved.
//

#import "UIView+Ouroboros.h"
#import "UIScrollView+Ouroboros.h"
#import "Ouroboros.h"
#import <objc/runtime.h>

@interface UIView ()

@property (nonatomic, strong) NSMutableArray<Ouroboros *> *ouroboroses;

@end

@implementation UIView (Ouroboros)

- (void)our_animateWithProperty:(OURAnimationProperty)property
                 configureBlock:(ScaleAnimationBlock)configureBlock {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateState:) name:@"ScrollView" object:nil];
    if ([self isChangingFrame:property]) {
        Ouroboros *ouroboros = [self ouroborosWithProperty:OURAnimationPropertyViewFrame];

        MagicalScale *scale = [[MagicalScale alloc] init];
        configureBlock(scale);
        CGRect toRect = self.frame;
        switch (property) {
            case OURAnimationPropertyViewFrame:
            case OURAnimationPropertyViewBounds:
                scale.tag = OURFrameAnimationTagFrame;
                break;
            case OURAnimationPropertyViewSize: {
                toRect.size = [scale.toValue CGSizeValue];
                scale.tag = OURFrameAnimationTagSize;
            }
                break;
            case OURAnimationPropertyViewCenter: {
                toRect.size = [scale.toValue CGSizeValue];
                scale.tag = OURFrameAnimationTagOrigin;
            }
                break;
            case OURAnimationPropertyViewCenterX: {
                scale.tag = OURFrameAnimationTagX;
            }
                break;
            case OURAnimationPropertyViewCenterY: {
                scale.tag = OURFrameAnimationTagY;
            }
                break;
            case OURAnimationPropertyViewOrigin: {
                toRect.origin = [scale.toValue CGPointValue];
                scale.tag = OURFrameAnimationTagOrigin;
            }
                break;
            case OURAnimationPropertyViewOriginX: {
                toRect.origin.x = [scale.toValue doubleValue];
                scale.tag = OURFrameAnimationTagX;
            }
                break;
            case OURAnimationPropertyViewOriginY: {
                toRect.origin.y = [scale.toValue doubleValue];
                scale.tag = OURFrameAnimationTagY;
            }
                break;
            case OURAnimationPropertyViewWidth: {
                toRect.size.width = [scale.toValue doubleValue];
                scale.tag = OURFrameAnimationTagWidth;
            }
                break;
            case OURAnimationPropertyViewHeight: {
                toRect.size.height = [scale.toValue doubleValue];
                scale.tag = OURFrameAnimationTagHeight;
            }
                break;
            default:
                break;
        }
        scale.toValue = [NSValue valueWithCGRect:toRect];
        NSMutableArray<Scale *> *scales = [ouroboros mutableArrayValueForKey:@"scales"];
        [scales addObject:scale];
    } else {
        Ouroboros *ouroboros = [self ouroborosWithProperty:property];

        Scale *scale = [[Scale alloc] init];
        configureBlock(scale);

        NSMutableArray<Scale *> *scales = [ouroboros mutableArrayValueForKey:@"scales"];
        [scales addObject:scale];
    }
}

- (void)our_pinWithConfigureBlock:(ScaleAnimationBlock)configureBlock {
    OURAnimationProperty property = [[self closestScrollView] ou_scrollDirection] ? OURAnimationPropertyViewOriginX : OURAnimationPropertyViewOriginY;
    [self our_animateWithProperty:property configureBlock:^(Scale * _Nonnull scale) {
        scale.trigger = 0;
        scale.offset = INT_MAX;
        scale.fromValue = (property == OURAnimationPropertyViewOriginX) ? @(self.center.x) : @(self.center.y);
        if (configureBlock) configureBlock(scale);
        scale.toValue = @([scale.fromValue floatValue] + scale.offset);
    }];
}

- (Ouroboros *)ouroborosWithProperty:(OURAnimationProperty)property {
    for (Ouroboros *ouroboros in self.ouroboroses) {
        if (ouroboros.property == property) {
            return ouroboros;
        }
    }
    Ouroboros *ouroboros = [[Ouroboros alloc] initWithView:self property:property];
    [self.ouroboroses addObject:ouroboros];
    return ouroboros;
}

- (UIScrollView *)closestScrollView {
    UIView *superview = self.superview;
    while (superview) {
        if ([superview isKindOfClass:[UIScrollView class]]) {
            return (UIScrollView *)superview;
        }
        superview = superview.superview;
    }
    NSAssert(NO, @"Cannot find a UIScrollView on current view inheritance hierarchy");
    return nil;
}

- (void)updateState:(NSNotification *)notification {
    CGPoint contentOffset = [[notification userInfo][@"contentOffset"] CGPointValue];
    OURScrollDirection direction = [[notification userInfo][@"direction"] integerValue];
    for (Ouroboros *ouroboros in self.ouroboroses) {
        CGFloat currentPosition = 0;
        if (direction == OURScrollDirectionHorizontal) {
            currentPosition = contentOffset.x;
        } else {
            currentPosition = contentOffset.y;
        }

        id value = [ouroboros currentValueWithPosition:currentPosition];
        OURAnimationProperty property = ouroboros.property;

        switch (property) {
            case OURAnimationPropertyViewBackgroundColor: {
                self.backgroundColor = value;
            }
                break;
            case OURAnimationPropertyViewOrigin:
            case OURAnimationPropertyViewOriginX:
            case OURAnimationPropertyViewOriginY:
            case OURAnimationPropertyViewWidth:
            case OURAnimationPropertyViewHeight:
            case OURAnimationPropertyViewBounds:
            case OURAnimationPropertyViewSize:
            case OURAnimationPropertyViewFrame: {
                self.frame = [value CGRectValue];
            }
                break;
            case OURAnimationPropertyViewPosition:
            case OURAnimationPropertyViewCenter:
            case OURAnimationPropertyViewCenterX: {
                self.center = CGPointMake([value floatValue], self.center.y);
            }
                break;
            case OURAnimationPropertyViewCenterY: {
                self.center = CGPointMake(self.center.x, [value floatValue]);
            }
                break;
            case OURAnimationPropertyViewTintColor: {
                self.tintColor = value;
            }
                break;
            case OURAnimationPropertyViewAlpha: {
                self.alpha = [value floatValue];
            }
                break;
            case OURAnimationPropertyViewTransform: {
                self.transform = [value CGAffineTransformValue];
            }
                break;
            default:
                break;
        }
    }
}

#pragma mark - Getter/Setter

- (NSMutableArray *)ouroboroses {
    if (!objc_getAssociatedObject(self, @selector(ouroboroses))) {
        objc_setAssociatedObject(self, @selector(ouroboroses), [[NSMutableArray alloc] init], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return objc_getAssociatedObject(self, @selector(ouroboroses));
}

- (void)setOuroboroses:(NSMutableArray *)ouroboroses {
    objc_setAssociatedObject(self, @selector(ouroboroses), ouroboroses, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)isChangingFrame:(OURAnimationProperty)property {
    switch (property) {
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
        case OURAnimationPropertyViewHeight:
            return YES;
        default:
            return NO;
    }
}

@end
