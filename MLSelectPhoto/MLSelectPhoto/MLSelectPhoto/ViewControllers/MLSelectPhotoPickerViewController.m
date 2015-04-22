//
//  PickerViewController.m
//  ZLAssetsPickerDemo
//
//  Created by 张磊 on 14-11-11.
//  Copyright (c) 2014年 com.zixue101.www. All rights reserved.
//

#import "MLSelectPhotoPickerViewController.h"
#import "MLSelectPhoto.h"

@interface MLSelectPhotoPickerViewController ()
@property (nonatomic , weak) MLSelectPhotoPickerGroupViewController *groupVc;
@end

@implementation MLSelectPhotoPickerViewController

#pragma mark - Life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self addNotification];
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - init Action
- (void) createNavigationController{
    MLSelectPhotoPickerGroupViewController *groupVc = [[MLSelectPhotoPickerGroupViewController alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:groupVc];
    nav.view.frame = self.view.bounds;
    
    UINavigationController *rootVc = (UINavigationController *)[[UIApplication sharedApplication].keyWindow rootViewController];
                            
    if ([rootVc isKindOfClass:[UINavigationController class]]) {
        [nav.navigationBar setValue:[rootVc.navigationBar valueForKeyPath:@"barTintColor"] forKeyPath:@"barTintColor"];
        [nav.navigationBar setTintColor:rootVc.navigationBar.tintColor];
        [nav.navigationBar setTitleTextAttributes:rootVc.navigationBar.titleTextAttributes];
        
    }else{
        [nav.navigationBar setValue:UIColorFromRGB(0x2f3535) forKeyPath:@"barTintColor"];
        [nav.navigationBar setTintColor:UIColorFromRGB(0xd5d5d5)];
        [nav.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:UIColorFromRGB(0xd5d5d5)}];
    }
    [self addChildViewController:nav];
    [self.view addSubview:nav.view];
    self.groupVc = groupVc;
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        [self createNavigationController];
    }
    return self;
}

- (void)setSelectPickers:(NSArray *)selectPickers{
    _selectPickers = selectPickers;
    self.groupVc.selectAsstes = selectPickers;
}

- (void)setStatus:(PickerViewShowStatus)status{
    _status = status;
    self.groupVc.status = status;
}

- (void)setMinCount:(NSInteger)minCount{
    if (minCount <= 0) return;
    _minCount = minCount;
    self.groupVc.minCount = minCount;
}

#pragma mark - 展示控制器
- (void)show{
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    [[[[UIApplication sharedApplication].windows lastObject] rootViewController] presentViewController:self animated:YES completion:nil];
}

- (void) addNotification{
    // 监听异步done通知
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(done:) name:PICKER_TAKE_DONE object:nil];
    });
}

- (void) done:(NSNotification *)note{
    NSArray *selectArray =  note.userInfo[@"selectAssets"];
    dispatch_async(dispatch_get_main_queue(), ^{
        if ([self.delegate respondsToSelector:@selector(pickerViewControllerDoneAsstes:)]) {
            [self.delegate pickerViewControllerDoneAsstes:selectArray];
        }else if (self.callBack){
            self.callBack(selectArray);
        }
        [self dismissViewControllerAnimated:YES completion:nil];
    });
}

- (void)setDelegate:(id<ZLPhotoPickerViewControllerDelegate>)delegate{
    _delegate = delegate;
    self.groupVc.delegate = delegate;
}
@end
