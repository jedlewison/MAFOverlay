//
//  MAFOverlayPresentationLayoutAttributes.h
//  MAFOverlay
//
//  Created by Jed Lewison on 1/14/15.
//  Copyright (c) 2015 Magic App Factory. All rights reserved.
//

@import UIKit;
#import "MAFOverlayPresentationContext.h"

@interface MAFOverlayPresentationLayoutAttributes : NSObject <NSCopying>

@property (nonatomic) CGRect frame;
@property (nonatomic) CGFloat alpha; // default 1.
@property (nonatomic) CGAffineTransform transform; // default identify
@property (nonatomic) CGFloat dimmingViewAlpha; //default 1.f
@property (nonatomic) CGRect decorationViewFrame;
@property (nonatomic) CGFloat cornerRadius; //default 10
@property (nonatomic) UIViewTintAdjustmentMode presentedViewTintAdjustmentMode;
@property (nonatomic) UIViewTintAdjustmentMode presentingViewTintAdjustmentMode;
@property (nonatomic) UIEdgeInsets minimumMargin;

- (void)applyToPresentationContext:(id<MAFOverlayPresentationContext>)presentationContext;

@end
