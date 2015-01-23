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
#import "MAFOptionActionSheetController.h"

@interface ASourceViewController ()
@property (nonatomic) NSUInteger counter;
@end

@implementation ASourceViewController


-(IBAction)didPressAButton:(id)sender {

    self.counter++;

    if (self.counter % 2) {

        MAFOptionActionSheetController *optionActionSheetController = [self.storyboard instantiateViewControllerWithIdentifier:@"optionAction"];//[MAFOptionActionSheetController optionActionSheetController];

        optionActionSheetController.overlayPresentationCoordinator = [MAFOverlayPresentationCoordinator overlayPresentationCoordinatorWithPresentedViewController:optionActionSheetController];


    if ([sender isKindOfClass:[UIBarButtonItem class]]) {
        [optionActionSheetController.overlayPresentationCoordinator setSourceBarButtonItem:sender];
    } else {
        [optionActionSheetController.overlayPresentationCoordinator setSourceView:sender];

    }

    MAFOptionAction *optionAction = [MAFOptionAction optionActionWithTitle:@"Option Action One" detailText:@"Presents from bar button" checked:NO handler:^{
//        [self didPressAButton:self.navigationItem.leftBarButtonItem];
    }];

    MAFOptionAction *optionAction2 = [MAFOptionAction optionActionWithTitle:@"Option Action No Detail" detailText:nil checked:YES handler:^{
//        [self didPressAButton:sender];
    }];

    MAFOptionAction *optionAction3 = [MAFOptionAction optionActionWithTitle:@"Option Action Three" detailText:@"Some detail" checked:NO handler:^{
//        [self didPressAButton:self.navigationItem.rightBarButtonItem];
    }];

    [optionActionSheetController addOptionAction:optionAction];
    [optionActionSheetController addOptionAction:optionAction2];
        [optionActionSheetController addOptionAction:optionAction3];
 [self presentViewController:optionActionSheetController animated:YES completion:NULL];
    } else {


    APresentedViewController *overlayViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"APresentedViewController"];
    if ([sender isKindOfClass:[UIBarButtonItem class]]) {
        [overlayViewController.overlayPresentationCoordinator setSourceBarButtonItem:sender];
    } else {
        [overlayViewController.overlayPresentationCoordinator setSourceView:sender];
    }
    [self presentViewController:overlayViewController animated:YES completion:NULL];
    }
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.destinationViewController respondsToSelector:@selector(overlayPresentationCoordinator)]) {
//        [segue.destinationViewController overlayPresentationCoordinator].sourceBarButtonItem = [self.toolbarItems lastObject];
    }
}

@end
