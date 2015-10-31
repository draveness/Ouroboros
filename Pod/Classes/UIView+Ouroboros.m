//
//  UIView+Ouroboros.m
//  Ouroboros
//
//  Created by Draveness on 15/10/5.
//  Copyright © 2015年 Draveness. All rights reserved.
//

#import "UIView+Ouroboros.h"
#import "UIScrollView+Ouroboros.h"
#import "Ouroboros.h"
#import <objc/runtime.h>

@interface UIView ()

//@property (nonatomic, strong) NSMutableArray *ouroboroses;

@end

@implementation UIView (Ouroboros)

- (Ouroboros *)ouroboros {
    Ouroboros *ouroboros = [[Ouroboros alloc] initWithView:self];
    return ouroboros;
}

- (void)updateState:(NSNotification *)notification {
    CGPoint contentOffset = [[notification userInfo][@"contentOffset"] CGPointValue];
    OURScrollDirection direction = [[notification userInfo][@"direction"] integerValue];
    for (Ouroboros *ouroboros in self.ouroboroses) {
        CGFloat currentPosition = 0;
        if (direction == OURScrollDirectionHorizontal) {
            currentPosition = contentOffset.x;
        } else {
            currentPosition = contentOffset.y;
        }
        CGFloat percent = (currentPosition - ouroboros.trggier) / ouroboros.offset;
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
                self.center = CGPointMake([value floatValue], self.center.y);
            }
                break;
            case OURAnimationPropertyViewCenterY: {
                self.center = CGPointMake(self.center.x, [value floatValue]);
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
            default:
                break;
        }
    }
}

#pragma mark - Getter/Setter

- (NSMutableArray *)ouroboroses {
    if (!objc_getAssociatedObject(self, @selector(ouroboroses))) {
        objc_setAssociatedObject(self, @selector(ouroboroses), [[NSMutableArray alloc] init], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return objc_getAssociatedObject(self, @selector(ouroboroses));
}

- (void)setOuroboroses:(NSMutableArray *)ouroboroses {
    objc_setAssociatedObject(self, @selector(ouroboroses), ouroboroses, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
