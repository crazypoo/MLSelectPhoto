//  github: https://github.com/MakeZL/MLSelectPhoto
//  author: @email <120886865@qq.com>
//
//  Example4ViewController.m
//  MLSelectPhoto
//
//  Created by 张磊 on 15/4/22.
//  Copyright (c) 2015年 com.zixue101.www. All rights reserved.
//

#import <MediaPlayer/MediaPlayer.h>
#import "Example4ViewController.h"
#import "MLSelectPhoto.h"

@interface Example4ViewController () <ZLPhotoPickerViewControllerDelegate,UITableViewDataSource,UITableViewDelegate>

@property (weak,nonatomic) UITableView *tableView;
@property (nonatomic , strong) NSMutableArray *assets;
@property (strong, nonatomic) MPMoviePlayerController *moviePlayer;

@end

@implementation Example4ViewController

- (NSMutableArray *)assets{
    if (!_assets) {
        _assets = [NSMutableArray array];
    }
    return _assets;
}

- (UITableView *)tableView{
    if (!_tableView) {
        UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        tableView.backgroundColor = [UIColor whiteColor];
        tableView.dataSource = self;
        tableView.delegate = self;
        tableView.tableFooterView = [[UIView alloc] init];
        tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
        [self.view addSubview:tableView];
        self.tableView = tableView;
        
    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setupButtons];
    [self tableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) setupButtons{
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"selectVideos" style:UIBarButtonItemStyleDone target:self action:@selector(selectVideos)];
}


#pragma mark - select Photo Library
- (void)selectVideos {
    // 创建控制器
    MLSelectPhotoPickerViewController *pickerVc = [[MLSelectPhotoPickerViewController alloc] init];
    // 默认显示相册里面的视频
    // 最多能选9个视频
    pickerVc.minCount = 9;
    pickerVc.status = PickerViewShowStatusVideo;
    [pickerVc show];
    /**
     *
     传值可以用代理，或者用block来接收，以下是block的传值
     __weak typeof(self) weakSelf = self;
     pickerVc.callBack = ^(NSArray *assets){
     weakSelf.assets = assets;
     [weakSelf.tableView reloadData];
     };
     */
}

- (void)pickerViewControllerDoneAsstes:(NSArray *)assets{
    [self.assets addObjectsFromArray:assets];
    [self.tableView reloadData];
}


#pragma mark - <UITableViewDataSource>
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.assets.count;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    // 判断类型来获取Image
    MLSelectPhotoAssets *asset = self.assets[indexPath.row];
    cell.imageView.image = [MLSelectPhotoPickerViewController getImageWithImageObj:asset];
    
    return cell;
}


#pragma mark - <UITableViewDelegate>
- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    MLSelectPhotoAssets *asset = self.assets[indexPath.row];
    if ([asset isKindOfClass:[MLSelectPhotoAssets class]]){
        // 设置视频播放器
        self.moviePlayer = [[MPMoviePlayerController alloc] initWithContentURL:asset.asset.defaultRepresentation.url];
        self.moviePlayer.allowsAirPlay = YES;
        [self.moviePlayer.view setFrame:self.view.frame];
        
        // 将moviePlayer的视图添加到当前视图中
        [self.view addSubview:self.moviePlayer.view];
        // 播放完视频之后，MPMoviePlayerController 将发送
        // MPMoviePlayerPlaybackDidFinishNotification 消息
        // 登记该通知，接到该通知后，调用playVideoFinished:方法
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playVideoFinished:) name:MPMoviePlayerPlaybackDidFinishNotification object:self.moviePlayer];
        
        [self.moviePlayer play];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 95;
}

- (void)playVideoFinished:(NSNotification *)theNotification{
    // 取消监听
    [[NSNotificationCenter defaultCenter]
     removeObserver:self name:MPMoviePlayerPlaybackDidFinishNotification object:self.moviePlayer];
    // 将视频视图从父视图中删除
    [self.moviePlayer.view removeFromSuperview];
}

@end
