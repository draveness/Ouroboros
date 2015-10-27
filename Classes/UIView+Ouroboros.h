//
//  UIView+Ouroboros.h
//  Ouroboros
//
//  Created by Draveness on 15/10/5.
//  Copyright © 2015年 Draveness. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Ouroboros.h"


NS_ASSUME_NONNULL_BEGIN

typedef void(^OuroborosAnimationBlock)(Ouroboros *ouroboros);

@interface UIView (Ouroboros)

- (void)ou_animateWithProperty:(OURAnimationProperty)property
                configureBlock:(OuroborosAnimationBlock)configureBlock;

@end

NS_ASSUME_NONNULL_END