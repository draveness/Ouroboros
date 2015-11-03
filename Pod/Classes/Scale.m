//
//  Scale.m
//  Pods
//
//  Created by Draveness on 15/11/1.
//
//

#import "Scale.h"
#import "NSBKeyframeAnimationFunctions.h"

typedef double(^NSBKeyframeAnimationFunctionBlock)(double t, double b, double c, double d);

@interface Scale ()

@property (nonatomic, copy) NSBKeyframeAnimationFunctionBlock functionBlock;

@end

@implementation Scale

- (instancetype)init {
    if (self = [super init]) {
        _function = OURAnimationFunctionLinear;
        _functionBlock =  ^double(double t, double b, double c, double d) {
            return NSBKeyframeAnimationFunctionEaseInCubic(t, b, c, d);
        };
    }
    return self;
}

- (id)calculateInternalValueWithPercent:(CGFloat)percent {
    percent = [self justifyPercent:percent];
    percent = self.functionBlock(self.offset * percent * 1000, 0, 1, self.offset * 1000);
    NSLog(@"%@", @(percent));

    id result = [[NSValue alloc] init];
    if ([self.fromValue isKindOfClass:[NSNumber class]]) {
        CGFloat fromValue = [self.fromValue floatValue];
        CGFloat toValue = [self.toValue floatValue];

        CGFloat resultValue = fromValue + (toValue - fromValue) * percent;
        result = @(resultValue);
    } else if ([self.fromValue isKindOfClass:[UIColor class]]) {
        UIColor *fromValue = self.fromValue;
        UIColor *toValue = self.toValue;

        const CGFloat *fromComponents = CGColorGetComponents(fromValue.CGColor);
        const CGFloat *toComponents = CGColorGetComponents(toValue.CGColor);

        CGFloat redComponent = fromComponents[0] + (toComponents[0] - fromComponents[0]) * percent;
        CGFloat greenComponent = fromComponents[1] + (toComponents[1] - fromComponents[1]) * percent;
        CGFloat blueComponent = fromComponents[2] + (toComponents[2] - fromComponents[2]) * percent;
        CGFloat alphaComponent = fromComponents[3] + (toComponents[3] - fromComponents[3]) * percent;

        result = [UIColor colorWithRed:redComponent green:greenComponent blue:blueComponent alpha:alphaComponent];
    } else if ([self.fromValue isKindOfClass:[NSValue class]]) {
        NSString *valueType = [NSString stringWithCString:[self.fromValue objCType] encoding:NSStringEncodingConversionAllowLossy];
        if ([valueType containsString:@"CGRect"]) {
            CGRect fromValue = [self.fromValue CGRectValue];
            CGRect toValue = [self.toValue CGRectValue];

            CGRect resultValue =
            CGRectMake(
                       fromValue.origin.x + (toValue.origin.x - fromValue.origin.x) * percent,
                       fromValue.origin.y + (toValue.origin.y - fromValue.origin.y) * percent,
                       fromValue.size.width + (toValue.size.width - fromValue.size.width) * percent,
                       fromValue.size.height + (toValue.size.height - fromValue.size.height) * percent
                       );
            result = [NSValue valueWithCGRect:resultValue];
        } else if ([valueType containsString:@"CGSize"]) {
            CGSize fromValue = [self.fromValue CGSizeValue];
            CGSize toValue = [self.toValue CGSizeValue];

            CGSize resultValue =
            CGSizeMake(
                       fromValue.width + (toValue.width - fromValue.width) * percent,
                       fromValue.height + (toValue.height - fromValue.height) * percent
                       );
            result = [NSValue valueWithCGSize:resultValue];
        } else if ([valueType containsString:@"CGPoint"]) {
            CGPoint fromValue = [self.fromValue CGPointValue];
            CGPoint toValue = [self.toValue CGPointValue];

            CGPoint resultValue =
            CGPointMake(
                        fromValue.x + (toValue.x - fromValue.x) * percent,
                        fromValue.y + (toValue.y - fromValue.y) * percent
                        );
            result = [NSValue valueWithCGPoint:resultValue];
        } else if ([valueType containsString:@"CATransform3D"]) {
            CATransform3D fromTransform = [self.fromValue CATransform3DValue];
            CATransform3D toTransform = [self.toValue CATransform3DValue];

            CATransform3D resultValue = CATransform3DIdentity;
            CGFloat m11 = fromTransform.m11 + (toTransform.m11 - fromTransform.m11) * percent;
            CGFloat m12 = fromTransform.m12 + (toTransform.m12 - fromTransform.m12) * percent;
            CGFloat m13 = fromTransform.m13 + (toTransform.m13 - fromTransform.m13) * percent;
            CGFloat m14 = fromTransform.m14 + (toTransform.m14 - fromTransform.m14) * percent;
            CGFloat m21 = fromTransform.m21 + (toTransform.m21 - fromTransform.m21) * percent;
            CGFloat m22 = fromTransform.m22 + (toTransform.m22 - fromTransform.m22) * percent;
            CGFloat m23 = fromTransform.m23 + (toTransform.m23 - fromTransform.m23) * percent;
            CGFloat m24 = fromTransform.m24 + (toTransform.m24 - fromTransform.m24) * percent;
            CGFloat m31 = fromTransform.m31 + (toTransform.m31 - fromTransform.m31) * percent;
            CGFloat m32 = fromTransform.m32 + (toTransform.m32 - fromTransform.m32) * percent;
            CGFloat m33 = fromTransform.m33 + (toTransform.m33 - fromTransform.m33) * percent;
            CGFloat m34 = fromTransform.m34 + (toTransform.m34 - fromTransform.m34) * percent;
            CGFloat m41 = fromTransform.m41 + (toTransform.m41 - fromTransform.m41) * percent;
            CGFloat m42 = fromTransform.m42 + (toTransform.m42 - fromTransform.m42) * percent;
            CGFloat m43 = fromTransform.m43 + (toTransform.m43 - fromTransform.m43) * percent;
            CGFloat m44 = fromTransform.m44 + (toTransform.m44 - fromTransform.m44) * percent;

            resultValue.m11 = m11;
            resultValue.m12 = m12;
            resultValue.m13 = m13;
            resultValue.m14 = m14;
            resultValue.m21 = m21;
            resultValue.m22 = m22;
            resultValue.m23 = m23;
            resultValue.m24 = m24;
            resultValue.m31 = m31;
            resultValue.m32 = m32;
            resultValue.m33 = m33;
            resultValue.m34 = m34;
            resultValue.m41 = m41;
            resultValue.m42 = m42;
            resultValue.m43 = m43;
            resultValue.m44 = m44;

            result = [NSValue valueWithCATransform3D:resultValue];
        }
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

- (CGFloat)stop {
    return self.trggier + self.offset;
}

- (BOOL)isCurrentPositionOnScale:(CGFloat)currentPostion {
    return currentPostion >= self.trggier && currentPostion <= self.stop;
}

- (BOOL)isSeparateWithScale:(Scale *)scale {
    return scale.stop <= self.trggier || scale.trggier >= self.stop;
}

@end
