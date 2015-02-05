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

-(void)presentOverlayViewController:(UIViewController *)viewController completion:(void (^)())completion {
    
    [self presentViewController:nil animated:YES completion:completion];
}

-(void)addPresentationCoordinatorToViewController:(UIViewController *)viewController {
    
}

-(MAFOverlayPresentationCoordinator *)maf_overlayPresentationCoordinator {
    return objc_getAssociatedObject(self, MAFOverlayCoordinatorKey);
}

@end
