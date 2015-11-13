//
//  UIView+Ouroboros.m
//  Ouroboros
//
//  Created by Draveness on 15/10/5.
//  Copyright © 2015年 Draveness. All rights reserved.
//

#import "UIView+Ouroboros.h"
#import "UIScrollView+Ouroboros.h"
#import <objc/runtime.h>

@interface UIView ()

@property (nonatomic, strong) NSMutableArray *ouroboroses;

@end

@implementation UIView (Ouroboros)

- (void)ou_updateState:(NSNotification *)notification {
    CGPoint contentOffset = [[notification userInfo][@"contentOffset"] CGPointValue];
    OURScrollDirection direction = [[notification userInfo][@"direction"] integerValue];
    for (Ouroboros *ouroboros in self.ouroboroses) {
        CGFloat currentPosition = 0;
        if (direction == OURScrollDirectionHorizontal) {
            currentPosition = contentOffset.x;
        } else {
            currentPosition = contentOffset.y;
        }
        CGFloat percent = (currentPosition - ouroboros.trggier) / ouroboros.duration;
        id value = [ouroboros calculateInternalValueWithPercent:percent];

        OURAnimationProperty property = ouroboros.property;
        switch (property) {
            case OURAnimationPropertyViewBackgroundColor: {
                self.backgroundColor = value;
            }
                break;
            case OURAnimationPropertyViewBounds:
            case OURAnimationPropertyViewFrame: {
                self.frame = [value CGRectValue];
            }
                break;
            case OURAnimationPropertyViewSize: {
                self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, [value CGSizeValue].width, [value CGSizeValue].height);
            }
                break;
            case OURAnimationPropertyViewPosition:
            case OURAnimationPropertyViewCenter: {
                self.center = [value CGPointValue];
            }
                break;
            case OURAnimationPropertyViewCenterX: {
                self.center = CGPointMake(self.center.x, [value floatValue]);
            }
                break;
            case OURAnimationPropertyViewCenterY: {
                self.center = CGPointMake([value floatValue], self.center.y);
            }
                break;
            case OURAnimationPropertyViewTintColor: {
                self.tintColor = value;
            }
                break;
            case OURAnimationPropertyViewOrigin: {
                self.frame = CGRectMake([value CGPointValue].x, [value CGPointValue].y, self.frame.size.width, self.frame.size.height);
            }
                break;
            case OURAnimationPropertyViewOriginX: {
                self.frame = CGRectMake([value floatValue], self.frame.origin.y, self.frame.size.width, self.frame.size.height);
            }
                break;
            case OURAnimationPropertyViewOriginY: {
                self.frame = CGRectMake(self.frame.origin.x, [value floatValue], self.frame.size.width, self.frame.size.height);
            }
                break;
            case OURAnimationPropertyViewWidth: {
                self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, [value floatValue], self.frame.size.height);
            }
                break;
            case OURAnimationPropertyViewHeight: {
                self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, [value floatValue]);
            }
                break;
            case OURAnimationPropertyViewAlpha: {
                self.alpha = [value floatValue];
            }
                break;
            case OURAnimationPropertyViewTransform: {
                self.transform = [value CGAffineTransformValue];
            }
                break;
            case OURAnimationPropertyLayerFrame: {
                self.layer.frame = [value CGRectValue];
            }
                break;
            case OURAnimationPropertyLayerBounds: {
                self.layer.bounds = [value CGRectValue];
            }
                break;
            case OURAnimationPropertyLayerPosition: {
                self.layer.position = [value CGPointValue];
            }
                break;
            case OURAnimationPropertyLayerZPosition: {
                self.layer.zPosition = [value floatValue];
            }
                break;
            case OURAnimationPropertyLayerAnchorPoint: {
                self.layer.anchorPoint = [value CGPointValue];
            }
                break;
            case OURAnimationPropertyLayerAnchorPointZ: {
                self.layer.anchorPointZ = [value floatValue];
            }
                break;
            case OURAnimationPropertyLayerTransform: {
                self.layer.transform = [value CATransform3DValue];
            }
                break;
            default:
                break;
        }
    }
}

