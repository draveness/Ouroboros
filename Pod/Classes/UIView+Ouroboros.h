//
//  UIView+Ouroboros.h
//  Ouroboros
//
//  Created by Draveness on 15/10/5.
//  Copyright © 2015年 Draveness. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Ouroboros;
@class Scale;

typedef NS_ENUM(NSUInteger, OURAnimationProperty) {
    OURAnimationPropertyViewFrame,
    OURAnimationPropertyViewBounds,
    OURAnimationPropertyViewSize,
    OURAnimationPropertyViewCenter,
    OURAnimationPropertyViewPosition,
    OURAnimationPropertyViewCenterX,
    OURAnimationPropertyViewCenterY,
    OURAnimationPropertyViewOrigin,
    OURAnimationPropertyViewOriginX,
    OURAnimationPropertyViewOriginY,
    OURAnimationPropertyViewWidth,
    OURAnimationPropertyViewHeight,
    OURAnimationPropertyViewBackgroundColor,
    OURAnimationPropertyViewTintColor,
    OURAnimationPropertyViewAlpha,
    OURAnimationPropertyViewTransform,
};

NS_ASSUME_NONNULL_BEGIN

typedef void(^ScaleAnimationBlock)(Scale *scale);

@interface UIView (Ouroboros)

- (void)our_animateWithProperty:(OURAnimationProperty)property
                 configureBlock:(ScaleAnimationBlock)configureBlock;

- (void)our_pinWithConfigureBlock:(ScaleAnimationBlock)configureBlock;

- (void)updateState:(NSNotification *)notification;

@end

NS_ASSUME_NONNULL_END