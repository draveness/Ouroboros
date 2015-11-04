
//  Ouroboros.h
//  Ouroboros
//
//  Created by Draveness on 15/10/23.
//  Copyright © 2015年 Draveness. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Scale.h"
#import "UIView+Measure.h"
#import "UIScrollView+Ouroboros.h"
#import "UIView+Ouroboros.h"

NS_ASSUME_NONNULL_BEGIN

NSValue *NSValueFromCGRectParameters(CGFloat x, CGFloat y, CGFloat width, CGFloat height);
NSValue *NSValueFromCGPointParameters(CGFloat x, CGFloat y);
NSValue *NSValueFromCGSizeParameters(CGFloat width, CGFloat height);

@interface Ouroboros : NSObject

@property (nonatomic, weak, readonly) UIView *view;
@property (nonatomic, assign, readonly) OURAnimationProperty property;
@property (nonatomic, strong, readonly) NSMutableArray<Scale *> *scales;

- (instancetype)initWithView:(UIView *)view property:(OURAnimationProperty)property;

- (id)currentValueWithPosition:(CGFloat)position;

@end

NS_ASSUME_NONNULL_END
