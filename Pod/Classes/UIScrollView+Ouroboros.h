//
//  UIScrollView+Ouroboros.h
//  Ouroboros
//
//  Created by Draveness on 15/10/5.
//  Copyright © 2015年 Draveness. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, OURScrollDirection) {
    OURScrollDirectionVertical,
    OURScrollDirectionHorizontal,
};

NS_ASSUME_NONNULL_BEGIN

@interface UIScrollView (Ouroboros)

@property (nonatomic, assign) OURScrollDirection ou_scrollDirection;

@end

NS_ASSUME_NONNULL_END