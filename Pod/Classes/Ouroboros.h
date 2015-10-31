
//  Ouroboros.h
//  Ouroboros
//
//  Created by Draveness on 15/10/23.
//  Copyright © 2015年 Draveness. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+Ouroboros.h"
#import "UIScrollView+Ouroboros.h"

NS_ASSUME_NONNULL_BEGIN

NSValue *NSValueFromCGRectParameters(CGFloat x, CGFloat y, CGFloat width, CGFloat height);
NSValue *NSValueFromCGPointParameters(CGFloat x, CGFloat y);
NSValue *NSValueFromCGSizeParameters(CGFloat width, CGFloat height);

@interface Ouroboros : NSObject

@property (nonatomic, weak, readonly) UIView *view;
@property (nonatomic, assign, readonly) OURAnimationProperty property;
@property (nonatomic, strong) id fromValue;
@property (nonatomic, strong) id toValue;
@property (nonatomic, assign) CGFloat trggier;
@property (nonatomic, assign) CGFloat offset;

- (instancetype)initWithView:(UIView *)view;

typedef void(^OuroborosAnimationBlock)(Ouroboros *ouroboros);

- (void)animateWithProperty:(OURAnimationProperty)property
             configureBlock:(OuroborosAnimationBlock)configureBlock;
- (void)pinWithConfigureBlock:(OuroborosAnimationBlock)configureBlock;


- (id)calculateInternalValueWithPercent:(CGFloat)percent;

@end

NS_ASSUME_NONNULL_END
