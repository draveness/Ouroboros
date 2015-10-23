//
//  UIView+Ouroboros.m
//  Ouroboros
//
//  Created by Draveness on 15/10/5.
//  Copyright © 2015年 Draveness. All rights reserved.
//

#import "UIView+Ouroboros.h"
#import <objc/runtime.h>

@interface UIView ()

@property (nonatomic, strong) Ouroboros *ouroboros;

@end

@implementation UIView (Ouroboros)

- (void)ou_updateState:(NSNotification *)notification {
    CGPoint contentOffset = [[notification userInfo][@"contentOffset"] CGPointValue];
    CGFloat percent = (contentOffset.y - self.ouroboros.trggier) / self.ouroboros.duration;
    NSLog(@"%@", @(percent));
    NSValue *value = [self.ouroboros calculateInternalValueWithPercent:percent];
    switch (self.ouroboros.animationType) {
        case OuroborosAnimationTypeViewFrame:
            self.frame = [value CGRectValue];
            NSLog(@"%@", NSStringFromCGRect(self.frame));
            break;

        default:
            break;
    }
//    }
}

- (void)ou_animateWithType:(OuroborosAnmationType)animationType configureBlock:(OuroborosAnimationBlock)configureBlock {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ou_updateState:) name:@"ScrollView" object:nil];

    self.ouroboros = [[Ouroboros alloc] init];
    configureBlock(self.ouroboros);
}

#pragma mark - Getter/Setter

- (Ouroboros *)ouroboros {
    return objc_getAssociatedObject(self, @selector(ouroboros));
}

- (void)setOuroboros:(Ouroboros *)ouroboros {
    objc_setAssociatedObject(self, @selector(ouroboros), ouroboros, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
