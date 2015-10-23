//
//  Ouroboros.m
//  Ouroboros
//
//  Created by Draveness on 15/10/23.
//  Copyright © 2015年 Draveness. All rights reserved.
//

#import "Ouroboros.h"

@implementation Ouroboros

- (instancetype)initWithAnimationType:(OuroborosAnmationType)animationType {
    if (self = [super init]) {
        _animationType = animationType;
    }
    return self;
}

- (NSValue *)calculateInternalValueWithPercent:(CGFloat)percent {
    percent= [self justifyPercent:percent];

    NSValue *result = [[NSValue alloc] init];
    switch (self.animationType) {
        case OuroborosAnimationTypeViewFrame: {
            CGRect fromValue = [self.fromValue CGRectValue];
            CGRect toValue = [self.toValue CGRectValue];

            CGRect resultValue =
            CGRectMake(fromValue.origin.x + (toValue.origin.x - fromValue.origin.x) * percent,
                       fromValue.origin.y + (toValue.origin.y - fromValue.origin.y) * percent,
                       fromValue.size.width + (toValue.size.width - fromValue.size.width) * percent,
                       fromValue.size.height + (toValue.size.height - fromValue.size.height) * percent
                       );
            result = [NSValue valueWithCGRect:resultValue];
        }
            break;

        default:
            break;
    }
    return result;
}

- (CGFloat)justifyPercent:(CGFloat)percent {
    if (percent < 0) {
        return 0;
    } else if (percent > 1) {
        return 1;
    } else {
        return percent;
    }
}

@end
