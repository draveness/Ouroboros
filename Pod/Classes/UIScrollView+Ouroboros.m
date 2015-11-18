//
//  UIScrollView+Ouroboros.m
//  Ouroboros
//
//  Created by Draveness on 15/10/5.
//  Copyright © 2015年 Draveness. All rights reserved.
//

#import "UIScrollView+Ouroboros.h"
#import <objc/runtime.h>

NSString *const OURScrollViewUpdateContentOffset = @"OURScrollViewUpdateContentOffset";

@implementation UIScrollView (Ouroboros)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = [self class];
        SEL originalSelector = @selector(setContentOffset:);
        SEL swizzledSelector = @selector(ou_setContentOffset:);
        Method originalMethod = class_getInstanceMethod(class, originalSelector);
        Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
        BOOL didAddMethod =
        class_addMethod(class, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
        if (didAddMethod){
            class_replaceMethod(class, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
        } else {
            method_exchangeImplementations(originalMethod, swizzledMethod);
        }
    });
}

- (void)ou_setContentOffset:(CGPoint)contentOffset {
    [self ou_setContentOffset:contentOffset];
    [[NSNotificationCenter defaultCenter] postNotificationName:OURScrollViewUpdateContentOffset
                                                        object:nil
                                                      userInfo:@{@"contentOffset": [NSValue valueWithCGPoint:contentOffset],
                                                                 @"direction":@(self.ou_scrollDirection)}];
}

#pragma mark - Getter/Setter

- (OURScrollDirection)ou_scrollDirection {
    return [objc_getAssociatedObject(self, @selector(ou_scrollDirection)) integerValue];
}

- (void)setOu_scrollDirection:(OURScrollDirection)ou_scrollDirection {
    objc_setAssociatedObject(self, @selector(ou_scrollDirection), @(ou_scrollDirection), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
