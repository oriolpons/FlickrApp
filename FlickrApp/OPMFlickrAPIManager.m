//
//  OPMFlickrAPIManager.m
//  FlickrApp
//
//  Created by ORIOL PONS on 25/5/16.
//  Copyright © 2016 Oriol Pons. All rights reserved.
//

#import "OPMFlickrAPIManager.h"
#import <objectiveflickr/ObjectiveFlickr.h>
#import "OPMFlickrPhoto.h"

static NSString * const kFlickrApiKey = @"ac932cae00d8bc909247d6c40a641374";
static NSString * const kFlickrSecret = @"8e24f47e7c68676e";

@interface OPMFlickrAPIManager () <OFFlickrAPIRequestDelegate>

@property (nonatomic, strong) OFFlickrAPIContext *flickrContext;
@property (nonatomic, strong) OFFlickrAPIRequest *flickrRequest;

@end

@implementation OPMFlickrAPIManager

- (instancetype)init
{
    self = [super init];
    if (self) {
        _flickrContext = [[OFFlickrAPIContext alloc] initWithAPIKey:kFlickrApiKey sharedSecret:kFlickrSecret];
        _flickrRequest = [[OFFlickrAPIRequest alloc] initWithAPIContext:self.flickrContext];
        _flickrRequest.delegate = self;
    }
    
    return self;
}

- (void)requestFlickrPhotosForText:(NSString *)text page:(NSInteger)page
{
    NSDictionary *arguments = @{@"per_page" : @"10",
                                @"page" : @(page).stringValue,
                                @"text" : text
                                };
    [self.flickrRequest callAPIMethodWithGET:@"flickr.photos.search"
                                   arguments:arguments];
}

- (void)flickrAPIRequest:(OFFlickrAPIRequest *)request didCompleteWithResponse:(NSDictionary *)response
{
    NSMutableArray *photosArray = [@[] mutableCopy];
    NSDictionary *dataDictionary = response[@"photos"];
    NSArray *photosDictionaryArray = dataDictionary[@"photo"];
    NSNumber *totalPhotos = dataDictionary[@"total"];
    for (NSDictionary *photoDictionary in photosDictionaryArray) {
        OPMFlickrPhoto *photo = [[OPMFlickrPhoto alloc] init];
        photo.photoTitle = photoDictionary[@"title"];
        photo.photoURL = [self.flickrContext photoSourceURLFromDictionary:photoDictionary size:OFFlickrLargeSize];
        [photosArray addObject:photo];
    }
    
    [self.delegate flickrAPIManager:self didReceivePhotos:[photosArray copy] totalPhotos:totalPhotos.integerValue];
}

- (void)flickrAPIRequest:(OFFlickrAPIRequest *)request didFailWithError:(NSError *)error
{
    self.flickrRequest = nil;
}

@end
