//  github: https://github.com/MakeZL/MLSelectPhoto
//  author: @email <120886865@qq.com>
//  
//  ViewController.m
//  MLSelectPhoto
//
//  Created by 张磊 on 15/4/22.
//  Copyright (c) 2015年 com.zixue101.www. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (strong,nonatomic) NSArray *examples;
@end

@implementation ViewController

- (NSArray *)examples{
    return @[
             @"Multiple choice Photo",
             @"Multiple choice Photo Limit 5",
             @"Records of gravity Multiple choice Photo",
             @"Multiple choice video",
             ];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"MLSelectPhoto";
    // register cell.
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    // delete most tableView separateLine.
    self.tableView.tableFooterView = [[UITableViewHeaderFooterView alloc] init];
}

#pragma mark - <UITableViewDataSource>
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.examples.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.textLabel.text = self.examples[indexPath.row];
    return cell;
}

#pragma mark - <UITableViewDelegate>
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    // push Example vc.
    [self.navigationController pushViewController:[[NSClassFromString([NSString stringWithFormat:@"Example%ldViewController",indexPath.row+1]) alloc] init] animated:YES];
}
@end
