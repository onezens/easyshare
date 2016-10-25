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
#import <TencentOpenAPI/QQApiInterface.h>

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
            [self qqShareImage:image];
            break;
        case EasySharePlatTypeQQZone:
            [self qqzoneShareImage:image];
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
            [self qqShareText:text];
            break;
        case EasySharePlatTypeQQZone:
            [self qqzoneShareText:text];
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
            [self qqShareWebWithTitle:title desc:desc thumbImage:image url:url];
            break;
        case EasySharePlatTypeQQZone:
            [self qqzoneShareWebWithTitle:title desc:desc thumbImage:image url:url];
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
            [self qqShareMusicWithTitle:title desc:desc thumbImage:image musicURL:musicURL];
            break;
        case EasySharePlatTypeQQZone:
            [self qqzoneShareMusicWithTitle:title desc:desc thumbImage:image musicURL:musicURL];
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
            [self wbShareVideoWithTitle:title desc:desc thumbImage:image videoURL:videoURL];
            break;
        case EasySharePlatTypeQQ:
            [self qqShareVideoWithTitle:title desc:desc thumbImage:image videoURL:videoURL];
            break;
        case EasySharePlatTypeQQZone:
            [self qqzoneShareVideoWithTitle:title desc:desc thumbImage:image videoURL:videoURL];
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

#pragma mark - qqzone

+ (void)qqzoneShareLocalVideoWithTitle:(NSString *)title{
    
    // TODO: 创建一个图片和视频选择的控制器和页面
    QQApiVideoForQZoneObject *video = [QQApiVideoForQZoneObject objectWithAssetURL:nil title:title];
    SendMessageToQQReq *req = [SendMessageToQQReq reqWithContent:video];
    QQApiSendResultCode sent = [QQApiInterface SendReqToQZone:req];
    [self handleSendResult:sent];
    
}
+ (void)qqzoneShareLocalImageWithTitle:(NSString *)text {
    // TODO: 创建一个图片和视频选择的控制器和页面
    QQApiImageArrayForQZoneObject *img = [QQApiImageArrayForQZoneObject objectWithimageDataArray:nil title:text];
    SendMessageToQQReq* req = [SendMessageToQQReq reqWithContent:img];
    QQApiSendResultCode sent = [QQApiInterface SendReqToQZone:req];
    [self handleSendResult:sent];
}



+ (void)qqzoneShareWebWithTitle:(NSString *)title desc:(NSString *)desc thumbImage:(UIImage *)image url:(NSString *)url {
    
    NSData *data = UIImageJPEGRepresentation(image, 1);
    QQApiNewsObject* imgObj = [QQApiNewsObject objectWithURL:[NSURL URLWithString:url] title:title description:desc previewImageData:data];
    [imgObj setTitle:title];
    [imgObj setCflag:kQQAPICtrlFlagQZoneShareOnStart];
    
    SendMessageToQQReq* req = [SendMessageToQQReq reqWithContent:imgObj];
    
    QQApiSendResultCode sent = [QQApiInterface sendReq:req];
    
    [self handleSendResult:sent];
}

+ (void)qqzoneShareText:(NSString *)text {
    
    QQApiImageArrayForQZoneObject *obj = [QQApiImageArrayForQZoneObject objectWithimageDataArray:nil title:text];
    SendMessageToQQReq *req = [SendMessageToQQReq reqWithContent:obj];
    QQApiSendResultCode sent = [QQApiInterface SendReqToQZone:req];
    [self handleSendResult:sent];
}

+ (void)qqzoneShareVideoWithTitle:(NSString *)title desc:(NSString *)desc thumbImage:(UIImage *)image videoURL:(NSString *)videoURL{
    
    [self qqzoneShareWebWithTitle:title desc:desc thumbImage:image url:videoURL];
}

+ (void)qqzoneShareMusicWithTitle:(NSString *)title desc:(NSString *)desc thumbImage:(UIImage *)image musicURL:(NSString *)musicURL{
    
    [self qqzoneShareWebWithTitle:title desc:desc thumbImage:image url:musicURL];
}

+ (void)qqzoneShareImage:(UIImage *)image {
    
    QQApiImageArrayForQZoneObject *img = [QQApiImageArrayForQZoneObject objectWithimageDataArray:@[image] title:nil];
    SendMessageToQQReq* req = [SendMessageToQQReq reqWithContent:img];
    QQApiSendResultCode sent = [QQApiInterface SendReqToQZone:req];
    [self handleSendResult:sent];
}



#pragma mark - qq

+ (void)qqShareWebWithTitle:(NSString *)title desc:(NSString *)desc thumbImage:(UIImage *)image url:(NSString *)url {

    NSData* data = UIImageJPEGRepresentation(image, 1);
    QQApiNewsObject* img = [QQApiNewsObject objectWithURL:[NSURL URLWithString:url] title:title description:desc previewImageData:data];
    SendMessageToQQReq* req = [SendMessageToQQReq reqWithContent:img];
    
    QQApiSendResultCode sent = [QQApiInterface sendReq:req];
    [self handleSendResult:sent];
}

+ (void)qqShareText:(NSString *)text {
    
    QQApiTextObject* txtObj = [QQApiTextObject objectWithText:text];
    SendMessageToQQReq* req = [SendMessageToQQReq reqWithContent:txtObj];
    QQApiSendResultCode sent = [QQApiInterface sendReq:req];
    [self handleSendResult:sent];
}

