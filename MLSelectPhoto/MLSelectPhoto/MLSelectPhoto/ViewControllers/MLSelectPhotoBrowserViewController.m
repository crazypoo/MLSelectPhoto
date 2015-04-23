//  github: https://github.com/MakeZL/MLSelectPhoto
//  author: @email <120886865@qq.com>
//
//  MLSelectPhotoBrowserViewController.m
//  MLSelectPhoto
//
//  Created by 张磊 on 15/4/23.
//  Copyright (c) 2015年 com.zixue101.www. All rights reserved.
//

#import "MLSelectPhotoBrowserViewController.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import "UIView+MLExtension.h"
#import "MLSelectPhotoPickerBrowserPhotoScrollView.h"
#import "MLSelectPhotoCommon.h"


// 分页控制器的高度
static NSInteger const ZLPickerPageCtrlH = 25;
static NSInteger ZLPickerColletionViewPadding = 20;
static NSString *_cellIdentifier = @"collectionViewCell";

@interface MLSelectPhotoBrowserViewController () <UIScrollViewDelegate,ZLPhotoPickerPhotoScrollViewDelegate,UICollectionViewDelegateFlowLayout,UICollectionViewDataSource,UICollectionViewDelegate>

// 控件
@property (strong,nonatomic) UIButton         *deleleBtn;
@property (weak,nonatomic) UIButton         *backBtn;
@property (weak,nonatomic) UICollectionView *collectionView;

// 标记View
@property (strong,nonatomic) UIToolbar *toolBar;
@property (weak,nonatomic) UILabel *makeView;
@property (strong,nonatomic) UIButton *doneBtn;

@end

@implementation MLSelectPhotoBrowserViewController

#pragma mark - getter
#pragma mark collectionView
- (UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.minimumLineSpacing = ZLPickerColletionViewPadding;
        flowLayout.itemSize = self.view.ml_size;
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        
        UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.view.ml_width + ZLPickerColletionViewPadding,self.view.ml_height) collectionViewLayout:flowLayout];
        collectionView.showsHorizontalScrollIndicator = NO;
        collectionView.showsVerticalScrollIndicator = NO;
        collectionView.pagingEnabled = YES;
        collectionView.dataSource = self;
        collectionView.backgroundColor = [UIColor clearColor];
        collectionView.bounces = YES;
        collectionView.delegate = self;
        [collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:_cellIdentifier];
        
        [self.view addSubview:collectionView];
        self.collectionView = collectionView;
        
        _collectionView.translatesAutoresizingMaskIntoConstraints = NO;
        [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[_collectionView]-x-|" options:0 metrics:@{@"x":@(-20)} views:@{@"_collectionView":_collectionView}]];
        [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[_collectionView]-0-|" options:0 metrics:nil views:@{@"_collectionView":_collectionView}]];
        
        // 初始化底部ToorBar
        [self setupToorBar];
    }
    return _collectionView;
}

#pragma mark Get View
#pragma mark makeView 红点标记View
- (UILabel *)makeView{
    if (!_makeView) {
        UILabel *makeView = [[UILabel alloc] init];
        makeView.textColor = [UIColor whiteColor];
        makeView.textAlignment = NSTextAlignmentCenter;
        makeView.font = [UIFont systemFontOfSize:13];
        makeView.frame = CGRectMake(-5, -5, 20, 20);
        makeView.hidden = YES;
        makeView.layer.cornerRadius = makeView.frame.size.height / 2.0;
        makeView.clipsToBounds = YES;
        makeView.backgroundColor = [UIColor redColor];
        [self.view addSubview:makeView];
        self.makeView = makeView;
        
    }
    return _makeView;
}

- (UIButton *)doneBtn{
    if (!_doneBtn) {
        UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        rightBtn.enabled = YES;
        rightBtn.titleLabel.font = [UIFont systemFontOfSize:17];
        rightBtn.frame = CGRectMake(0, 0, 45, 45);
        [rightBtn setTitle:@"完成" forState:UIControlStateNormal];
        [rightBtn addTarget:self action:@selector(done) forControlEvents:UIControlEventTouchUpInside];
        [rightBtn addSubview:self.makeView];
        self.doneBtn = rightBtn;
    }
    return _doneBtn;
}

#pragma mark deleleBtn
- (UIButton *)deleleBtn{
    if (!_deleleBtn) {
        UIButton *deleleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        deleleBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [deleleBtn setImage:[UIImage imageNamed:MLSelectPhotoSrcName(@"AssetsPickerChecked")] forState:UIControlStateNormal];
        deleleBtn.frame = CGRectMake(0, 0, 30, 30);
        [deleleBtn addTarget:self action:@selector(deleteAsset) forControlEvents:UIControlEventTouchUpInside];
        self.deleleBtn = deleleBtn;
    }
    return _deleleBtn;
}

- (void)setPhotos:(NSArray *)photos{
    _photos = photos;
    
    self.makeView.text = [NSString stringWithFormat:@"%ld",photos.count];
    self.makeView.hidden = !photos.count;
    [self reloadData];
}

