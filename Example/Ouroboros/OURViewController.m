//
//  OURViewController.m
//  Ouroboros
//
//  Created by Draveness on 10/28/2015.
//  Copyright (c) 2015 Draveness. All rights reserved.
//

#import "OURViewController.h"
#import "Ouroboros.h"

@interface OURViewController ()

@end

@implementation OURViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    [self.view addSubview:scrollView];
    scrollView.frame = self.view.bounds;
    scrollView.backgroundColor = [UIColor whiteColor];
    scrollView.contentSize = CGSizeMake(self.view.bounds.size.width * 3, self.view.bounds.size.height);
    scrollView.pagingEnabled = YES;
    scrollView.ou_scrollDirection = OURScrollDirectionHorizontal;

    UIView *yellowView = [[UIView alloc] init];
    yellowView.backgroundColor = [UIColor redColor];
    yellowView.frame = CGRectMake(0, 0, 100, 100);
    yellowView.center = self.view.center;
    [scrollView addSubview:yellowView];

//    [yellowView our_animateWithProperty:OURAnimationPropertyViewBackgroundColor
//                         configureBlock:^(Scale *scale) {
//                             scale.toValue = [UIColor blueColor];
//                             scale.offset = self.view.our_width;
//                         }];
//    [yellowView our_animateWithProperty:OURAnimationPropertyViewBackgroundColor
//                         configureBlock:^(Scale *scale) {
//                             scale.trigger = self.view.our_width * 1.5;
//                             scale.toValue = [UIColor purpleColor];
//                             scale.offset = self.view.our_width * 0.5;
//                         }];
    [yellowView our_animateWithProperty:OURAnimationPropertyViewHeight configureBlock:^(Scale * _Nonnull scale) {
        scale.toValue = @(200);
        scale.offset = self.view.our_width * 2;
        scale.function = OURAnimationFunctionEaseOutQuad;
    }];
    [yellowView our_animateWithProperty:OURAnimationPropertyViewWidth configureBlock:^(Scale * _Nonnull scale) {
        scale.toValue = @(200);
        scale.offset = self.view.our_width * 2;
        scale.function = OURAnimationFunctionEaseOutQuad;
    }];
    [yellowView our_pinWithConfigureBlock:^(Scale * _Nonnull scale) {
    }];
//    [yellowView our_animateWithProperty:OURAnimationPropertyViewFrame
//                         configureBlock:^(Scale *scale) {
//                             scale.fromValue = NSValueFromCGRectParameters(50, 50, 100, 100);
//                             scale.toValue = NSValueFromCGRectParameters(50, 250, 100, 100);
//                             scale.offset = self.view.our_width;
//                         }];
}

@end
