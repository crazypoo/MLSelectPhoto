//
//  ZLPicker.h
//  ZLAssetsPickerDemo
//
//  Created by 张磊 on 14-12-17.
//  Copyright (c) 2014年 com.zixue101.www. All rights reserved.
//

#ifndef ZLAssetsPickerDemo_ZLPicker_h
#define ZLAssetsPickerDemo_ZLPicker_h

#import "ZLPhotoPickerAssetsViewController.h"
#import "ZLPhotoPickerViewController.h"
#import "ZLPhotoPickerDatas.h"
#import "ZLPhotoPickerCommon.h"
#import "UIView+MLExtension.h"

/**
 *
 使用方法：
 有什么不懂的也可以联系QQ：120886865 (*^__^*) 嘻嘻……
 ZLPhotoPickerViewController:
 Note : (图片相册多选控制器)
 创建控制器
 ZLPhotoPickerViewController *pickerVc = [[ZLPhotoPickerViewController alloc] init];
 // 默认显示相册里面的内容SavePhotos
 pickerVc.status = PickerViewShowStatusCameraRoll;
 // 选择图片的最小数，默认是9张图片
 pickerVc.minCount = 4;
 // 设置代理回调
 pickerVc.delegate = self;
 // 展示控制器
 [pickerVc show];
 
 第一种回调方法：- (void)pickerViewControllerDoneAsstes:(NSArray *)assets
 第二种回调方法pickerVc.callBack = ^(NSArray *assets){
 // TODO 回调结果，可以不用实现代理
 };
 */
#endif
