//
//  ViewController.m
//  FlickrApp
//
//  Created by ORIOL PONS on 21/5/16.
//  Copyright © 2016 Oriol Pons. All rights reserved.
//

#import "OPMViewController.h"
#import "SBSearchBar.h"
#import "OPMFlickrPhoto.h"
#import "OPMFlickrTableViewCell.h"
#import "OPMPhotoBrowserViewController.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "UIScrollView+EmptyDataSet.h"
#import "OPMViewModel.h"

@interface OPMViewController () <SBSearchBarDelegate, UITableViewDelegate, UITableViewDataSource, DZNEmptyDataSetSource, OPMViewModelDelegate>

@property (nonatomic, strong) SBSearchBar *searchBar;
@property (nonatomic, strong) UITableView *flickrTableView;
@property (nonatomic, strong) OPMViewModel *viewModel;

@end

@implementation OPMViewController

- (instancetype)initWithViewModel:(OPMViewModel *)viewModel
{
    self = [super init];
    if (self) {
        _viewModel = viewModel;
        _viewModel.delegate = self;
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self configureLayout];
}

- (void)configureLayout
{
    [self showTextBar];
    [self showTableView];
}

- (void)showTextBar
{
    self.searchBar = [[SBSearchBar alloc] initWithFrame:CGRectMake(0, self.navigationController.navigationBar.frame.size.height+20, 200, 35)];
    self.title = @"Philips";
    self.searchBar.delegate = self;
    self.searchBar.lensImage = [UIImage imageNamed:@"ic_lens"];
    self.searchBar.cancelButtonImage = [UIImage imageNamed:@"button_clear"];
    
    [self.view addSubview:self.searchBar];
}

- (void)showTableView
{
    self.flickrTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, self.searchBar.frame.origin.y + self.searchBar.frame.size.height, self.view.frame.size.width, self.view.frame.size.height - (self.searchBar.frame.origin.y + self.searchBar.frame.size.height))];
    [self.view addSubview:self.flickrTableView];
    self.flickrTableView.delegate = self;
    self.flickrTableView.dataSource = self;
    self.flickrTableView.emptyDataSetSource = self;
    [self.flickrTableView registerNib:[UINib nibWithNibName:NSStringFromClass([OPMFlickrTableViewCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([OPMFlickrTableViewCell class])];
}

#pragma mark - UITableViewDataSource methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.viewModel.photos.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    OPMFlickrTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([OPMFlickrTableViewCell class]) forIndexPath:indexPath];

    OPMFlickrPhoto *photo = self.viewModel.photos[indexPath.row];
    cell.titleLabel.text = photo.photoTitle;
    [cell.imageThumbnailView sd_setImageWithURL:photo.photoURL placeholderImage:[UIImage imageNamed:@"placeholder_image"]];

    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == self.viewModel.photos.count - 2 && !self.viewModel.hasReachedLastPage) {
        [self.viewModel requestPhotosForText:self.searchBar.text nextPage:YES resetData:NO];
    }
}

#pragma mark - UITableViewDelegate methods
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    OPMPhotoBrowserViewController *photoBrowserViewController = [[OPMPhotoBrowserViewController alloc] initWithPhotos:self.viewModel.photos defaultSelectedPhotoAtIndex:indexPath.row];

    [self.navigationController pushViewController:photoBrowserViewController animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [OPMFlickrTableViewCell preferredHeight];
}

#pragma mark - DZNEmptyDataSet methods

- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView
{
    if (self.searchBar.text.length != 0) {
        return [[NSAttributedString alloc] initWithString:@"No results found" attributes:nil];
    }
    
    return nil;
}

#pragma mark - SBSearchBar delegate methods

- (void)SBSearchBarSearchButtonClicked:(SBSearchBar *)searchBar
{
    [self.viewModel requestPhotosForText:self.searchBar.text nextPage:NO resetData:YES];
}

#pragma mark - OPMViewModelDelegate

- (void)refreshUI
{
    [self.flickrTableView reloadData];
}

@end
