//
//  OPMViewModel.m
//  FlickrApp
//
//  Created by ORIOL PONS on 24/5/16.
//  Copyright © 2016 Oriol Pons. All rights reserved.
//

#import "OPMViewModel.h"
#import "OPMFlickrAPIManager.h"

@interface OPMViewModel () <OPMFlickrAPIDelegate>

@property (nonatomic, strong) OPMFlickrAPIManager *flickrAPIManager;
@property (nonatomic, assign) NSInteger totalPhotos;

@end

@implementation OPMViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        _photos = @[];
        _flickrAPIManager = [[OPMFlickrAPIManager alloc] init];
        _flickrAPIManager.delegate = self;
        _currentPage = 1;
    }
    
    return self;
}

- (void)requestPhotosForText:(NSString *)text nextPage:(BOOL)nextPage resetData:(BOOL)resetData
{
    if (resetData) {
        self.currentPage = 1;
        self.photos = @[];
        self.totalPhotos = 0;
    } else if (nextPage) {
        self.currentPage++;
    }
    
    [self.flickrAPIManager requestFlickrPhotosForText:text page:self.currentPage];
}

- (BOOL)hasReachedLastPage
{
    return self.photos.count == self.totalPhotos;
}

#pragma mark - OPMFlickrAPIDelegate methods

- (void)flickrAPIManager:(OPMFlickrAPIManager *)flickrAPIManager didReceivePhotos:(NSArray<OPMFlickrPhoto *> *)photos totalPhotos:(NSInteger)totalPhotos
{
    self.photos = [self.photos arrayByAddingObjectsFromArray:photos];
    self.totalPhotos = totalPhotos;
    [self.delegate refreshUI];
}

@end
