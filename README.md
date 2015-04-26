# MLSelectPhoto

Custom select photos iOS Library

![image](https://github.com/MakeZL/MLSelectPhoto/blob/master/screenshot.gif)

### CocoaPod
    pod search 'MLSelectPhoto'

### Use
###### import "MLSelectPhotoPickerViewController.h"
    // alloc
    MLSelectPhotoPickerViewController *pickerVc = [[MLSelectPhotoPickerViewController alloc] init];
    // Default Push CameraRoll
    pickerVc.status = PickerViewShowStatusCameraRoll;
    // Limit Count.
    pickerVc.minCount = 9;
    // Push
    [pickerVc show];
    __weak typeof(self) weakSelf = self;
    pickerVc.callBack = ^(NSArray *assets){
    // CallBack or Delegate
        [weakSelf.assets addObjectsFromArray:assets];
        [weakSelf.tableView reloadData];
    }
    

# Contact
@weibo : [我的微博](http://weibo.com/makezl/)
    
# License

MLSelectPhoto is published under MIT License

    Copyright (c) 2015 MakeZL (@MakeZL)
    
    Permission is hereby granted, free of charge, to any person obtaining a copy of
    this software and associated documentation files (the "Software"), to deal in
    the Software without restriction, including without limitation the rights to use,
    copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the
    Software, and to permit persons to whom the Software is furnished to do so,
    subject to the following conditions:
    
    The above copyright notice and this permission notice shall be included in all
    copies or substantial portions of the Software.
    
    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
    IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
    FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
    COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
    IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
    CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
