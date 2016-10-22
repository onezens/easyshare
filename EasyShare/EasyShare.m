//
//  EasyShare.m
//  EasyShare
//
//  Created by wangzhen on 16/10/22.
//  Copyright © 2016年 onezen.cc. All rights reserved.
//

#import "EasyShare.h"
#import "WXApi.h"
#import "WeiboSDK.h"

@implementation EasyShare

#pragma mark - public share method

+ (void)shareImage:(UIImage *)image toPlat:(EasySharePlatType)plat {
    
    switch (plat) {
        case EasySharePlatTypeWeixin:
            [self wxShareImage:image];
            break;
        case EasySharePlatTypeWeibo:
            [self wbShareImage:image];
            break;
        case EasySharePlatTypeQQ:
            [self wbShareImage:image];
            break;
        case EasySharePlatTypeSys:
            [self wbShareImage:image];
            break;
        case EasySharePlatTypeZhiFuBao:
            [self wbShareImage:image];
            break;
        default:
            break;
    }
}

+ (void)shareText:(NSString *)text toPlat:(EasySharePlatType)plat {
    switch (plat) {
        case EasySharePlatTypeWeixin:
            [self wxShareText:text];
            break;
        case EasySharePlatTypeWeibo:
            [self wbShareText:text];
            break;
        case EasySharePlatTypeQQ:
            [self wbShareText:text];
            break;
        case EasySharePlatTypeSys:
            [self wbShareText:text];
            break;
        case EasySharePlatTypeZhiFuBao:
            [self wbShareText:text];
            break;
        default:
            break;
    }
}

+ (void)shareWebWithTitle:(NSString *)title desc:(NSString *)desc thumbImage:(UIImage *)image url:(NSString *)url toPlat:(EasySharePlatType)plat {
    
    switch (plat) {
        case EasySharePlatTypeWeixin:
            [self wxShareWebWithTitle:title desc:desc thumbImage:image url:url];
            break;
        case EasySharePlatTypeWeibo:
            [self wbShareWebWithTitle:title desc:desc thumbImage:image url:url];
            break;
        case EasySharePlatTypeQQ:
            [self wbShareImage:image];
            break;
        case EasySharePlatTypeSys:
            [self wbShareImage:image];
            break;
        case EasySharePlatTypeZhiFuBao:
            [self wbShareImage:image];
            break;
        default:
            break;
    }
}

+ (void)shareMusicWithTitle:(NSString *)title desc:(NSString *)desc thumbImage:(UIImage *)image musicURL:(NSString *)musicURL toPlat:(EasySharePlatType)plat{
    switch (plat) {
        case EasySharePlatTypeWeixin:
            [self wxShareMusicWithTitle:title desc:desc thumbImage:image musicURL:musicURL];
            break;
        case EasySharePlatTypeWeibo:
            [self wbShareMusicWithTitle:title desc:desc thumbImage:image musicURL:musicURL];
            break;
        case EasySharePlatTypeQQ:
            [self wbShareImage:image];
            break;
        case EasySharePlatTypeSys:
            [self wbShareImage:image];
            break;
        case EasySharePlatTypeZhiFuBao:
            [self wbShareImage:image];
            break;
        default:
            break;
    }
}

+ (void)shareVideoWithTitle:(NSString *)title desc:(NSString *)desc thumbImage:(UIImage *)image videoURL:(NSString *)videoURL toPlat:(EasySharePlatType)plat{
    switch (plat) {
        case EasySharePlatTypeWeixin:
            [self wxShareVideoWithTitle:title desc:desc thumbImage:image videoURL:videoURL];
            break;
        case EasySharePlatTypeWeibo:
            [self wbShareWebWithTitle:title desc:desc thumbImage:image url:videoURL];
            break;
        case EasySharePlatTypeQQ:
            [self wbShareImage:image];
            break;
        case EasySharePlatTypeSys:
            [self wbShareImage:image];
            break;
        case EasySharePlatTypeZhiFuBao:
            [self wbShareImage:image];
            break;
        default:
            break;
    }
}


#pragma mark - weibo

+ (void)wbShareWebWithTitle:(NSString *)title desc:(NSString *)desc thumbImage:(UIImage *)image url:(NSString *)url {
    
    WBMessageObject *message = [WBMessageObject message];
    WBWebpageObject *webpage = [WBWebpageObject object];
    webpage.objectID = @"identifier1";
    webpage.title = title;
    webpage.description = desc;
    webpage.thumbnailData = UIImageJPEGRepresentation(image, 0.8);
    webpage.webpageUrl = url;
    message.mediaObject = webpage;
    
    WBAuthorizeRequest *authRequest = [WBAuthorizeRequest request];
    authRequest.redirectURI = @"http://www.sina.com";
    authRequest.scope = @"all";
    
    WBSendMessageToWeiboRequest *request = [WBSendMessageToWeiboRequest requestWithMessage:message authInfo:authRequest access_token:nil];
    [WeiboSDK sendRequest:request];
    
}

+ (void)wbShareText:(NSString *)text {
    
    WBAuthorizeRequest *authRequest = [WBAuthorizeRequest request];
    authRequest.redirectURI = @"http://www.sina.com";
    authRequest.scope = @"all";
    
    WBMessageObject *message = [WBMessageObject message];
    message.text = text;
    
    
    WBSendMessageToWeiboRequest *request = [WBSendMessageToWeiboRequest requestWithMessage:message authInfo:authRequest access_token:nil];
    request.userInfo = @{@"ShareMessageFrom": @"SendMessageToWeiboViewController",
                         @"Other_Info_1": [NSNumber numberWithInt:123],
                         @"Other_Info_2": @[@"obj1", @"obj2"],
                         @"Other_Info_3": @{@"key1": @"obj1", @"key2": @"obj2"}};
    //    request.shouldOpenWeiboAppInstallPageIfNotInstalled = NO;
    [WeiboSDK sendRequest:request];
}

