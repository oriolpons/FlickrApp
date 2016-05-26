# FlickrApp

### Installation with CocoaPods

[CocoaPods](http://cocoapods.org) is a dependency manager for Objective-C, which automates and simplifies the process of using 3rd-party libraries like SBPickerSelector in your projects.

```ruby
pod install
```
### Architecture

I used a typical iPhone Application architecture MVC, but also implemented MVVM, with a ViewModel (OPMViewModel) binded to the ViewController (OPMViewController).
For the MWPhotoBrowser library, I created a wrapper OPMPhotoBrowserViewController, which implements MWPhotoBrowserDelegate and converts the OPMFlickrPhoto models into MWPhoto that uses MWPhotoBrowser. Also created a Manager for the objectiveflickr library (OPMFlickrAPIManager), so I encapsulated all the objectiveflickr library in that class.

### Dependencies
* 'SDWebImage' : Used to load the images received from flickr
* 'objectiveflickr' : Used for the flickr requests
* 'SBSearchBar' : Used for the search bar
* 'MWPhotoBrowser' : Used to show the photo gallery
* 'DZNEmptyDataSet' : Used to show a info text when the request has no results
