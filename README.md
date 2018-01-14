# GBNoData


## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Code

```Objective-C
UIView *view = [[UIView alloc] initWithFrame:self.view.bounds];
view.backgroundColor = [UIColor yellowColor];
self.tableView.customNoDataView = view;
__weak typeof(self) weakSelf = self;
self.tableView.callBack = ^(UIView *view) {
    [weakSelf.tableView reloadData];
};
```
## Installation

GBNoData is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "GBNoData"
```

## Author

Lucas, gaobo_it@163.com

## License

GBNoData is available under the MIT license. See the LICENSE file for more info.
