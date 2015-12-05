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
            return NSBKeyframeAnimationFunctionLinear(t, b, c, d);
        };
    }
    return self;
}

- (id)calculateInternalValueWithPercent:(CGFloat)percent {
    percent = [self justifyPercent:percent];
    
    CGFloat value = self.functionBlock(self.offset * percent * 1000, 0, 1, self.offset * 1000);

    id result = [[NSValue alloc] init];
    if ([self.fromValue isKindOfClass:[NSNumber class]]) {
        CGFloat fromValue = [self.fromValue floatValue];
        CGFloat toValue = [self.toValue floatValue];

        CGFloat resultValue = fromValue + (toValue - fromValue) * value;
        result = @(resultValue);
    } else if ([self.fromValue isKindOfClass:[UIColor class]]) {
        UIColor *fromValue = self.fromValue;
        UIColor *toValue = self.toValue;

        const CGFloat *fromComponents = CGColorGetComponents(fromValue.CGColor);
        const CGFloat *toComponents = CGColorGetComponents(toValue.CGColor);
        if (CGColorGetNumberOfComponents(fromValue.CGColor) == 2) {
            fromValue = [UIColor colorWithRed:fromComponents[0] green:fromComponents[0] blue:fromComponents[0] alpha:fromComponents[1]];
            fromComponents = CGColorGetComponents(fromValue.CGColor);
        }
        if (CGColorGetNumberOfComponents(toValue.CGColor) == 2) {
            toValue = [UIColor colorWithRed:toComponents[0] green:toComponents[0] blue:toComponents[0] alpha:toComponents[1]];
            toComponents = CGColorGetComponents(toValue.CGColor);
        }

        CGFloat redComponent = fromComponents[0] + (toComponents[0] - fromComponents[0]) * value;
        CGFloat greenComponent = fromComponents[1] + (toComponents[1] - fromComponents[1]) * value;
        CGFloat blueComponent = fromComponents[2] + (toComponents[2] - fromComponents[2]) * value;
        CGFloat alphaComponent = fromComponents[3] + (toComponents[3] - fromComponents[3]) * value;

        result = [UIColor colorWithRed:redComponent green:greenComponent blue:blueComponent alpha:alphaComponent];
    } else if ([self.fromValue isKindOfClass:[NSValue class]]) {
        NSString *valueType = [NSString stringWithCString:[self.fromValue objCType] encoding:NSStringEncodingConversionAllowLossy];
        if ([valueType containsString:@"CGRect"]) {
            CGRect fromValue = [self.fromValue CGRectValue];
            CGRect toValue = [self.toValue CGRectValue];

            CGRect resultValue =
            CGRectMake(
                       fromValue.origin.x + (toValue.origin.x - fromValue.origin.x) * value,
                       fromValue.origin.y + (toValue.origin.y - fromValue.origin.y) * value,
                       fromValue.size.width + (toValue.size.width - fromValue.size.width) * value,
                       fromValue.size.height + (toValue.size.height - fromValue.size.height) * value
                       );
            result = [NSValue valueWithCGRect:resultValue];
        } else if ([valueType containsString:@"CGSize"]) {
            CGSize fromValue = [self.fromValue CGSizeValue];
            CGSize toValue = [self.toValue CGSizeValue];

            CGSize resultValue =
            CGSizeMake(
                       fromValue.width + (toValue.width - fromValue.width) * value,
                       fromValue.height + (toValue.height - fromValue.height) * value
                       );
            result = [NSValue valueWithCGSize:resultValue];
        } else if ([valueType containsString:@"CGPoint"]) {
            CGPoint fromValue = [self.fromValue CGPointValue];
            CGPoint toValue = [self.toValue CGPointValue];

            CGPoint resultValue =
            CGPointMake(
                        fromValue.x + (toValue.x - fromValue.x) * value,
                        fromValue.y + (toValue.y - fromValue.y) * value
                        );
            result = [NSValue valueWithCGPoint:resultValue];
        } else if ([valueType containsString:@"CATransform3D"]) {
            CATransform3D fromTransform = [self.fromValue CATransform3DValue];
            CATransform3D toTransform = [self.toValue CATransform3DValue];

            CATransform3D resultValue = CATransform3DIdentity;
            CGFloat m11 = fromTransform.m11 + (toTransform.m11 - fromTransform.m11) * value;
            CGFloat m12 = fromTransform.m12 + (toTransform.m12 - fromTransform.m12) * value;
            CGFloat m13 = fromTransform.m13 + (toTransform.m13 - fromTransform.m13) * value;
            CGFloat m14 = fromTransform.m14 + (toTransform.m14 - fromTransform.m14) * value;
            CGFloat m21 = fromTransform.m21 + (toTransform.m21 - fromTransform.m21) * value;
            CGFloat m22 = fromTransform.m22 + (toTransform.m22 - fromTransform.m22) * value;
            CGFloat m23 = fromTransform.m23 + (toTransform.m23 - fromTransform.m23) * value;
            CGFloat m24 = fromTransform.m24 + (toTransform.m24 - fromTransform.m24) * value;
            CGFloat m31 = fromTransform.m31 + (toTransform.m31 - fromTransform.m31) * value;
            CGFloat m32 = fromTransform.m32 + (toTransform.m32 - fromTransform.m32) * value;
            CGFloat m33 = fromTransform.m33 + (toTransform.m33 - fromTransform.m33) * value;
            CGFloat m34 = fromTransform.m34 + (toTransform.m34 - fromTransform.m34) * value;
            CGFloat m41 = fromTransform.m41 + (toTransform.m41 - fromTransform.m41) * value;
            CGFloat m42 = fromTransform.m42 + (toTransform.m42 - fromTransform.m42) * value;
            CGFloat m43 = fromTransform.m43 + (toTransform.m43 - fromTransform.m43) * value;
            CGFloat m44 = fromTransform.m44 + (toTransform.m44 - fromTransform.m44) * value;

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
        } else if ([valueType containsString:@"CGAffineTransform"]) {
            CGAffineTransform fromTransform = [self.fromValue CGAffineTransformValue];
            CGAffineTransform toTransform = [self.toValue CGAffineTransformValue];

            CGFloat a = fromTransform.a + (toTransform.a - fromTransform.a) * percent;
            CGFloat b = fromTransform.b + (toTransform.b - fromTransform.b) * percent;
            CGFloat c = fromTransform.c + (toTransform.c - fromTransform.c) * percent;
            CGFloat d = fromTransform.d + (toTransform.d - fromTransform.d) * percent;
            CGFloat tx = fromTransform.tx + (toTransform.tx - fromTransform.tx) * percent;
            CGFloat ty = fromTransform.ty + (toTransform.ty - fromTransform.ty) * percent;

            CGAffineTransform resultValue = CGAffineTransformIdentity;

            resultValue.a = a;
            resultValue.b = b;
            resultValue.c = c;
            resultValue.d = d;
            resultValue.tx = tx;
            resultValue.ty = ty;

            result = [NSValue valueWithCGAffineTransform:resultValue];
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
    return self.trigger + self.offset;
}

- (BOOL)isCurrentPositionOnScale:(CGFloat)currentPostion {
    return currentPostion >= self.trigger && currentPostion <= self.stop;
}

- (BOOL)isSeparateWithScale:(Scale *)scale {
    return scale.stop <= self.trigger || scale.trigger >= self.stop;
}

#pragma mark - Getter/Setter

- (void)setFunction:(OURAnimationFunction)function {
    _function = function;
    switch (_function) {
        case OURAnimationFunctionLinear: {
            self.functionBlock = ^double(double t, double b, double c, double d) {
                return NSBKeyframeAnimationFunctionLinear(t, b, c, d);
            };
        }
            break;
        case OURAnimationFunctionEaseInQuad: {
            self.functionBlock = ^double(double t, double b, double c, double d) {
                return NSBKeyframeAnimationFunctionEaseInQuad(t, b, c, d);
            };
        }
            break;
        case OURAnimationFunctionEaseOutQuad: {
            self.functionBlock = ^double(double t, double b, double c, double d) {
                return NSBKeyframeAnimationFunctionEaseOutQuad(t, b, c, d);
            };
        }
            break;
        case OURAnimationFunctionEaseInOutQuad: {
            self.functionBlock = ^double(double t, double b, double c, double d) {
                return NSBKeyframeAnimationFunctionEaseInOutQuad(t, b, c, d);
            };
        }
            break;
        case OURAnimationFunctionEaseInCubic: {
            self.functionBlock = ^double(double t, double b, double c, double d) {
                return NSBKeyframeAnimationFunctionEaseInCubic(t, b, c, d);
            };
        }
            break;
        case OURAnimationFunctionEaseOutCubic: {
            self.functionBlock = ^double(double t, double b, double c, double d) {
                return NSBKeyframeAnimationFunctionEaseOutCubic(t, b, c, d);
            };
        }
            break;
        case OURAnimationFunctionEaseInOutCubic: {
            self.functionBlock = ^double(double t, double b, double c, double d) {
                return NSBKeyframeAnimationFunctionEaseInOutCubic(t, b, c, d);
            };
        }
            break;
        case OURAnimationFunctionEaseInQuart: {
            self.functionBlock = ^double(double t, double b, double c, double d) {
                return NSBKeyframeAnimationFunctionEaseInQuart(t, b, c, d);
            };
        }
            break;
        case OURAnimationFunctionEaseOutQuart: {
            self.functionBlock = ^double(double t, double b, double c, double d) {
                return NSBKeyframeAnimationFunctionEaseOutQuart(t, b, c, d);
            };
        }
            break;
        case OURAnimationFunctionEaseInOutQuart: {
            self.functionBlock = ^double(double t, double b, double c, double d) {
                return NSBKeyframeAnimationFunctionEaseInOutQuart(t, b, c, d);
            };
        }
            break;
        case OURAnimationFunctionEaseInQuint: {
            self.functionBlock = ^double(double t, double b, double c, double d) {
                return NSBKeyframeAnimationFunctionEaseInQuint(t, b, c, d);
            };
        }
            break;
        case OURAnimationFunctionEaseOutQuint: {
            self.functionBlock = ^double(double t, double b, double c, double d) {
                return NSBKeyframeAnimationFunctionEaseOutQuint(t, b, c, d);
            };
        }
            break;
        case OURAnimationFunctionEaseInOutQuint: {
            self.functionBlock = ^double(double t, double b, double c, double d) {
                return NSBKeyframeAnimationFunctionEaseInOutQuint(t, b, c, d);
            };
        }
            break;
        case OURAnimationFunctionEaseInSine: {
            self.functionBlock = ^double(double t, double b, double c, double d) {
                return NSBKeyframeAnimationFunctionEaseInSine(t, b, c, d);
            };
        }
            break;
        case OURAnimationFunctionEaseOutSine: {
            self.functionBlock = ^double(double t, double b, double c, double d) {
                return NSBKeyframeAnimationFunctionEaseOutSine(t, b, c, d);
            };
        }
            break;
        case OURAnimationFunctionEaseInOutSine: {
            self.functionBlock = ^double(double t, double b, double c, double d) {
                return NSBKeyframeAnimationFunctionEaseInOutSine(t, b, c, d);
            };
        }
            break;
        case OURAnimationFunctionEaseInExpo: {
            self.functionBlock = ^double(double t, double b, double c, double d) {
                return NSBKeyframeAnimationFunctionEaseInExpo(t, b, c, d);
            };
        }
            break;
        case OURAnimationFunctionEaseOutExpo: {
            self.functionBlock = ^double(double t, double b, double c, double d) {
                return NSBKeyframeAnimationFunctionEaseOutExpo(t, b, c, d);
            };
        }
            break;
        case OURAnimationFunctionEaseInOutExpo: {
            self.functionBlock = ^double(double t, double b, double c, double d) {
                return NSBKeyframeAnimationFunctionEaseInOutExpo(t, b, c, d);
            };
        }
            break;
        case OURAnimationFunctionEaseInCirc: {
            self.functionBlock = ^double(double t, double b, double c, double d) {
                return NSBKeyframeAnimationFunctionEaseInCirc(t, b, c, d);
            };
        }
            break;
        case OURAnimationFunctionEaseOutCirc: {
            self.functionBlock = ^double(double t, double b, double c, double d) {
                return NSBKeyframeAnimationFunctionEaseOutCirc(t, b, c, d);
            };
        }
            break;
        case OURAnimationFunctionEaseInOutCirc: {
            self.functionBlock = ^double(double t, double b, double c, double d) {
                return NSBKeyframeAnimationFunctionEaseInOutCirc(t, b, c, d);
            };
        }
            break;
        case OURAnimationFunctionEaseInElastic: {
            self.functionBlock = ^double(double t, double b, double c, double d) {
                return NSBKeyframeAnimationFunctionEaseInElastic(t, b, c, d);
            };
        }
            break;
        case OURAnimationFunctionEaseOutElastic: {
            self.functionBlock = ^double(double t, double b, double c, double d) {
                return NSBKeyframeAnimationFunctionEaseOutElastic(t, b, c, d);
            };
        }
            break;
        case OURAnimationFunctionEaseInOutElastic: {
            self.functionBlock = ^double(double t, double b, double c, double d) {
                return NSBKeyframeAnimationFunctionEaseInOutElastic(t, b, c, d);
            };
        }
            break;
        case OURAnimationFunctionEaseInBack: {
            self.functionBlock = ^double(double t, double b, double c, double d) {
                return NSBKeyframeAnimationFunctionEaseInBack(t, b, c, d);
            };
        }
            break;
        case OURAnimationFunctionEaseOutBack: {
            self.functionBlock = ^double(double t, double b, double c, double d) {
                return NSBKeyframeAnimationFunctionEaseOutBack(t, b, c, d);
            };
        }
            break;
        case OURAnimationFunctionEaseInOutBack: {
            self.functionBlock = ^double(double t, double b, double c, double d) {
                return NSBKeyframeAnimationFunctionEaseInOutBack(t, b, c, d);
            };
        }
            break;
        case OURAnimationFunctionEaseInBounce: {
            self.functionBlock = ^double(double t, double b, double c, double d) {
                return NSBKeyframeAnimationFunctionEaseInBounce(t, b, c, d);
            };
        }
            break;
        case OURAnimationFunctionEaseOutBounce: {
            self.functionBlock = ^double(double t, double b, double c, double d) {
                return NSBKeyframeAnimationFunctionEaseOutBounce(t, b, c, d);
            };
        }
            break;
        case OURAnimationFunctionEaseInOutBounce: {
            self.functionBlock = ^double(double t, double b, double c, double d) {
                return NSBKeyframeAnimationFunctionEaseInOutBounce(t, b, c, d);
            };
        }
            break;
        default: {
            NSAssert(NO, @"Invalid Animation Function type.");
        }
            break;
    }
}

@end
