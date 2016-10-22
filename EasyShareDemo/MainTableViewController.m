//
//  MainTableViewController.m
//  EasyShare
//
//  Created by wangzhen on 16/10/21.
//  Copyright © 2016年 onezen.cc. All rights reserved.
//

#import "MainTableViewController.h"


@interface MainTableViewController ()

@property (nonatomic, strong) NSArray *dataArr;

@end

@implementation MainTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadData];
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(back)];
}

- (void)loadData {
    
    self.dataArr = [NSArray array];
    if (self.controllerType == EasySharePlatform) {
        self.dataArr = @[@"微信分享", @"微博分享", @"QQ分享", @"系统分享", @"支付宝分享"];
    }else if (self.controllerType == EasyShareStyle) {
        self.dataArr =  @[@"图片分享", @"音乐分享", @"视频分享", @"文本分享", @"网页分享"];
    }
    [self.tableView reloadData];
   
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *cellID = @"EasyShareCellID";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    cell.textLabel.text = self.dataArr[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (self.controllerType == EasySharePlatform) {
        [self jumpPlatformShareStyle:indexPath.row];
    }else {
        [self jumpToShareWithIndex:indexPath.row];
    }
}
- (void)jumpToShareWithIndex:(NSInteger)index {
    
}

- (void)jumpPlatformShareStyle:(NSInteger)index {
    MainTableViewController *vc = [[MainTableViewController alloc] init];
    vc.controllerType = EasyShareStyle;
    vc.title = self.dataArr[index];
    if (index == 1 || index == 0) {
        [self.navigationController pushViewController:vc animated:true];
        
    }
}

- (void)back {
    [self.navigationController popViewControllerAnimated:true];
}





@end
