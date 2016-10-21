//
//  MainTableViewController.m
//  EasyShare
//
//  Created by wangzhen on 16/10/21.
//  Copyright © 2016年 onezen.cc. All rights reserved.
//

#import "MainTableViewController.h"

typedef NS_ENUM(NSUInteger, EasyShareControlerType) {
    EasySharePlatform,
    EasyShareStyle
};

@interface MainTableViewController ()

@property (nonatomic, assign) EasyShareControlerType controllerType;
@property (nonatomic, strong) NSArray *dataArr;

@end

@implementation MainTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"分享测试";
    
}

- (void)loadData {
    
    self.dataArr = [NSArray array];
    if (self.controllerType == EasySharePlatform) {
        self.dataArr = @[@"微信分享", @"微博分享", @"QQ分享", @"系统分享", @"支付宝分享"];
    }else if (self.controllerType == EasyShareStyle) {
        self.dataArr =  @[@"图片分享", @"音乐分享", @"视频分享", @"文本分享", @"网页分享"];
    }
    
   
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
    
    return cell;
}


@end
