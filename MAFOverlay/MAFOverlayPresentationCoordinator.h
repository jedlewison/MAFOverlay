//
//  MAFOverlayPresentationCoordinator.h
//  MAFOverlay
//
//  Created by Jed Lewison on 1/1/15.
//  Copyright (c) 2015 Magic App Factory. All rights reserved.
//

@import UIKit;
#import "MAFOverlayPresentationDataSource.h"

@class MAFOverlayPresentationCoordinator;

@protocol MAFOverlayPresentationCoordinatorDelegate <NSObject>

@optional
@end

@interface MAFOverlayPresentationCoordinator : NSObject <MAFOverlayPresentationDataSource>

+(instancetype)overlayPresentationCoordinatorWithPresentedViewController:(UIViewController *)presentedViewController;

@property (nonatomic, weak) UIView *sourceView;
@property (nonatomic, weak) UIBarButtonItem *sourceBarButtonItem;
@property (nonatomic) CGPoint anchorPoint; // relative 0-1, 0-1, 0,0 is top left; only applies w/o sourceView. default 0.5/0.5

@property (nonatomic, weak, readonly) UIViewController *presentedViewController;

@property (nonatomic, weak) id<MAFOverlayPresentationCoordinatorDelegate>delegate;

@property (nonatomic) UIEdgeInsets minimumContainerEdgeInsets;

-(void)presentedOverlayViewController:(UIViewController *)controller willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation;

@end