+ (void)handleSendResult:(QQApiSendResultCode)sendResult
{
    switch (sendResult)
    {
        case EQQAPIAPPNOTREGISTED:
        {
            UIAlertView *msgbox = [[UIAlertView alloc] initWithTitle:@"Error" message:@"App未注册" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil];
            [msgbox show];
            
            
            break;
        }
        case EQQAPIMESSAGECONTENTINVALID:
        case EQQAPIMESSAGECONTENTNULL:
        case EQQAPIMESSAGETYPEINVALID:
        {
            UIAlertView *msgbox = [[UIAlertView alloc] initWithTitle:@"Error" message:@"发送参数错误" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil];
            [msgbox show];
      
            
            break;
        }
        case EQQAPIQQNOTINSTALLED:
        {
            UIAlertView *msgbox = [[UIAlertView alloc] initWithTitle:@"Error" message:@"未安装手Q" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil];
            [msgbox show];
            
            break;
        }
        case EQQAPIQQNOTSUPPORTAPI:
        {
            UIAlertView *msgbox = [[UIAlertView alloc] initWithTitle:@"Error" message:@"API接口不支持" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil];
            [msgbox show];
            
            break;
        }
        case EQQAPISENDFAILD:
        {
            UIAlertView *msgbox = [[UIAlertView alloc] initWithTitle:@"Error" message:@"发送失败" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil];
            [msgbox show];
            
            break;
        }
        case EQQAPIVERSIONNEEDUPDATE:
        {
            UIAlertView *msgbox = [[UIAlertView alloc] initWithTitle:@"Error" message:@"当前QQ版本太低，需要更新" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil];
            [msgbox show];
            break;
        }
        default:
        {
            break;
        }
    }
}

+ (void)qqShareVideoWithTitle:(NSString *)title desc:(NSString *)desc thumbImage:(UIImage *)image videoURL:(NSString *)videoURL{
    
    
    NSData* data = UIImageJPEGRepresentation(image, 1);
    NSURL* url = [NSURL URLWithString:videoURL];
    
    /*
     * QQApiVideoObject类型的分享，目前在android和PC上接收消息时，展现有问题，待手Q版本以后更新支持
     * 目前如果要分享视频请使用 QQApiNewsObject 类型，URL填视频所在的H5地址
     
     QQApiVideoObject* img = [QQApiVideoObject objectWithURL:url title:apiObjEditCtrl.objTitle.text description:apiObjEditCtrl.objDesc.text previewImageData:data];
     */
    
    QQApiNewsObject* img = [QQApiNewsObject objectWithURL:url title:title description:desc previewImageData:data];
    
    SendMessageToQQReq* req = [SendMessageToQQReq reqWithContent:img];
    
    QQApiSendResultCode sent = [QQApiInterface sendReq:req];
    [self handleSendResult:sent];

}

+ (void)qqShareMusicWithTitle:(NSString *)title desc:(NSString *)desc thumbImage:(UIImage *)image musicURL:(NSString *)musicURL{
    
    NSData* data = UIImageJPEGRepresentation(image, 1);
    NSURL* url = [NSURL URLWithString:musicURL];
    
    QQApiAudioObject* img = [QQApiAudioObject objectWithURL:url title:title description:desc previewImageData:data];
    SendMessageToQQReq* req = [SendMessageToQQReq reqWithContent:img];
    
    QQApiSendResultCode sent = [QQApiInterface sendReq:req];
    [self handleSendResult:sent];
    
}

+ (void)qqShareImage:(UIImage *)image {
    
    
    NSData* data = UIImageJPEGRepresentation(image, 1);
    
    QQApiImageObject* img = [QQApiImageObject objectWithData:data previewImageData:data title:nil description:nil];
    SendMessageToQQReq* req = [SendMessageToQQReq reqWithContent:img];
    
    QQApiSendResultCode sent = [QQApiInterface sendReq:req];
    [self handleSendResult:sent];}



#pragma mark - weibo

+ (void)wbShareWebWithTitle:(NSString *)title desc:(NSString *)desc thumbImage:(UIImage *)image url:(NSString *)url {
    
    WBMessageObject *message = [WBMessageObject message];
    WBWebpageObject *webpage = [WBWebpageObject object];
    webpage.objectID = @"identifierWeb";
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
    WBMessageObject *message = [WBMessageObject message];

    WBVideoObject *obj = [WBVideoObject object];
    obj.objectID = @"identifierVideo";
    obj.title = title;
    obj.description = desc;
    obj.videoStreamUrl = videoURL;
    obj.videoUrl = videoURL;
    obj.thumbnailData = UIImageJPEGRepresentation(image, 0.7);
    message.mediaObject = obj;
    
    WBAuthorizeRequest *authRequest = [WBAuthorizeRequest request];
    authRequest.redirectURI = @"http://www.sina.com";
    authRequest.scope = @"all";
    
    WBSendMessageToWeiboRequest *request = [WBSendMessageToWeiboRequest requestWithMessage:message authInfo:authRequest access_token:nil];
    [WeiboSDK sendRequest:request];

}

+ (void)wbShareMusicWithTitle:(NSString *)title desc:(NSString *)desc thumbImage:(UIImage *)image musicURL:(NSString *)musicURL {
    
    WBMessageObject *message = [WBMessageObject message];
    
    WBMusicObject *obj = [WBMusicObject object];
    obj.objectID = @"identifierMusic";
    obj.title = title;
    obj.description = desc;
    obj.musicUrl = musicURL;
    obj.musicStreamUrl = musicURL;
    obj.thumbnailData = UIImageJPEGRepresentation(image, 0.7);
    message.mediaObject = obj;
    
    WBAuthorizeRequest *authRequest = [WBAuthorizeRequest request];
    authRequest.redirectURI = @"http://www.sina.com";
    authRequest.scope = @"all";
    
    WBSendMessageToWeiboRequest *request = [WBSendMessageToWeiboRequest requestWithMessage:message authInfo:authRequest access_token:nil];
    [WeiboSDK sendRequest:request];
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
