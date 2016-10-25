//
//  EasyShare.h
//  EasyShare
//
//  Created by wangzhen on 16/10/22.
//  Copyright © 2016年 onezen.cc. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, EasySharePlatType) {
    EasySharePlatTypeWeixin,
    EasySharePlatTypeWeibo,
    EasySharePlatTypeQQ,
    EasySharePlatTypeQQZone,
    EasySharePlatTypeSys,
    EasySharePlatTypeZhiFuBao
};


@interface EasyShare : NSObject

+ (void)shareImage:(UIImage *)image toPlat:(EasySharePlatType)plat;
+ (void)shareText:(NSString *)text toPlat:(EasySharePlatType)plat;
+ (void)shareWebWithTitle:(NSString *)title desc:(NSString *)desc thumbImage:(UIImage *)image url:(NSString *)url toPlat:(EasySharePlatType)plat;
+ (void)shareVideoWithTitle:(NSString *)title desc:(NSString *)desc thumbImage:(UIImage *)image videoURL:(NSString *)videoURL toPlat:(EasySharePlatType)plat;
+ (void)shareMusicWithTitle:(NSString *)title desc:(NSString *)desc thumbImage:(UIImage *)image musicURL:(NSString *)musicURL toPlat:(EasySharePlatType)plat;

+ (void)qqzoneShareLocalVideoWithTitle:(NSString *)title;
+ (void)qqzoneShareLocalImageWithTitle:(NSString *)text;


@end
