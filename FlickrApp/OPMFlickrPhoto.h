//
//  FlickrPhoto.h
//  FlickrApp
//
//  Created by ORIOL PONS on 22/5/16.
//  Copyright © 2016 Oriol Pons. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OPMFlickrPhoto : NSObject

@property (nonatomic, copy) NSString *photoTitle;
@property (nonatomic, copy) NSURL *photoURL;
@property (nonatomic, copy) NSString *photoID;
@property (nonatomic, copy) NSString *owner;
@property (nonatomic, copy) NSString *secret;
@property (nonatomic, copy) NSString *server;
@property (nonatomic, copy) NSString *farm;
@property (nonatomic, assign) BOOL *isPublic;
@property (nonatomic, assign) BOOL *isFriend;
@property (nonatomic, assign) BOOL *isFamily;

@end



