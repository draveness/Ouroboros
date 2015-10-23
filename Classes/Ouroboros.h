//
//  Ouroboros.h
//  Ouroboros
//
//  Created by Draveness on 15/10/23.
//  Copyright © 2015年 Draveness. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger) {
    OuroborosAnimationTypeViewFrame,
} OuroborosAnmationType;

NS_ASSUME_NONNULL_BEGIN

@interface Ouroboros : NSObject

@property (nonatomic, assign, readonly) OuroborosAnmationType animationType;
@property (nonatomic, strong) NSValue *fromValue;
@property (nonatomic, strong) NSValue *toValue;
@property (nonatomic, assign) CGFloat trggier;
@property (nonatomic, assign) CGFloat duration;

- (instancetype)initWithAnimationType:(OuroborosAnmationType)animationType;

- (NSValue *)calculateInternalValueWithPercent:(CGFloat)percent;

@end

NS_ASSUME_NONNULL_END