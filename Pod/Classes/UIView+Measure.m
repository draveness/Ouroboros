//
//  UIView+Measure.m
//  Pods
//
//  Created by Draveness on 15/10/31.
//
//

#import "UIView+Measure.h"

@implementation UIView (Measure)

- (CGFloat)our_width {
    return self.frame.size.width;
}

- (CGFloat)our_height {
    return self.frame.size.height;
}

- (CGFloat)our_left {
    return self.frame.origin.x;
}

- (CGFloat)our_right {
    return self.frame.origin.x + self.frame.size.width;
}

- (CGFloat)our_top {
    return self.frame.origin.y;
}

- (CGFloat)our_bottom {
    return self.frame.origin.y + self.frame.size.height;
}

@end
