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

#pragma mark - weibo

- (void)wbShareWeb {
    
    WBMessageObject *message = [WBMessageObject message];
    WBWebpageObject *webpage = [WBWebpageObject object];
    webpage.objectID = @"identifier1";
    webpage.title = NSLocalizedString(@"分享网页标题", nil);
    webpage.description = [NSString stringWithFormat:@"分享网页描述234234"];
    webpage.thumbnailData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"image_2" ofType:@"jpg"]];
    webpage.webpageUrl = @"http://music.baidu.com/song/1175705";
    message.mediaObject = webpage;
    
    WBAuthorizeRequest *authRequest = [WBAuthorizeRequest request];
    authRequest.redirectURI = @"http://www.sina.com";
    authRequest.scope = @"all";
    
    WBSendMessageToWeiboRequest *request = [WBSendMessageToWeiboRequest requestWithMessage:message authInfo:authRequest access_token:nil];
    [WeiboSDK sendRequest:request];
    
}

- (void)wbShareText {
    
    WBAuthorizeRequest *authRequest = [WBAuthorizeRequest request];
    authRequest.redirectURI = @"http://www.sina.com";
    authRequest.scope = @"all";
    
    WBMessageObject *message = [WBMessageObject message];
    message.text = NSLocalizedString(@"测试通过WeiboSDK发送文字到微博!", nil);
    
    
    WBSendMessageToWeiboRequest *request = [WBSendMessageToWeiboRequest requestWithMessage:message authInfo:authRequest access_token:nil];
    request.userInfo = @{@"ShareMessageFrom": @"SendMessageToWeiboViewController",
                         @"Other_Info_1": [NSNumber numberWithInt:123],
                         @"Other_Info_2": @[@"obj1", @"obj2"],
                         @"Other_Info_3": @{@"key1": @"obj1", @"key2": @"obj2"}};
    //    request.shouldOpenWeiboAppInstallPageIfNotInstalled = NO;
    [WeiboSDK sendRequest:request];
}

- (void)wbShareVideo {
    
}

- (void)wbShareMusic {
    
}

- (void)wbShareToPrivateMessage {
    
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

- (void)wbShareImage {
    
    WBAuthorizeRequest *authRequest = [WBAuthorizeRequest request];
    authRequest.redirectURI = @"http://www.sina.com";
    authRequest.scope = @"all";
    
    WBMessageObject *message = [WBMessageObject message];
    WBImageObject *image = [WBImageObject object];
    
    image.imageData = UIImagePNGRepresentation([UIImage imageNamed:@"fengjing"]);
    message.imageObject = image;
    
    WBSendMessageToWeiboRequest *request = [WBSendMessageToWeiboRequest requestWithMessage:message authInfo:authRequest access_token:nil];
    request.userInfo = @{@"ShareMessageFrom": @"SendMessageToWeiboViewController",
                         @"Other_Info_1": [NSNumber numberWithInt:123],
                         @"Other_Info_2": @[@"obj1", @"obj2"],
                         @"Other_Info_3": @{@"key1": @"obj1", @"key2": @"obj2"}};
    //    request.shouldOpenWeiboAppInstallPageIfNotInstalled = NO;
    [WeiboSDK sendRequest:request];
}


#pragma mark - wexin

- (void)wxShareWeb {
    
    WXMediaMessage *message = [WXMediaMessage message];
    message.title = @"微信网页分享标题";
    message.description = @"微信网页分享描述在这里";
    [message setThumbImage:[UIImage imageNamed:@"fengjing_thumb"]];
    
    WXWebpageObject *obj = [WXWebpageObject object];
    obj.webpageUrl = @"http://www.wackosix.cn";
    message.mediaObject = obj;
    
    SendMessageToWXReq *req = [[SendMessageToWXReq alloc] init];
    req.bText = false;
    req.message = message;
    req.scene = WXSceneSession;
    
    [WXApi sendReq:req];
}

- (void)wxShareText {
    
    SendMessageToWXReq *req = [[SendMessageToWXReq alloc] init];
    req.text = @"微信分享文字测试。微信分享文字测试。微信分享文字测试。微信分享文字测试。";
    req.bText = true;
    req.scene = WXSceneSession;
    [WXApi sendReq:req];
}

- (void)wxShareVideo {
    
    WXMediaMessage *message = [WXMediaMessage message];
    message.title = @"微信视频分享";
    message.description = @"微信视频分享描述";
    [message setThumbImage:[UIImage imageNamed:@"fengjing_thumb"]];
    
    WXVideoObject *obj = [WXVideoObject object];
    obj.videoUrl = @"http://flv2.bn.netease.com/videolib3/1609/03/JlkHt0155/SD/JlkHt0155-mobile.mp4";
    obj.videoLowBandUrl = obj.videoUrl;
    message.mediaObject = obj;
    
    SendMessageToWXReq *req = [[SendMessageToWXReq alloc] init];
    req.bText = false;
    req.message = message;
    req.scene = WXSceneSession;
    
    [WXApi sendReq:req];
}

- (void)wxShareMusic {
    
    WXMediaMessage *message = [WXMediaMessage message];
    message.title = @"微信音乐分享🎵";
    message.description = @"微信音乐分享描述。微信音乐分享描述。微信音乐分享描述。微信音乐分享描述。微信音乐分享描述。";
    [message setThumbImage:[UIImage imageNamed:@"fengjing_thumb"]];
    
    WXMusicObject *ext = [WXMusicObject object];
    ext.musicUrl = @"http://music.baidu.com/song/1175705";
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

- (void)wxShareImage {
    
    UIImage *image = [UIImage imageNamed:@"fengjing_thumb"];
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
