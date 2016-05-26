//
//  OPMPhotoBrowserViewController.m
//  FlickrApp
//
//  Created by ORIOL PONS on 26/5/16.
//  Copyright © 2016 Oriol Pons. All rights reserved.
//

#import "OPMPhotoBrowserViewController.h"
#import "OPMFlickrPhoto.h"

@interface OPMPhotoBrowserViewController () <MWPhotoBrowserDelegate>

@property (nonatomic, copy) NSArray *photos;

@end

@implementation OPMPhotoBrowserViewController

- (instancetype)initWithPhotos:(NSArray *)photosArray defaultSelectedPhotoAtIndex:(NSInteger)index
{
    self = [super initWithPhotos:photosArray];
    if (self) {
        _photos = photosArray;
        [self setCurrentPhotoIndex:index];
        self.delegate = self;
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setupNavigationSettings];
}

- (void)setupNavigationSettings
{
    [self showNextPhotoAnimated:YES];
    [self showPreviousPhotoAnimated:YES];
}

- (MWPhoto *)browserPhotoFromFlickrPhoto:(OPMFlickrPhoto *)flickrPhoto
{
    MWPhoto *photo = [MWPhoto photoWithURL:flickrPhoto.photoURL];
    photo.caption = flickrPhoto.photoTitle;
    
    return photo;
}

#pragma mark - MWPhotoBrowserDelegate methods

- (NSUInteger)numberOfPhotosInPhotoBrowser:(MWPhotoBrowser *)photoBrowser
{
    return self.photos.count;
}

- (id <MWPhoto>)photoBrowser:(MWPhotoBrowser *)photoBrowser photoAtIndex:(NSUInteger)index
{
    if (index < self.photos.count) {
        OPMFlickrPhoto *flickrPhoto = self.photos[index];
        
        return [self browserPhotoFromFlickrPhoto:flickrPhoto];
    }
    
    return nil;
}

@end
