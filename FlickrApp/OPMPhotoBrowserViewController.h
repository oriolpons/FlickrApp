//
//  OPMPhotoBrowserViewController.h
//  FlickrApp
//
//  Created by ORIOL PONS on 26/5/16.
//  Copyright © 2016 Oriol Pons. All rights reserved.
//

#import <MWPhotoBrowser/MWPhotoBrowser.h>

@class OPMFlickrPhoto;

@interface OPMPhotoBrowserViewController : MWPhotoBrowser

- (instancetype)initWithPhotos:(NSArray *)photosArray defaultSelectedPhotoAtIndex:(NSInteger)index;

@end
