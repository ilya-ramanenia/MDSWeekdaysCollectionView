# MDSWeekdaysCollectionView

[![Version](https://img.shields.io/cocoapods/v/MDSWeekdaysCollectionView.svg?style=flat)](http://cocoapods.org/pods/MDSWeekdaysCollectionView)
[![License](https://img.shields.io/cocoapods/l/MDSWeekdaysCollectionView.svg?style=flat)](http://cocoapods.org/pods/MDSWeekdaysCollectionView)
[![Platform](https://img.shields.io/cocoapods/p/MDSWeekdaysCollectionView.svg?style=flat)](http://cocoapods.org/pods/MDSWeekdaysCollectionView)

<img src="https://github.com/JJCOINCWEBDEV/MDSWeekdaysCollectionView/blob/master/gifs/weekdays.gif" alt="Weekdays collection view" width="404" height="720" />
<img src="https://github.com/JJCOINCWEBDEV/MDSWeekdaysCollectionView/blob/master/gifs/weekdayssetup.gif" alt="Installation" width="1068" height="720" />

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

Apple LLVM compiler
iOS 8.0 or higher
ARC

## Installation

MDSWeekdaysCollectionView is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "MDSWeekdaysCollectionView"
```

## Usage

Assign `MDSWeekdaysCollectionViewDelegate` to `weekdaysDelegate` property and receive the following messages:

```objective-c

@optional
- (BOOL)weekdaysCollectionView:(MDSWeekdaysCollectionView *)collectionView shouldSelectWeekday:(NSInteger)weekday;
- (void)weekdaysCollectionView:(MDSWeekdaysCollectionView *)collectionView didSelectWeekdaysMask:(MDSWeekdaysMask)weekdaysMask;
```

## Author

Modus, mod.us

## License

MDSWeekdaysCollectionView is available under the MIT license. See the LICENSE file for more info.
