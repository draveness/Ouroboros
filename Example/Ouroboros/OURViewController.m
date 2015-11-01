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
    yellowView.frame = CGRectMake(50, 50, 100, 100);
    [scrollView addSubview:yellowView];

    [yellowView.ouroboros animateWithProperty:OURAnimationPropertyViewBackgroundColor
                               configureBlock:^(Ouroboros *ouroboros) {
                                   ouroboros.toValue = [UIColor blueColor];
                                   ouroboros.offset = self.view.our_width;
                               }];
    [yellowView.ouroboros animateWithProperty:OURAnimationPropertyViewFrame
                               configureBlock:^(Ouroboros *ouroboros) {
                                   ouroboros.toValue = NSValueFromCGRectParameters(50, 250, 100, 100);
                                   ouroboros.offset = self.view.our_width;
                               }];
    [yellowView.ouroboros pinWithConfigureBlock:^(Ouroboros * _Nonnull ouroboros) {
        ouroboros.offset = INT_MAX;
    }];
}

@end
