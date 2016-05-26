//
//  OPMViewModel.h
//  FlickrApp
//
//  Created by ORIOL PONS on 24/5/16.
//  Copyright © 2016 Oriol Pons. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol OPMViewModelDelegate <NSObject>

- (void)refreshUI;

@end

@interface OPMViewModel : NSObject

@property (nonatomic, copy) NSArray *photos;
@property (nonatomic, weak) id<OPMViewModelDelegate>delegate;
@property (nonatomic, assign) NSUInteger currentPage;

- (void)requestPhotosForText:(NSString *)text nextPage:(BOOL)nextPage resetData:(BOOL)resetData;

- (BOOL)hasReachedLastPage;

@end
