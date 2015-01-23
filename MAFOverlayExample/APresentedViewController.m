//
//  APresentedViewController.m
//  MAFOverlay
//
//  Created by Jed Lewison on 1/1/15.
//  Copyright (c) 2015 Magic App Factory. All rights reserved.
//

#import "APresentedViewController.h"
#import "MAFOverlayPresentationCoordinator.h"

@interface APresentedViewController ()

@property (nonatomic, readwrite) MAFOverlayPresentationCoordinator *overlayPresentationCoordinator;
@property (nonatomic, weak) IBOutlet UIButton *theButton;
@end

@implementation APresentedViewController

-(void)awakeFromNib {
    [super awakeFromNib];
    
    self.overlayPresentationCoordinator = [MAFOverlayPresentationCoordinator overlayPresentationCoordinatorWithPresentedViewController:self]; // assigns the transitioningDelegate
}

-(CGSize)preferredContentSize {
    return CGSizeMake(140, 90);
}

-(void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
    [self.overlayPresentationCoordinator presentedOverlayViewController:self willAnimateRotationToInterfaceOrientation:toInterfaceOrientation];
}

-(UIModalTransitionStyle)modalTransitionStyle {
    return UIModalTransitionStyleCrossDissolve;
}

@end
