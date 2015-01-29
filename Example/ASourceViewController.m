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

@interface ASourceViewController ()

@end

@implementation ASourceViewController


-(IBAction)presentSimpleOverlay:(id)sender {
    APresentedViewController *overlayViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"APresentedViewController"];
    if ([sender isKindOfClass:[UIBarButtonItem class]]) {
        [overlayViewController.overlayPresentationCoordinator setSourceBarButtonItem:sender];
    } else {
        [overlayViewController.overlayPresentationCoordinator setSourceView:sender];
    }
    [self presentViewController:overlayViewController animated:YES completion:NULL];
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
    
    
    UIView *someView = [[UIView alloc] initWithFrame:self.view.bounds];
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
    
    [self presentViewController:actionSheetController animated:NO
                     completion:nil];
}

@end
