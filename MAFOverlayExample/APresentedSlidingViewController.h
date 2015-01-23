//
//  APresentedSlidingViewController.h
//  MAFOverlay
//
//  Created by Jed Lewison on 1/21/15.
//  Copyright (c) 2015 Magic App Factory. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MAFOverlayPresentationCoordinator;

@interface APresentedSlidingViewController : UIViewController

@property (nonatomic, readonly) MAFOverlayPresentationCoordinator *overlayPresentationCoordinator;

@end
