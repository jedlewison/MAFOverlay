//
//  UIViewController+MAFOverlayCoordinator.h
//  Pods
//
//  Created by Jed Lewison on 2/4/15.
//
//

#import <UIKit/UIKit.h>
#import <MAFOverlay/MAFOverlayPresentationCoordinator.h>

@interface UIViewController (MAFOverlayCoordinator)

- (void)presentOverlayViewControllerFromView:(UIView *)sourceView;
- (void)presentOverlayViewControllerFromBarButtonItem:(UIView *)sourceView;
- (void)presentOverlayViewController:(UIViewController *)viewController completion:(void (^)())completion;

/** The overlay coordinator responsible for managing the presented view controller's presentation. */
@property (nonatomic, readonly) MAFOverlayPresentationCoordinator *maf_overlayPresentationCoordinator;

@end
