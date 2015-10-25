//
//  Ouroboros.h
//  Ouroboros
//
//  Created by Draveness on 15/10/23.
//  Copyright © 2015年 Draveness. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

extern NSString * const kOURViewFrame;
extern NSString * const kOURViewSize;

@interface Ouroboros : NSObject

@property (nonatomic, assign, readonly) NSString *property;
@property (nonatomic, strong) id fromValue;
@property (nonatomic, strong) id toValue;
@property (nonatomic, assign) CGFloat trggier;
@property (nonatomic, assign) CGFloat duration;

- (instancetype)initWithProperty:(NSString *)property;

- (id)calculateInternalValueWithPercent:(CGFloat)percent;

@end

NS_ASSUME_NONNULL_END