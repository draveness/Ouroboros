//
//  MagicalScale.h
//  Pods
//
//  Created by Draveness on 15/11/5.
//
//

#import "Scale.h"

typedef NS_OPTIONS(NSUInteger, OURFrameAnimationTag) {
    OURFrameAnimationTagX = 1 << 0,
    OURFrameAnimationTagCenterX = 1 << 0,
    OURFrameAnimationTagY = 1 << 1,
    OURFrameAnimationTagCenterY = 1 << 1,
    OURFrameAnimationTagWidth = 1 << 2,
    OURFrameAnimationTagHeight = 1 << 3,
    OURFrameAnimationTagSize = 1 << 2 | 1 << 3,
    OURFrameAnimationTagOrigin = 1 << 0 | 1 << 1,
    OURFrameAnimationTagCenter = 1 << 0 | 1 << 1,
    OURFrameAnimationTagFrame = 1 << 0 | 1 << 1 | 1 << 2 | 1 << 3,
};

@interface MagicalScale : Scale

@property (nonatomic, assign) OURFrameAnimationTag tag;

@end
