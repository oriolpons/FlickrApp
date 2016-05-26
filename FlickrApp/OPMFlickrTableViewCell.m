//
//  OPMFlickrTableViewCell.m
//  FlickrApp
//
//  Created by ORIOL PONS on 26/5/16.
//  Copyright © 2016 Oriol Pons. All rights reserved.
//

#import "OPMFlickrTableViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface OPMFlickrTableViewCell ()


@end

@implementation OPMFlickrTableViewCell


- (void)bindViewModel:(id)viewModel {
//  self.titleLabel.text = photo.title;
  
  self.imageThumbnailView.contentMode = UIViewContentModeScaleToFill;
  
//  [self.imageThumbnailView setImageWithURL:photo.url];
//  
//  
//  photo.isVisible = YES;
  
}

+ (CGFloat)preferredHeight
{
    return 206;
}

@end
