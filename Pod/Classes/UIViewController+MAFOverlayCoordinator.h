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

/** Will create/configurate an overlay coordinator on the presented view controller before presenting it. You only need to use this method if you want to do something with the overlay coordinator/view controller before presenting it, for example overriding it's default datasource or some other configuration. Otherwise, this method will be called if needed by the convenience methods. After calling this method, you can present the overlay yourself or use one of the convenience methods */

- (void)prepareViewControllerForOverlayPresentation:(UIViewController *)viewControllerToPresent;

/** Convenience methods to present overlay view controller. If needed, will call prepareViewControllerForOverlayPresentation. */
- (void)presentOverlayViewController:(UIViewController *)overlayViewController fromView:(UIView *)sourceView completion:(void (^)())completion;
- (void)presentOverlayViewController:(UIViewController *)overlayViewController fromBarButtonItem:(UIBarButtonItem *)sourceBarButtonItem completion:(void (^)())completion;
- (void)presentOverlayViewController:(UIViewController *)overlayViewController completion:(void (^)())completion;

/** The overlay coordinator responsible for managing the presented view controller's presentation. Created during the prepareViewControllerForOverlayPresentation step */
@property (nonatomic, readonly) MAFOverlayPresentationCoordinator *maf_overlayPresentationCoordinator;

@end
