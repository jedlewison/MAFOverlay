//
//  APresentedViewController.m
//  MAFOverlay
//
//  Created by Jed Lewison on 1/1/15.
//  Copyright (c) 2015 Magic App Factory. All rights reserved.
//

#import "APresentedViewController.h"
#import <MAFOverlay/UIViewController+MAFOverlayCoordinator.h>

@interface APresentedViewController ()

@property (nonatomic, weak) IBOutlet UILabel *myLabel;
@end

@implementation APresentedViewController

-(CGSize)preferredContentSize {
    return (CGSizeMake(self.myLabel.intrinsicContentSize.width + 20, self.myLabel.intrinsicContentSize.height + 20));
}

@end