+ (void)wbShareVideoWithTitle:(NSString *)title desc:(NSString *)desc thumbImage:(UIImage *)image videoURL:(NSString *)videoURL {
    
}

+ (void)wbShareMusicWithTitle:(NSString *)title desc:(NSString *)desc thumbImage:(UIImage *)image musicURL:(NSString *)musicURL {
    
}

+ (void)wbShareToPrivateMessage {
    
    WBMessageObject *message = [WBMessageObject message];
    WBWebpageObject *webpage = [WBWebpageObject object];
    webpage.objectID = @"";
    webpage.title = NSLocalizedString(@"分享网页标题", nil);
    webpage.description = [NSString stringWithFormat:NSLocalizedString(@"分享网页内容简介-%.0f", nil), [[NSDate date] timeIntervalSince1970]];
    webpage.thumbnailData = UIImagePNGRepresentation([UIImage imageNamed:@"fengjing_thumb"]);
    webpage.webpageUrl = @"http://tech.sina.com.cn/i/2015-11-19/doc-ifxkwuxx1517374.shtml";
    message.mediaObject = webpage;
    
    WBShareMessageToContactRequest *request = [WBShareMessageToContactRequest requestWithMessage:message];
    request.userInfo = @{@"SendMessageFrom": @"SendMessageToWeiboViewController"};
    [WeiboSDK sendRequest:request];
    
}

+ (void)wbShareImage:(UIImage *)image {
    
    WBAuthorizeRequest *authRequest = [WBAuthorizeRequest request];
    authRequest.redirectURI = @"http://www.sina.com";
    authRequest.scope = @"all";
    
    WBMessageObject *message = [WBMessageObject message];
    WBImageObject *imageObj = [WBImageObject object];
    
    imageObj.imageData = UIImagePNGRepresentation(image);
    message.imageObject = imageObj;
    
    WBSendMessageToWeiboRequest *request = [WBSendMessageToWeiboRequest requestWithMessage:message authInfo:authRequest access_token:nil];
    request.userInfo = @{@"ShareMessageFrom": @"SendMessageToWeiboViewController",
                         @"Other_Info_1": [NSNumber numberWithInt:123],
                         @"Other_Info_2": @[@"obj1", @"obj2"],
                         @"Other_Info_3": @{@"key1": @"obj1", @"key2": @"obj2"}};
    //    request.shouldOpenWeiboAppInstallPageIfNotInstalled = NO;
    [WeiboSDK sendRequest:request];
}


#pragma mark - wexin

+ (void)wxShareWebWithTitle:(NSString *)title desc:(NSString *)desc thumbImage:(UIImage *)image url:(NSString *)url {
    
    WXMediaMessage *message = [WXMediaMessage message];
    message.title = title;
    message.description = desc;
    [message setThumbImage:image];
    
    WXWebpageObject *obj = [WXWebpageObject object];
    obj.webpageUrl = url;
    message.mediaObject = obj;
    
    SendMessageToWXReq *req = [[SendMessageToWXReq alloc] init];
    req.bText = false;
    req.message = message;
    req.scene = WXSceneSession;
    
    [WXApi sendReq:req];
}

+ (void)wxShareText:(NSString *)text {
    
    SendMessageToWXReq *req = [[SendMessageToWXReq alloc] init];
    req.text = text;
    req.bText = true;
    req.scene = WXSceneSession;
    [WXApi sendReq:req];
}

+ (void)wxShareVideoWithTitle:(NSString *)title desc:(NSString *)desc thumbImage:(UIImage *)image videoURL:(NSString *)videoURL{
    
    WXMediaMessage *message = [WXMediaMessage message];
    message.title = title;
    message.description = desc;
    [message setThumbImage:image];
    
    WXVideoObject *obj = [WXVideoObject object];
    obj.videoUrl = videoURL;
    obj.videoLowBandUrl = obj.videoUrl;
    message.mediaObject = obj;
    
    SendMessageToWXReq *req = [[SendMessageToWXReq alloc] init];
    req.bText = false;
    req.message = message;
    req.scene = WXSceneSession;
    
    [WXApi sendReq:req];
}

+ (void)wxShareMusicWithTitle:(NSString *)title desc:(NSString *)desc thumbImage:(UIImage *)image musicURL:(NSString *)musicURL{
    
    WXMediaMessage *message = [WXMediaMessage message];
    message.title = title;
    message.description = desc;
    [message setThumbImage:image];
    
    WXMusicObject *ext = [WXMusicObject object];
    ext.musicUrl = musicURL;
    ext.musicLowBandUrl = ext.musicUrl;
    ext.musicDataUrl = @"";
    ext.musicLowBandDataUrl = @"";
    message.mediaObject = ext;
    
    SendMessageToWXReq *req = [[SendMessageToWXReq alloc] init];
    req.bText = false;
    req.message = message;
    req.scene = WXSceneSession;
    
    [WXApi sendReq:req];
    
}

+ (void)wxShareImage:(UIImage *)image {
    
    WXMediaMessage *message = [WXMediaMessage message];
    [message setThumbImage:image]; // 缩略图 大小不能超过32K
    WXImageObject *ext = [WXImageObject object];
    ext.imageData  = UIImagePNGRepresentation([UIImage imageNamed:@"fengjing"]);
    message.mediaObject = ext;
    SendMessageToWXReq *req = [[SendMessageToWXReq alloc] init];
    req.bText   = NO;
    req.message = message;
    req.scene   = WXSceneSession;
    
    [WXApi sendReq:req];
}


@end
