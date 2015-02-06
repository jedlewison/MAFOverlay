//
//  UIViewController+MAFOverlayCoordinator.m
//  Pods
//
//  Created by Jed Lewison on 2/4/15.
//
//

#import "UIViewController+MAFOverlayCoordinator.h"
@import ObjectiveC;

static void *MAFOverlayCoordinatorKey = &MAFOverlayCoordinatorKey;

@implementation UIViewController (MAFOverlayCoordinator)

-(void)prepareViewControllerForOverlayPresentation:(UIViewController *)viewControllerToPresent {
    if (viewControllerToPresent.maf_overlayPresentationCoordinator == nil) {
        MAFOverlayPresentationCoordinator *coordinator = [MAFOverlayPresentationCoordinator overlayPresentationCoordinatorWithPresentedViewController:viewControllerToPresent];
        objc_setAssociatedObject(viewControllerToPresent, MAFOverlayCoordinatorKey, coordinator, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
}

-(MAFOverlayPresentationCoordinator *)maf_overlayPresentationCoordinator {
    return objc_getAssociatedObject(self, MAFOverlayCoordinatorKey);
}

-(void)presentOverlayViewController:(UIViewController *)overlayViewController completion:(void (^)())completion {
    [self presentOverlayViewController:overlayViewController
                              fromView:nil
                     fromBarButtonItem:nil
                            completion:completion];
}

-(void)presentOverlayViewController:(UIViewController *)overlayViewController fromBarButtonItem:(UIBarButtonItem *)sourceBarButtonItem completion:(void (^)())completion {
    [self presentOverlayViewController:overlayViewController
                              fromView:nil
                     fromBarButtonItem:sourceBarButtonItem
                            completion:completion];
    
}

-(void)presentOverlayViewController:(UIViewController *)overlayViewController fromView:(UIView *)sourceView completion:(void (^)())completion {
    [self presentOverlayViewController:overlayViewController
                              fromView:sourceView
                     fromBarButtonItem:nil
                            completion:completion];
    
}

-(void)presentOverlayViewController:(UIViewController *)overlayViewController fromView:(UIView *)sourceView fromBarButtonItem:(UIBarButtonItem *)sourceBarButtonItem completion:(void (^)())completion {
    
    [self prepareViewControllerForOverlayPresentation:overlayViewController];
    if (sourceView) {
        overlayViewController.maf_overlayPresentationCoordinator.sourceView = sourceView;
    }
    if (sourceBarButtonItem) {
        overlayViewController.maf_overlayPresentationCoordinator.sourceBarButtonItem = sourceBarButtonItem;
    }
    [self presentViewController:overlayViewController animated:YES completion:completion];
}

@end
