//
//  MAFOverlayPresentationAnimator.m
//  MAFOverlay
//
//  Created by Jed Lewison on 1/1/15.
//  Copyright (c) 2015 Magic App Factory. All rights reserved.
//

#import "MAFOverlayPresentationAnimator.h"

@interface MAFOverlayPresentationAnimator ()

@property (nonatomic, weak) UIView *containerView;
@property (nonatomic, weak) UIView *decorationView;
@property (nonatomic, weak) UIView *dimmingView;

@property (nonatomic, weak) id<MAFOverlayPresentationDataSource> dataSource;

@property (nonatomic, weak) UIViewController *presentedViewController;
@property (nonatomic, weak) UIViewController *presentingViewController;


@end

@implementation MAFOverlayPresentationAnimator

+(instancetype)overlayPresentationAnimatorWithDataSource:(id<MAFOverlayPresentationDataSource>)dataSource presentedViewController:(UIViewController *)presentedViewController {
    if ([UIPresentationController class]) {
        return nil;
    }
    MAFOverlayPresentationAnimator *overlayAnimationController = [[self alloc] init];
    overlayAnimationController.dataSource = dataSource;
    overlayAnimationController.presentedViewController = presentedViewController;
    return overlayAnimationController;
}

-(id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented
                                                                 presentingController:(UIViewController *)presenting
                                                                     sourceController:(UIViewController *)source {
    self.presentedViewController = presented;
    self.presentingViewController = presenting;
    return self;
    
}

-(id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    if (dismissed != self.presentedViewController) {
        
    }
    return self;
}


- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    
    self.containerView = [transitionContext containerView];
    
    [self performInitialLayoutIfNeeded];
    
    NSTimeInterval animationDuration = [self transitionDuration:transitionContext];
    
    
    [UIView animateWithDuration:animationDuration
                          delay:0.f
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         
                         if ([self.presentedViewController isBeingPresented]) {
                             [self performLayout:self.presentedViewController.interfaceOrientation];
                             
                             self.presentedViewController.view.alpha = 1;
                             [self.presentedViewController.view setTintAdjustmentMode:UIViewTintAdjustmentModeAutomatic];
                             [self.presentingViewController.view setTintAdjustmentMode:UIViewTintAdjustmentModeDimmed];

                         } else if ([self.presentedViewController isBeingDismissed]) {
                             
                             [self performFinalLayoutIfNeeded];
                             [self.presentingViewController.view setTintAdjustmentMode:UIViewTintAdjustmentModeAutomatic];
                             
                         } else {
                             
                             [self performLayout:self.presentedViewController.interfaceOrientation];
                             
                         }
                         
                     } completion:^(BOOL finished) {
                         [transitionContext completeTransition:YES];
                     }];
}

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    
    return UINavigationControllerHideShowBarDuration;
}

-(void)performFinalLayoutIfNeeded {
    if (![self.presentedViewController isBeingDismissed]) {
        return;
    }
    [[self.dataSource dismissedPresentationLayoutAttributesForContext:self] applyToPresentationContext:self];
}

-(void)performInitialLayoutIfNeeded
{
    if (![self.presentedViewController isBeingPresented]) {
        return;
    }
    
    // Background view
    


    [self.containerView addSubview:self.presentedViewController.view];
    
    
    [self.presentedViewController.view addMotionEffect:[self.dataSource motionEffectGroup:self]];

    [UIView performWithoutAnimation:^{
        [[self.dataSource initialPresentationLayoutAttributesForContext:self] applyToPresentationContext:self];
    }];

}

- (MAFOverlayPresentationLayoutAttributes *)getPresentationLayoutAttributesForOrientation:(UIInterfaceOrientation)interfaceOrientation fromAttributes:(MAFOverlayPresentationLayoutAttributes *)atts {

    if (interfaceOrientation == UIInterfaceOrientationPortrait) {
        return atts;
    }

    CGRect newPresentedFrame = [self adjustRect:atts.frame forOrientation:interfaceOrientation containingFrame:self.containerView.bounds];
    CGRect newDecorationFrame = [self adjustRect:atts.decorationViewFrame forOrientation:interfaceOrientation containingFrame:self.containerView.bounds];

    MAFOverlayPresentationLayoutAttributes *newAttributes = [atts copy];
    newAttributes.frame = newPresentedFrame;
    newAttributes.decorationViewFrame = newDecorationFrame;

    return newAttributes;
}

- (CGRect)adjustRect:(CGRect)inputRect forOrientation:(UIInterfaceOrientation)interfaceOrientation containingFrame:(CGRect)containingFrame {

    CGRect adjustedRect = inputRect;

    switch (interfaceOrientation) {
        case UIInterfaceOrientationPortrait:
            break;

        case UIInterfaceOrientationPortraitUpsideDown:
            adjustedRect.origin.x = containingFrame.size.width - (inputRect.size.width + inputRect.origin.x);
            adjustedRect.origin.y = containingFrame.size.height - (inputRect.size.height + inputRect.origin.y);

            break;

        case UIInterfaceOrientationLandscapeLeft:
            adjustedRect.origin.x = inputRect.origin.y;
            adjustedRect.origin.y = containingFrame.size.height - (inputRect.size.width + inputRect.origin.x);
            adjustedRect.size.width = inputRect.size.height;
            adjustedRect.size.height = inputRect.size.width;

            break;

        case UIInterfaceOrientationLandscapeRight:
            adjustedRect.origin.x = containingFrame.size.width - (inputRect.size.height + inputRect.origin.y);
            adjustedRect.origin.y = inputRect.origin.x;
            adjustedRect.size.width = inputRect.size.height;
            adjustedRect.size.height = inputRect.size.width;
            break;
            
        default:
            break;
    }

    return adjustedRect;

}

- (void)performLayout:(UIInterfaceOrientation)interfaceOrientation {
     self.presentedViewController.view.autoresizingMask = UIViewAutoresizingNone;

    MAFOverlayPresentationLayoutAttributes *atts = [self.dataSource presentationLayoutAttributesForContext:self];
    [atts applyToPresentationContext:self];
}

-(void)presentedOverlayViewController:(UIViewController *)controller willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
    [self performLayout:toInterfaceOrientation];
    NSArray *motionEffects = controller.view.motionEffects;
    for (UIMotionEffect *effect in motionEffects) {
        [controller.view removeMotionEffect:effect];
    }
    motionEffects = self.decorationView.motionEffects;
    for (UIMotionEffect *effect in motionEffects) {
        [self.decorationView removeMotionEffect:effect];
    }

    [controller.view addMotionEffect:[self.dataSource motionEffectGroup:self]];
    [self.decorationView addMotionEffect:[self.dataSource motionEffectGroup:self]];
}

-(UIView *)dimmingView {
    if (!_dimmingView && self.containerView) {
        UIView *dimmingView = [self.dataSource containerDimmingViewInOverlayPresentationContext:self];
        dimmingView.frame = self.containerView.bounds;
        [self.containerView addSubview:dimmingView];
        _dimmingView = dimmingView;
    }
    return _dimmingView;
}

-(UIView *)decorationView {
    if (!_decorationView && self.containerView) {
        UIView *decorationView = [self.dataSource decorationView:self];
        [self.containerView addSubview:decorationView];
        _decorationView = decorationView;
        [_decorationView addMotionEffect:[self.dataSource motionEffectGroup:self]];

    }
    return _decorationView;
}
@end
