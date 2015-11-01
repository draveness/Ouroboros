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



typedef enum : NSUInteger {
    OURAnimationPropertyViewFrame,
    OURAnimationPropertyViewBounds,
    OURAnimationPropertyViewSize,
    OURAnimationPropertyViewCenter,
    OURAnimationPropertyViewPosition,
    OURAnimationPropertyViewOrigin,
    OURAnimationPropertyViewOriginX,
    OURAnimationPropertyViewOriginY,
    OURAnimationPropertyViewWidth,
    OURAnimationPropertyViewHeight,
    OURAnimationPropertyViewCenterX,
    OURAnimationPropertyViewCenterY,
    OURAnimationPropertyViewBackgroundColor,
    OURAnimationPropertyViewTintColor,
    OURAnimationPropertyViewAlpha,
    OURAnimationPropertyViewTransform,
} OURAnimationProperty;

NS_ASSUME_NONNULL_BEGIN

typedef void(^ScaleAnimationBlock)(Scale *scale);

//typedef void(^OuroborosAnimationBlock)(Ouroboros *ouroboros);

@interface UIView (Ouroboros)

- (void)our_animateWithProperty:(OURAnimationProperty)property
                 configureBlock:(ScaleAnimationBlock)configureBlock;

- (void)our_pinWithConfigureBlock:(ScaleAnimationBlock)configureBlock;

@property (nonatomic, strong) NSMutableArray *ouroboroses;

- (void)updateState:(NSNotification *)notification;

@end

NS_ASSUME_NONNULL_END