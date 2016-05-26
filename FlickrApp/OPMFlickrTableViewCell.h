//
//  OPMFlickrTableViewCell.h
//  FlickrApp
//
//  Created by ORIOL PONS on 26/5/16.
//  Copyright © 2016 Oriol Pons. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OPMFlickrTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imageThumbnailView;
@property (weak, nonatomic) IBOutlet UILabel *favouritesLabel;
@property (weak, nonatomic) IBOutlet UILabel *commentsLabel;
@property (weak, nonatomic) IBOutlet UIImageView *commentsIcon;
@property (weak, nonatomic) IBOutlet UIImageView *favouritesIcon;

+ (CGFloat)preferredHeight;

@end
