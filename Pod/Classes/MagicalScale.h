//
//  MagicalScale.h
//  Pods
//
//  Created by Draveness on 15/11/5.
//
//

#import <Ouroboros/Ouroboros.h>

typedef NS_OPTIONS(NSUInteger, OURFrameAnimationTag) {
    OURFrameAnimationTagX = 1 << 0,
    OURFrameAnimationTagY = 1 << 1,
    OURFrameAnimationTagWidth = 1 << 2,
    OURFrameAnimationTagHeight = 1 << 3,
    OURFrameAnimationTagSize = 11 << 2,
    OURFrameAnimationTagOrigin = 11 << 0,
    OURFrameAnimationTagFrame = 1111,
};

@interface MagicalScale : Scale

@property (nonatomic, assign) OURFrameAnimationTag tag;

@end
