//
//  APresentedSlidingViewController.m
//  MAFOverlay
//
//  Created by Jed Lewison on 1/21/15.
//  Copyright (c) 2015 Magic App Factory. All rights reserved.
//

#import "APresentedSlidingViewController.h"
#import "MAFOverlayPresentationCoordinator.h"

@interface APresentedSlidingViewController ()

@property (nonatomic, readwrite) MAFOverlayPresentationCoordinator *overlayPresentationCoordinator;

@end

@implementation APresentedSlidingViewController

-(void)viewDidLoad {
    [super viewDidLoad];
    
}
-(void)awakeFromNib {
    [super awakeFromNib];

    self.overlayPresentationCoordinator = [MAFOverlayPresentationCoordinator overlayPresentationCoordinatorWithPresentedViewController:self]; // assigns the transitioningDelegate
}

-(void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
    [self.overlayPresentationCoordinator performLayoutForRotationToInterfaceOrientation:toInterfaceOrientation];
}

-(CGSize)preferredContentSize {
    return (CGSize){280,120};
}

@end
