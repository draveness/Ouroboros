//
//  UIView+Ouroboros.h
//  Ouroboros
//
//  Created by Draveness on 15/10/5.
//  Copyright © 2015年 Draveness. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Ouroboros.h"

typedef void(^OuroborosAnimationBlock)(Ouroboros *ouroboros);

@interface UIView (Ouroboros)

- (void)ou_animateWithType:(OuroborosAnmationType)animationType configureBlock:(OuroborosAnimationBlock)configureBlock;

@end
