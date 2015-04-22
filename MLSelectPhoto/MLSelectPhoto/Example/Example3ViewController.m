//
//  Example3ViewController.m
//  MLSelectPhoto
//
//  Created by 张磊 on 15/4/22.
//  Copyright (c) 2015年 com.zixue101.www. All rights reserved.
//

#import "Example3ViewController.h"
#import "ZLPhotoAssets.h"
#import "ZLPhotoPickerAssetsViewController.h"

@interface Example3ViewController () <UITableViewDataSource,UITableViewDelegate>

@property (weak,nonatomic) UITableView *tableView;
@property (nonatomic , strong) NSMutableArray *assets;

@end

@implementation Example3ViewController

#pragma mark - Getter
#pragma mark Get data
- (NSMutableArray *)assets{
    if (!_assets) {
        _assets = [NSMutableArray array];
    }
    return _assets;
}

#pragma mark Get View
- (UITableView *)tableView{
    if (!_tableView) {
        UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        tableView.backgroundColor = [UIColor whiteColor];
        tableView.dataSource = self;
        tableView.delegate = self;
        tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
        [self.view addSubview:tableView];
        self.tableView = tableView;
    }
    return _tableView;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    // 初始化UI
    [self setupButtons];
    [self tableView];
}

- (void) setupButtons{
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"selectPhotos" style:UIBarButtonItemStyleDone target:self action:@selector(selectPhotos)];
}

#pragma mark - 选择相册
- (void)selectPhotos {
    // 创建控制器
    ZLPhotoPickerViewController *pickerVc = [[ZLPhotoPickerViewController alloc] init];
    // 默认显示相册里面的内容SavePhotos
    pickerVc.selectPickers = self.assets;
    pickerVc.minCount = 9;
    pickerVc.status = PickerViewShowStatusCameraRoll;
    [pickerVc show];
    __weak typeof(self) weakSelf = self;
    pickerVc.callBack = ^(NSArray *assets){
        [weakSelf.assets addObjectsFromArray:assets];
        [weakSelf.tableView reloadData];
    };
}

#pragma mark - <UITableViewDataSource>
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.assets.count;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    // 判断类型来获取Image
    ZLPhotoAssets *asset = self.assets[indexPath.row];
    if ([asset isKindOfClass:[ZLPhotoAssets class]]) {
        cell.imageView.image = asset.thumbImage;
    }else if([asset isKindOfClass:[UIImage class]]){
        cell.imageView.image = (UIImage *)asset;
    }
    
    return cell;
}

#pragma mark - <UITableViewDelegate>
- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 95;
}

@end
