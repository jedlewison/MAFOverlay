//
//  MAFOptionActionCollectionViewCell.h
//  MAFOverlay
//
//  Created by Jed Lewison on 1/4/15.
//  Copyright (c) 2015 Magic App Factory. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MAFOptionActionTableViewCell;

@protocol MAFOptionActionTableViewCellDelegate <NSObject>

-(CGRect)frameForCell:(MAFOptionActionTableViewCell *)cell targetFrame:(CGRect)frame;

@end

@interface MAFOptionActionTableViewCell : UITableViewCell

@property (nonatomic, weak) id <MAFOptionActionTableViewCellDelegate> delegate; // for iOS 7 landscape iPhone

@end
