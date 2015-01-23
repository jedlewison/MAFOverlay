//
//  MAFOverlayPresentationDataSource.h
//  MAFOverlay
//
//  Created by Jed Lewison on 1/4/15.
//  Copyright (c) 2015 Magic App Factory. All rights reserved.
//

@import UIKit;
#import "MAFOverlayPresentationContext.h"
#import "MAFOverlayPresentationLayoutAttributes.h"

typedef NS_ENUM(NSUInteger, MAFOverlayArrowDirection) {
    MAFOverlayArrowDirectionNoArrow,
    MAFOverlayArrowDirectionUp,
    MAFOverlayArrowDirectionDown,
    MAFOverlayArrowDirectionLeft,
    MAFOverlayArrowDirectionRight
};

@class MAFOverlayPresentationCoordinator;

@protocol MAFOverlayPresentationDataSource <NSObject>

- (MAFOverlayPresentationLayoutAttributes *)initialPresentationLayoutAttributesForContext:(id<MAFOverlayPresentationContext>)presentationContext;

- (MAFOverlayPresentationLayoutAttributes *)presentationLayoutAttributesForContext:(id<MAFOverlayPresentationContext>)presentationContext;

- (MAFOverlayPresentationLayoutAttributes *)dismissedPresentationLayoutAttributesForContext:(id<MAFOverlayPresentationContext>)presentationContext;

- (UIView *)containerDimmingViewInOverlayPresentationContext:(id<MAFOverlayPresentationContext>)presentationContext;

- (UIView *)decorationView:(id<MAFOverlayPresentationContext>)presentationContext;

- (UIMotionEffectGroup *)motionEffectGroup:(id<MAFOverlayPresentationContext>)presentationContext;

@end