- (void)ou_animateWithProperty:(OURAnimationProperty)property
                configureBlock:(OuroborosAnimationBlock)configureBlock {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ou_updateState:) name:@"ScrollView" object:nil];

    Ouroboros *ouroboros = [[Ouroboros alloc] initWithProperty:property];
    configureBlock(ouroboros);
    switch (ouroboros.property) {
        case OURAnimationPropertyViewBackgroundColor: {
            ouroboros.fromValue = self.backgroundColor;
        }
            break;
        case OURAnimationPropertyViewBounds: {
            ouroboros.fromValue = [NSValue valueWithCGRect:self.bounds];
        }
            break;
        case OURAnimationPropertyViewFrame: {
            ouroboros.fromValue = [NSValue valueWithCGRect:self.frame];
        }
            break;
        case OURAnimationPropertyViewSize: {
            ouroboros.fromValue = [NSValue valueWithCGSize:self.frame.size];
        }
            break;
        case OURAnimationPropertyViewPosition:
        case OURAnimationPropertyViewCenter: {
            ouroboros.fromValue = [NSValue valueWithCGPoint:self.center];
        }
            break;
        case OURAnimationPropertyViewCenterX: {
            ouroboros.fromValue = @(self.center.x);
        }
            break;
        case OURAnimationPropertyViewCenterY: {
            ouroboros.fromValue = @(self.center.y);
        }
            break;
        case OURAnimationPropertyViewTintColor: {
            ouroboros.fromValue = self.tintColor;
        }
            break;
        case OURAnimationPropertyViewOrigin: {
            ouroboros.fromValue = [NSValue valueWithCGPoint:self.frame.origin];
        }
            break;
        case OURAnimationPropertyViewOriginX: {
            ouroboros.fromValue = @(self.frame.origin.x);
        }
            break;
        case OURAnimationPropertyViewOriginY: {
            ouroboros.fromValue = @(self.frame.origin.y);
        }
            break;
        case OURAnimationPropertyViewWidth: {
            ouroboros.fromValue = @(self.frame.size.width);
        }
            break;
        case OURAnimationPropertyViewHeight: {
            ouroboros.fromValue = @(self.frame.size.height);
        }
            break;
        case OURAnimationPropertyViewAlpha: {
            ouroboros.fromValue = @(self.alpha);
        }
            break;
        case OURAnimationPropertyViewTransform: {
            ouroboros.fromValue = [NSValue valueWithCGAffineTransform:self.transform];
        }
            break;
        case OURAnimationPropertyLayerFrame: {
            ouroboros.fromValue = [NSValue valueWithCGRect:self.layer.frame];
        }
            break;
        case OURAnimationPropertyLayerBounds: {
            ouroboros.fromValue = [NSValue valueWithCGRect:self.layer.bounds];
        }
            break;
        case OURAnimationPropertyLayerPosition: {
            ouroboros.fromValue = [NSValue valueWithCGPoint:self.layer.position];
        }
            break;
        case OURAnimationPropertyLayerZPosition: {
            ouroboros.fromValue = @(self.layer.zPosition);
        }
            break;
        case OURAnimationPropertyLayerAnchorPoint: {
            ouroboros.fromValue = [NSValue valueWithCGPoint:self.layer.anchorPoint];
        }
            break;
        case OURAnimationPropertyLayerAnchorPointZ: {
            ouroboros.fromValue = @(self.layer.anchorPointZ);
        }
            break;
        case OURAnimationPropertyLayerTransform: {
            ouroboros.fromValue = [NSValue valueWithCATransform3D:self.layer.transform];
        }
            break;
        default:
            break;
    }
    [self.ouroboroses addObject:ouroboros];
}

#pragma mark - Getter/Setter

- (NSMutableArray *)ouroboroses {
    if (!objc_getAssociatedObject(self, @selector(ouroboroses))) {
        objc_setAssociatedObject(self, @selector(ouroboroses), [[NSMutableArray alloc] init], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return objc_getAssociatedObject(self, @selector(ouroboroses));
}

- (void)setOuroboros:(NSMutableArray *)ouroboroses {
    objc_setAssociatedObject(self, @selector(ouroboroses), ouroboroses, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
