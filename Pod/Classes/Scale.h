//
//  Scale.h
//  Pods
//
//  Created by Draveness on 15/11/1.
//
//

#import <UIKit/UIKit.h>
#import "UIView+Ouroboros.h"

typedef NS_ENUM(NSUInteger, OURAnimationFunction) {
    OURAnimationFunctionLinear,
    OURAnimationFunctionEaseInQuad,
    OURAnimationFunctionEaseOutQuad,
    OURAnimationFunctionEaseInOutQuad,
    OURAnimationFunctionEaseInCubic,
    OURAnimationFunctionEaseOutCubic,
    OURAnimationFunctionEaseInOutCubic,
    OURAnimationFunctionEaseInQuart,
    OURAnimationFunctionEaseOutQuart,
    OURAnimationFunctionEaseInOutQuart,
    OURAnimationFunctionEaseInQuint,
    OURAnimationFunctionEaseOutQuint,
    OURAnimationFunctionEaseInOutQuint,
    OURAnimationFunctionEaseInSine,
    OURAnimationFunctionEaseOutSine,
    OURAnimationFunctionEaseInOutSine,
    OURAnimationFunctionEaseInExpo,
    OURAnimationFunctionEaseOutExpo,
    OURAnimationFunctionEaseInOutExpo,
    OURAnimationFunctionEaseInCirc,
    OURAnimationFunctionEaseOutCirc,
    OURAnimationFunctionEaseInOutCirc,
    OURAnimationFunctionEaseInElastic,
    OURAnimationFunctionEaseOutElastic,
    OURAnimationFunctionEaseInOutElastic,
    OURAnimationFunctionEaseInBack,
    OURAnimationFunctionEaseOutBack,
    OURAnimationFunctionEaseInOutBack,
    OURAnimationFunctionEaseInBounce,
    OURAnimationFunctionEaseOutBounce,
    OURAnimationFunctionEaseInOutBounce,
};

NS_ASSUME_NONNULL_BEGIN

@interface Scale : NSObject

@property (nonatomic, strong) id fromValue;
@property (nonatomic, strong) id toValue;
@property (nonatomic, assign) CGFloat trigger;
@property (nonatomic, assign) CGFloat offset;
@property (nonatomic, assign, readonly) CGFloat stop;
@property (nonatomic, assign) OURAnimationFunction function;

- (id)calculateInternalValueWithPercent:(CGFloat)percent;

- (BOOL)isCurrentPositionOnScale:(CGFloat)currentPostion;
- (BOOL)isSeparateWithScale:(Scale *)scale;

@end

NS_ASSUME_NONNULL_END