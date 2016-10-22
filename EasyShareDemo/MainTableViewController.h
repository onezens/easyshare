//
//  MainTableViewController.h
//  EasyShare
//
//  Created by wangzhen on 16/10/21.
//  Copyright © 2016年 onezen.cc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EasyShare.h"

typedef NS_ENUM(NSUInteger, EasyShareControlerType) {
    EasySharePlatform,
    EasyShareStyle
};


@interface MainTableViewController : UITableViewController

@property (nonatomic, assign) EasyShareControlerType controllerType;
@property (nonatomic, assign) EasySharePlatType platType;

@end
