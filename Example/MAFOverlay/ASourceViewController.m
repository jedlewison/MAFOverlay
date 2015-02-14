//
//  ViewController.m
//  MAFOverlayExample
//
//  Created by Jed Lewison on 1/1/15.
//  Copyright (c) 2015 Magic App Factory. All rights reserved.
//

#import "ASourceViewController.h"
#import "APresentedViewController.h"
#import "MAFOverlayPresentationCoordinator.h"
#import <MAFActionSheetController/MAFActionSheetController.h>
#import <MAFOverlay/UIViewController+MAFOverlayCoordinator.h>

@interface ASourceViewController () <MAFOverlayPresentationDataSource>

@end

@implementation ASourceViewController

-(MAFOverlayPresentationLayoutAttributes *)initialPresentationLayoutAttributesForContext:(id<MAFOverlayPresentationContext>)presentationContext {
    // get the default attributes
    MAFOverlayPresentationLayoutAttributes *atts = [[presentationContext dataSource] initialPresentationLayoutAttributesForContext:presentationContext];
    if ([[presentationContext presentedViewController] isKindOfClass:[MAFActionSheetController class]]) {

        // make some adjustments
        CGRect frame = atts.frame;
        CGRect decorationFrame = atts.decorationViewFrame;
        atts.decorationViewFrame = decorationFrame;
        atts.transform = CGAffineTransformMakeScale(0.001, 0.001);

        NSLog(@"%@",NSStringFromCGRect(CGRectApplyAffineTransform(frame, atts.transform)));
//        frame.origin.x = [presentationContext sourceView].center.x;
//        frame.origin.y = [presentationContext sourceView].center.y;
//        atts.frame = frame;
//        decorationFrame.origin.x = [presentationContext sourceView].center.x;
//        decorationFrame.origin.y = [presentationContext sourceView].center.y;
//        atts.decorationViewFrame = decorationFrame;
    }
    return atts;
}

-(MAFOverlayPresentationLayoutAttributes *)presentationLayoutAttributesForContext:(id<MAFOverlayPresentationContext>)presentationContext {
    MAFOverlayPresentationLayoutAttributes *atts = [[presentationContext dataSource] presentationLayoutAttributesForContext:presentationContext];
    if ([[presentationContext presentedViewController] isKindOfClass:[MAFActionSheetController class]]) {

        // make some adjustments
        atts.transform = CGAffineTransformIdentity;
    }
    return atts;
}

-(void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
    [self.presentedViewController.maf_overlayPresentationCoordinator performLayoutForRotationToInterfaceOrientation:toInterfaceOrientation];
}

-(IBAction)presentSimpleOverlay:(id)sender {

    APresentedViewController *overlayViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"APresentedViewController"];
    [self prepareViewControllerForOverlayPresentation:overlayViewController];
    overlayViewController.maf_overlayPresentationCoordinator.customDataSource = self;

    if ([sender isKindOfClass:[UIBarButtonItem class]]) {
        [self presentOverlayViewController:overlayViewController fromBarButtonItem:sender completion:NULL];
    } else {
        [self presentOverlayViewController:overlayViewController fromView:sender completion:NULL];
    }

}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {


    if ([segue.identifier isEqualToString:@"segueWithSource"] && [segue.destinationViewController respondsToSelector:@selector(overlayPresentationCoordinator)]) {
        [segue.destinationViewController overlayPresentationCoordinator].sourceBarButtonItem = [self.toolbarItems lastObject];
        [segue.destinationViewController setModalTransitionStyle:UIModalTransitionStyleCrossDissolve];
    } else if ([segue.identifier isEqualToString:@"segueWithCrossDissolve"] && [segue.destinationViewController respondsToSelector:@selector(overlayPresentationCoordinator)]) {
        [segue.destinationViewController setModalTransitionStyle:UIModalTransitionStyleCrossDissolve];
    }

}

-(IBAction)presentActionSheetController:(id)sender {

    MAFActionSheetController *actionSheetController = [MAFActionSheetController actionSheetControllerWithHeaderView:nil
                                                                                                         footerView:nil];
    actionSheetController.overlayPresentationCoordinator.customDataSource = self;

    MAFActionSheetItem *optionAction = [MAFActionSheetItem actionSheetItemWithTitle:@"Change To Orange"
                                                                         detailText:@"Detail"
                                                                            handler:^{
                                                                                [UIView animateWithDuration:UINavigationControllerHideShowBarDuration animations:^{
                                                                                    self.view.backgroundColor = [UIColor orangeColor];
                                                                                }];
                                                                            }];

    MAFActionSheetItem *optionAction2 = [MAFActionSheetItem actionSheetItemWithTitle:@"Action Item"
                                                                          detailText:@"Has custom background"
                                                                             handler:nil];

    MAFActionSheetItem *optionAction3 = [MAFActionSheetItem actionSheetItemWithTitle:@"Another No-Op"
                                                                          detailText:@"Detail"
                                                                             handler:nil];;


    UIView *someView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 39, 74)];
    [someView setBackgroundColor:[UIColor yellowColor]];
    [optionAction2 setCustomBackgroundView:someView];

    [actionSheetController addItem:optionAction];
    [actionSheetController addItem:optionAction2];
    [actionSheetController addItem:optionAction3];
    if ([sender isKindOfClass:[UIBarButtonItem class]]) {
        [actionSheetController.overlayPresentationCoordinator setSourceBarButtonItem:sender];
    } else {
        [actionSheetController.overlayPresentationCoordinator setSourceView:sender];
    }

    [self presentViewController:actionSheetController animated:YES
                     completion:nil];
}

@end
