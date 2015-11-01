//
//  Scale.h
//  Pods
//
//  Created by Draveness on 15/11/1.
//
//

#import <UIKit/UIKit.h>
#import "UIView+Ouroboros.h"

NS_ASSUME_NONNULL_BEGIN

@interface Scale : NSObject

@property (nonatomic, strong) id fromValue;
@property (nonatomic, strong) id toValue;
@property (nonatomic, assign) CGFloat trggier;
@property (nonatomic, assign) CGFloat offset;
@property (nonatomic, assign, readonly) CGFloat stop;

- (id)calculateInternalValueWithPercent:(CGFloat)percent;

- (BOOL)isCurrentPositionOnScale:(CGFloat)currentPostion;
- (BOOL)isSeparateWithScale:(Scale *)scale;

@end

NS_ASSUME_NONNULL_END