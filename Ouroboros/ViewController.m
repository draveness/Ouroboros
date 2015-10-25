//
//  ViewController.m
//  Ouroboros
//
//  Created by Draveness on 15/10/5.
//  Copyright © 2015年 Draveness. All rights reserved.
//

#import "ViewController.h"
#import "UIScrollView+Ouroboros.h"
#import "UIView+Ouroboros.h"

@interface ViewController () <UIScrollViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    [self.view addSubview:scrollView];
    scrollView.frame = self.view.bounds;
    scrollView.backgroundColor = [UIColor whiteColor];
    scrollView.contentSize = CGSizeMake(self.view.bounds.size.width, self.view.bounds.size.height * 2);
    scrollView.delegate = self;

    UIView *yellowView = [[UIView alloc] init];
    yellowView.backgroundColor = [UIColor yellowColor];
    yellowView.frame = CGRectMake(50, 50, 100, 100);
    [scrollView addSubview:yellowView];

    [yellowView ou_animateWithProperty:kOURViewSize
                        configureBlock:^(Ouroboros *ouroboros) {
                            ouroboros.fromValue = [NSValue valueWithCGSize:CGSizeMake(100, 100)];
                            ouroboros.toValue = [NSValue valueWithCGSize:CGSizeMake(200, 200)];
                            ouroboros.trggier = 0;
                            ouroboros.duration = 100;
                        }];
}

@end