#pragma mark - Life cycle
- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.deleleBtn];
    self.view.backgroundColor = [UIColor blackColor];
    
}

#pragma mark -初始化底部ToorBar
- (void) setupToorBar{
    UIToolbar *toorBar = [[UIToolbar alloc] init];
    toorBar.barTintColor = UIColorFromRGB(0x333333);
    toorBar.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:toorBar];
    self.toolBar = toorBar;
    
    NSDictionary *views = NSDictionaryOfVariableBindings(toorBar);
    NSString *widthVfl =  @"H:|-0-[toorBar]-0-|";
    NSString *heightVfl = @"V:[toorBar(44)]-0-|";
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:widthVfl options:0 metrics:0 views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:heightVfl options:0 metrics:0 views:views]];
    
    // 左视图 中间距 右视图
    UIBarButtonItem *fiexItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:self.doneBtn];
    
    toorBar.items = @[fiexItem,rightItem];
    
}

- (void)deleteAsset{
    
}

#pragma mark - reloadData
- (void) reloadData{
    
    [self.collectionView reloadData];
    
    // 添加自定义View
    [self setPageLabelPage:self.currentPage];
    if (self.currentPage >= 0) {
        CGFloat attachVal = 0;
        if (self.currentPage == self.photos.count - 1 && self.currentPage > 0) {
            attachVal = ZLPickerColletionViewPadding;
        }
        
        self.collectionView.ml_x = -attachVal;
        self.collectionView.contentOffset = CGPointMake(self.currentPage * self.collectionView.ml_width, 0);
    }
    
}

#pragma mark - <UICollectionViewDataSource>
- (NSInteger) numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.photos.count;
}

- (UICollectionViewCell *) collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:_cellIdentifier forIndexPath:indexPath];
    
    if (self.photos.count) {
        cell.backgroundColor = [UIColor clearColor];
        MLSelectPhotoAssets *photo = self.photos[indexPath.item]; //[self.dataSource photoBrowser:self photoAtIndex:indexPath.item];
        
        if([[cell.contentView.subviews lastObject] isKindOfClass:[UIView class]]){
            [[cell.contentView.subviews lastObject] removeFromSuperview];
        }
        
        UIView *scrollBoxView = [[UIView alloc] init];
        scrollBoxView.frame = [UIScreen mainScreen].bounds;
        scrollBoxView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        [cell.contentView addSubview:scrollBoxView];
        
        MLSelectPhotoPickerBrowserPhotoScrollView *scrollView =  [[MLSelectPhotoPickerBrowserPhotoScrollView alloc] init];
        scrollView.sheet = self.sheet;
        scrollView.backgroundColor = [UIColor clearColor];
        // 为了监听单击photoView事件
        scrollView.frame = [UIScreen mainScreen].bounds;
        scrollView.photoScrollViewDelegate = self;
        scrollView.photo = photo;
        
        [scrollBoxView addSubview:scrollView];
        scrollView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        
        if (self.photos.count == 1) {
            scrollView.ml_x = 0;
        }else if (self.currentPage == self.photos.count - 1 && scrollView.ml_x >= 0 && !collectionView.isDragging) {
            scrollView.ml_x = -ZLPickerColletionViewPadding;
        }
    }
    return cell;
}
// 单击调用
- (void) pickerPhotoScrollViewDidSingleClick:(MLSelectPhotoPickerBrowserPhotoScrollView *)photoScrollView{
    self.navigationController.navigationBar.hidden = !self.navigationController.navigationBar.isHidden;
    self.toolBar.hidden = !self.toolBar.isHidden;
}
#pragma mark - <UIScrollViewDelegate>
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGRect tempF = self.collectionView.frame;
    NSInteger currentPage = (NSInteger)((scrollView.contentOffset.x / scrollView.ml_width) + 0.5);
    if (tempF.size.width < [UIScreen mainScreen].bounds.size.width){
        tempF.size.width = [UIScreen mainScreen].bounds.size.width;
    }
    
    if ((currentPage < self.photos.count -1) || self.photos.count == 1) {
        tempF.origin.x = 0;
    }else{
        tempF.origin.x = -ZLPickerColletionViewPadding;
    }
    self.collectionView.frame = tempF;
}

- (void)done{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [[NSNotificationCenter defaultCenter] postNotificationName:PICKER_TAKE_DONE object:nil userInfo:@{@"selectAssets":self.photos}];
    });
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)setPageLabelPage:(NSInteger)page{
    self.title = [NSString stringWithFormat:@"%ld / %ld",page + 1, self.photos.count];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    NSInteger currentPage = (NSInteger)scrollView.contentOffset.x / (scrollView.ml_width - ZLPickerColletionViewPadding);
    if (currentPage == self.photos.count - 1 && currentPage != self.currentPage && [[[UIDevice currentDevice] systemVersion] doubleValue] >= 8.0) {
        self.collectionView.contentOffset = CGPointMake(self.collectionView.contentOffset.x, self.collectionView.contentOffset.y);
    }
    self.currentPage = currentPage;
    [self setPageLabelPage:currentPage];
}

@end