//  github: https://github.com/MakeZL/MLSelectPhoto
//  author: @email <120886865@qq.com>
//
//  PickerGroupTableViewCell.m
//  ZLAssetsPickerDemo
//
//  Created by 张磊 on 14-11-13.
//  Copyright (c) 2014年 com.zixue101.www. All rights reserved.
//

#import "MLSelectPhotoPickerGroupTableViewCell.h"
#import "MLSelectPhotoPickerGroup.h"
#import <AssetsLibrary/AssetsLibrary.h>

@interface MLSelectPhotoPickerGroupTableViewCell ()
@property (weak, nonatomic) UIImageView *groupImageView;
@property (weak, nonatomic) UILabel *groupNameLabel;
@property (weak, nonatomic) UILabel *groupPicCountLabel;
@end

@implementation MLSelectPhotoPickerGroupTableViewCell

- (UILabel *)groupNameLabel{
    if (!_groupNameLabel) {
        UILabel *groupNameLabel = [[UILabel alloc] init];
        groupNameLabel.frame = CGRectMake(85, 15, self.frame.size.width - 100, 20);
        [self.contentView addSubview:_groupNameLabel = groupNameLabel];
    }
    return _groupNameLabel;
}

- (UIImageView *)groupImageView{
    if (!_groupImageView) {
        UIImageView *groupImageView = [[UIImageView alloc] init];
        groupImageView.contentMode = UIViewContentModeScaleAspectFit;
        groupImageView.frame = CGRectMake(5, 5, 70, 70);
        [self.contentView addSubview:_groupImageView = groupImageView];
    }
    return _groupImageView;
}

- (UILabel *)groupPicCountLabel{
    if (!_groupPicCountLabel) {
        UILabel *groupPicCountLabel = [[UILabel alloc] init];
        groupPicCountLabel.frame = CGRectMake(85, 35, self.frame.size.width - 100, 20);
        groupPicCountLabel.font = [UIFont systemFontOfSize:13];
        groupPicCountLabel.textColor = [UIColor lightGrayColor];
        [self.contentView addSubview:_groupPicCountLabel = groupPicCountLabel];
    }
    return _groupPicCountLabel;
}

- (void)setGroup:(MLSelectPhotoPickerGroup *)group{
    _group = group;
    
    self.groupNameLabel.text = group.groupName;
    self.groupImageView.image = group.thumbImage;
    self.groupPicCountLabel.text = [NSString stringWithFormat:@"(%ld)",group.assetsCount];
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        
        
    }
    return self;
}

@end
