//
//  MAFOverlayPresentationContext.h
//  MAFOverlay
//
//  Created by Jed Lewison on 1/12/15.
//  Copyright (c) 2015 Magic App Factory. All rights reserved.
//

@import UIKit;

@protocol MAFOverlayPresentationContext <NSObject>

-(UIViewController *)presentedViewController;
-(UIViewController *)presentingViewController;
-(UIView *)containerView;
-(UIView *)decorationView;
-(UIView *)dimmingView;

@end

@protocol MAFOverlayPresentationContextTransitioning <NSObject>
@optional
-(void)presentationContextWillPresent:(id<MAFOverlayPresentationContext>)presentationContext;
-(void)presentationContextDidPresent:(id<MAFOverlayPresentationContext>)presentationContext;
-(void)presentationContextWillDismiss:(id<MAFOverlayPresentationContext>)presentationContext;
-(void)presentationContextDidDismiss:(id<MAFOverlayPresentationContext>)presentationContext;
@end
