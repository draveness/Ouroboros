//
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

@interface Ouroboros : NSObject

@property (nonatomic, assign, readonly) OURAnimationProperty property;
@property (nonatomic, strong) id fromValue;
@property (nonatomic, strong) id toValue;
@property (nonatomic, assign) CGFloat trggier;
@property (nonatomic, assign) CGFloat duration;

- (instancetype)initWithProperty:(OURAnimationProperty)property;

- (id)calculateInternalValueWithPercent:(CGFloat)percent;

- (void)setupFromValueWithView:(UIView *)view;

@end

NS_ASSUME_NONNULL_END
