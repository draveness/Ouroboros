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
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:scrollView];
    scrollView.frame = self.view.bounds;
    scrollView.backgroundColor = [UIColor clearColor];
    scrollView.contentSize = CGSizeMake(self.view.bounds.size.width * 3, self.view.bounds.size.height);
    scrollView.pagingEnabled = YES;
    scrollView.ou_scrollDirection = OURScrollDirectionHorizontal;

    UIView *backgroundView = [[UIView alloc] initWithFrame:self.view.frame];
    backgroundView.backgroundColor = [UIColor whiteColor];
    [scrollView addSubview:backgroundView];

    [backgroundView our_pinWithConfigureBlock:^(Scale * _Nonnull scale) {

    }];
    [backgroundView our_animateWithProperty:OURAnimationPropertyViewBackgroundColor
                         configureBlock:^(Scale * _Nonnull scale) {
                             scale.trigger = 0;
                             scale.offset = self.view.our_width;
                             scale.toValue = [UIColor colorWithRed:0.537 green:0.537 blue:0.537 alpha:1.0];
                         }];
    [backgroundView our_animateWithProperty:OURAnimationPropertyViewBackgroundColor
                         configureBlock:^(Scale * _Nonnull scale) {
                             scale.trigger = self.view.our_width;
                             scale.offset = self.view.our_width;
                             scale.toValue = [UIColor colorWithRed:0.263 green:0.263 blue:0.263 alpha:1.0];
                         }];

    UILabel *firstLabel = [[UILabel alloc] init];
    firstLabel.text = @"Social Media Have Connections";
    firstLabel.textColor = [UIColor colorWithRed:0.243 green:0.239 blue:0.239 alpha:1.0];


    UILabel *secondLabel = [[UILabel alloc] init];
    secondLabel.text = @"We Help You Organize Them";
    secondLabel.alpha = 0;
    secondLabel.textColor = [UIColor whiteColor];

    UILabel *thirdLabel = [[UILabel alloc] init];
    thirdLabel.text = @"Cardro\nConnect More";
    thirdLabel.alpha = 0;
    thirdLabel.textColor = [UIColor whiteColor];

    for (UILabel *label in @[firstLabel, secondLabel, thirdLabel]) {
        label.font = [UIFont fontWithName:@"HelveticaNeue-UltraLight" size:40];
        label.frame = CGRectMake(34.5, 106, 307, 94);
        label.numberOfLines = 2;
        label.textAlignment = NSTextAlignmentCenter;
        [scrollView addSubview:label];
    }

    [firstLabel our_pinWithConfigureBlock:^(Scale * _Nonnull scale) {

    }];
    [firstLabel our_animateWithProperty:OURAnimationPropertyViewAlpha
                         configureBlock:^(Scale * _Nonnull scale) {
                             scale.offset = self.view.our_width * 0.5;
                             scale.toValue = @(0);
                         }];
    [secondLabel our_pinWithConfigureBlock:^(Scale * _Nonnull scale) {

    }];
    [secondLabel our_animateWithProperty:OURAnimationPropertyViewAlpha
                          configureBlock:^(Scale * _Nonnull scale) {
                              scale.trigger = self.view.our_width * 0.5;
                              scale.offset = self.view.our_width * 0.5;
                              scale.toValue = @(1);
                          }];
    [secondLabel our_animateWithProperty:OURAnimationPropertyViewAlpha
                          configureBlock:^(Scale * _Nonnull scale) {
                              scale.trigger = self.view.our_width;
                              scale.offset = self.view.our_width * 0.5;
                              scale.toValue = @(0);
                          }];
    [thirdLabel our_pinWithConfigureBlock:^(Scale * _Nonnull scale) {

    }];
    [thirdLabel our_animateWithProperty:OURAnimationPropertyViewAlpha
                         configureBlock:^(Scale * _Nonnull scale) {
                             scale.trigger = self.view.our_width * 1.5;
                             scale.offset = self.view.our_width * 0.5;
                             scale.toValue = @(1);
                         }];

    UIImageView *twitter = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"twitter"]];
    UIImageView *instagram = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"instagram"]];
    UIImageView *google = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Google"]];
    UIImageView *linkedin = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"linkedin"]];

    twitter.frame = CGRectMake(30.5, 331, 48, 48);
    instagram.frame = CGRectMake(115, 424, 48, 48);
    google.frame = CGRectMake(211.5, 331, 48, 48);
    linkedin.frame = CGRectMake(297.5, 424, 48, 48);

    for (UIImageView *imageView in @[twitter, instagram, google, linkedin]) {
        [scrollView addSubview:imageView];
    }

    // second page
    [twitter our_animateWithProperty:OURAnimationPropertyViewFrame
                      configureBlock:^(Scale * _Nonnull scale) {
                          scale.offset = self.view.our_width;
                          scale.toValue = [NSValue valueWithCGRect:CGRectMake(46.5 + self.view.our_width, 274, 48, 48)];
                      }];
    [instagram our_animateWithProperty:OURAnimationPropertyViewFrame
                        configureBlock:^(Scale * _Nonnull scale) {
                            scale.offset = self.view.our_width;
                            scale.toValue = [NSValue valueWithCGRect:CGRectMake(46.5 + self.view.our_width, 348, 48, 48)];
                        }];
    [google our_animateWithProperty:OURAnimationPropertyViewFrame
                     configureBlock:^(Scale * _Nonnull scale) {
                         scale.offset = self.view.our_width;
                         scale.toValue = [NSValue valueWithCGRect:CGRectMake(46.5 + self.view.our_width, 421, 48, 48)];
                     }];
    [linkedin our_animateWithProperty:OURAnimationPropertyViewFrame
                       configureBlock:^(Scale * _Nonnull scale) {
                           scale.offset = self.view.our_width;
                           scale.toValue = [NSValue valueWithCGRect:CGRectMake(46.5 + self.view.our_width, 494, 48, 48)];
                       }];

    // third page
    [twitter our_animateWithProperty:OURAnimationPropertyViewFrame
                      configureBlock:^(Scale * _Nonnull scale) {
                          scale.trigger = self.view.our_width;
                          scale.offset = self.view.our_width;
                          scale.toValue = [NSValue valueWithCGRect:CGRectMake(94.5 + self.view.our_width * 2, 309, 34, 34)];
                      }];
    [instagram our_animateWithProperty:OURAnimationPropertyViewFrame
                        configureBlock:^(Scale * _Nonnull scale) {
                            scale.trigger = self.view.our_width;
                            scale.offset = self.view.our_width;
                            scale.toValue = [NSValue valueWithCGRect:CGRectMake(94.5 + self.view.our_width * 2, 360, 34, 34)];
                        }];
    [google our_animateWithProperty:OURAnimationPropertyViewFrame
                     configureBlock:^(Scale * _Nonnull scale) {
                         scale.trigger = self.view.our_width;
                         scale.offset = self.view.our_width;
                         scale.toValue = [NSValue valueWithCGRect:CGRectMake(94.5 + self.view.our_width * 2, 411, 34, 34)];
                     }];
    [linkedin our_animateWithProperty:OURAnimationPropertyViewFrame
                       configureBlock:^(Scale * _Nonnull scale) {
                           scale.trigger = self.view.our_width;
                           scale.offset = self.view.our_width;
                           scale.toValue = [NSValue valueWithCGRect:CGRectMake(94.5 + self.view.our_width * 2, 463, 34, 34)];
                       }];

    for (int i = 0; i < 4; i++) {
        UIView *line = [[UIView alloc] init];
        line.backgroundColor = [UIColor colorWithRed:0.847 green:0.847 blue:0.847 alpha:1.0];
        line.frame = CGRectMake(117 + self.view.our_width + i * self.view.our_width * 0.5, 292 + 73 * i, 200, 15);
        [scrollView addSubview:line];
        [line our_animateWithProperty:OURAnimationPropertyViewFrame
                       configureBlock:^(Scale * _Nonnull scale) {
                           scale.offset = self.view.our_width;
                           scale.toValue = [NSValue valueWithCGRect:CGRectMake(117 + self.view.our_width, 292 + 73 * i, 200, 15)];
                       }];
        [line our_animateWithProperty:OURAnimationPropertyViewFrame
                       configureBlock:^(Scale * _Nonnull scale) {
                           scale.trigger = self.view.our_width;
                           scale.offset = self.view.our_width;
                           scale.toValue = [NSValue valueWithCGRect:CGRectMake(144 + self.view.our_width * 2, 321 + i * 51, 140, 11)];
                       }];
    }

    UIImageView *cardBG = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"CardBG"]];
    cardBG.alpha = 0;
    cardBG.frame = CGRectMake(66, 247, 245, 324);
    [scrollView insertSubview:cardBG aboveSubview:backgroundView];

    [cardBG our_pinWithConfigureBlock:^(Scale * _Nonnull scale) {

    }];
    [cardBG our_animateWithProperty:OURAnimationPropertyViewAlpha
                     configureBlock:^(Scale * _Nonnull scale) {
                         scale.trigger = self.view.our_width * 1.5;
                         scale.offset = self.view.our_width;
                         scale.toValue = @(1);
                     }];
}

@end
