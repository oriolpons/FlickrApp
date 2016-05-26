//
//  OPMFlickrAPIManager.h
//  FlickrApp
//
//  Created by ORIOL PONS on 25/5/16.
//  Copyright © 2016 Oriol Pons. All rights reserved.
//

#import <Foundation/Foundation.h>

@class OPMFlickrPhoto;
@class OPMFlickrAPIManager;

@protocol OPMFlickrAPIDelegate <NSObject>

- (void)flickrAPIManager:(OPMFlickrAPIManager *)flickrAPIManager didReceivePhotos:(NSArray<OPMFlickrPhoto *> *)photos totalPhotos:(NSInteger)totalPhotos;

@end

@interface OPMFlickrAPIManager : NSObject

@property (nonatomic, weak) id<OPMFlickrAPIDelegate>delegate;

- (void)requestFlickrPhotosForText:(NSString *)text page:(NSInteger)page;

@end
