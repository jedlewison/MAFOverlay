//
//  MAFOverlayPresentationAnimator.h
//  MAFOverlay
//
//  Created by Jed Lewison on 1/1/15.
//  Copyright (c) 2015 Magic App Factory. All rights reserved.
//

#import "MAFOverlayPresentationDataSource.h"
#import "MAFOverlayPresentationContext.h"

@import UIKit;
@class MAFOverlayPresentationCoordinator;

@interface MAFOverlayPresentationAnimator : NSObject <UIViewControllerTransitioningDelegate, UIViewControllerAnimatedTransitioning, MAFOverlayPresentationContext>

@property (nonatomic, readonly, weak) id<MAFOverlayPresentationDataSource> dataSource;

+ (instancetype)overlayPresentationAnimatorWithDataSource:(id<MAFOverlayPresentationDataSource>)dataSource presentedViewController:(UIViewController *)presentedViewController;

-(void)presentedOverlayViewController:(UIViewController *)controller willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation;


@end
