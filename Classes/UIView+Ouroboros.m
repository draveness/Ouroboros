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

@property (nonatomic, strong) NSMutableArray *ouroboroses;

@end

@implementation UIView (Ouroboros)

- (void)ou_updateState:(NSNotification *)notification {
    CGPoint contentOffset = [[notification userInfo][@"contentOffset"] CGPointValue];
    for (Ouroboros *ouroboros in self.ouroboroses) {
        CGFloat percent = (contentOffset.y - ouroboros.trggier) / ouroboros.duration;
        id value = [ouroboros calculateInternalValueWithPercent:percent];
        if ([ouroboros.property isEqualToString:kOURViewFrame]) {
            self.frame = [value CGRectValue];
        } else if ([ouroboros.property isEqualToString:kOURViewSize]) {
            self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, [value CGSizeValue].width, [value CGSizeValue].height);
        } else if ([ouroboros.property isEqualToString:kOURViewBackground]) {
            self.backgroundColor = value;
        }
    }
}

- (void)ou_animateWithProperty:(NSString *)property
                configureBlock:(OuroborosAnimationBlock)configureBlock {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ou_updateState:) name:@"ScrollView" object:nil];

    Ouroboros *ouroboros = [[Ouroboros alloc] initWithProperty:property];
    configureBlock(ouroboros);
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
