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
        self.dataArr = @[@"微信分享", @"微博分享", @"QQ分享", @"QQ空间分享", @"系统分享", @"支付宝分享"];
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
    [tableView deselectRowAtIndexPath:indexPath animated:true];
    if (self.controllerType == EasySharePlatform) {
        [self jumpPlatformShareStyle:indexPath.row];
    }else {
        [self jumpToShareWithIndex:indexPath.row];
    }
}
- (void)jumpToShareWithIndex:(NSInteger)index {
    
    NSString *shareType = self.dataArr[index];
    NSLog(@"%@ --- %@", self.title, shareType);
    if ([shareType isEqualToString:@"图片分享"]) {
        [EasyShare shareImage:[UIImage imageNamed:@"fengjing"] toPlat:self.platType];
    }else if ([shareType isEqualToString:@"文本分享"]){
        [EasyShare shareText:@"文本分享测试" toPlat:self.platType];
    }else if ([shareType isEqualToString:@"网页分享"]){
        [EasyShare shareWebWithTitle:@"网页分享标题" desc:@"网页分享描述网页分享描述网页分享描述" thumbImage:[UIImage imageNamed:@"image_2.jpg"] url:@"https://github.com/onezens/easyshare" toPlat:self.platType];
    }else if ([shareType isEqualToString:@"视频分享"]){
        //http://flv2.bn.netease.com/videolib3/1609/03/JlkHt0155/SD/JlkHt0155-mobile.mp4
        [EasyShare shareVideoWithTitle:@"视频分享title" desc:@"视频分享desc" thumbImage:[UIImage imageNamed:@"image_2.jpg"] videoURL:@"http://www.miaopai.com/show/GZnTEp4dAqVus0jrMnvX4A__.htm" toPlat:self.platType];
    }else if ([shareType isEqualToString:@"音乐分享"]){
        [EasyShare shareMusicWithTitle:@"音乐分享title" desc:@"音乐分享desc" thumbImage:[UIImage imageNamed:@"image_2.jpg"] musicURL:@"http://music.baidu.com/song/1175705" toPlat:self.platType];
    }
    
}

- (void)jumpPlatformShareStyle:(NSInteger)index {

    if (index == 1 || index == 0 || index == 2 || index == 3) {
        MainTableViewController *vc = [[MainTableViewController alloc] init];
        vc.controllerType = EasyShareStyle;
        vc.title = self.dataArr[index];
        vc.platType = index;
        [self.navigationController pushViewController:vc animated:true];
    }
}

- (void)back {
    [self.navigationController popViewControllerAnimated:true];
}

@end
