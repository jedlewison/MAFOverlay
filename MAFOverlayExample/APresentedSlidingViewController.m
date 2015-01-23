//
//  APresentedSlidingViewController.m
//  MAFOverlay
//
//  Created by Jed Lewison on 1/21/15.
//  Copyright (c) 2015 Magic App Factory. All rights reserved.
//

#import "APresentedSlidingViewController.h"
#import "MAFOverlayPresentationCoordinator.h"

@interface APresentedSlidingViewController ()

@property (nonatomic, readwrite) MAFOverlayPresentationCoordinator *overlayPresentationCoordinator;

@end

@implementation APresentedSlidingViewController

-(void)awakeFromNib {
    [super awakeFromNib];

    self.overlayPresentationCoordinator = [MAFOverlayPresentationCoordinator overlayPresentationCoordinatorWithPresentedViewController:self]; // assigns the transitioningDelegate
    self.overlayPresentationCoordinator.anchorPoint = CGPointMake(0.5f,.1f);
}

-(void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
    [self.overlayPresentationCoordinator presentedOverlayViewController:self willAnimateRotationToInterfaceOrientation:toInterfaceOrientation];
}

-(CGSize)preferredContentSize {
    return (CGSize){20009,120};
}

@end
