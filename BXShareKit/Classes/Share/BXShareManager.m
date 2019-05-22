//
//  BXShareManager.m
//  BXShareDemo
//
//  Created by Hmily on 2019/4/9.
//  Copyright © 2019 Document. All rights reserved.
//

#import "BXShareManager.h"
#import <UMShare/UMShare.h>
#import <UMCommon/UMConfigure.h>
#import "BXShareUtil.h"
#import "BXShareDefine.h"
#import "UIImage+BXShare.h"
#import "BXSocialShareView.h"
#import "BXShareUIConfig.h"

static BXShareManager *_instance;

static NSArray *staticCustomShareViewPlatforms;

@implementation BXShareManager

+ (BXShareManager *)sharedInstance {
    if (_instance == nil) {
        _instance = [[self alloc] init];
    }
    return _instance;
}

+ (id)allocWithZone:(NSZone *)zone {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [super allocWithZone:zone];
    });
    return _instance;
}


+ (BOOL)setPlaform:(BXSharePlatformType)platformType
            appKey:(NSString *)appKey
         appSecret:(NSString *)appSecret
       redirectURL:(NSString *)redirectURL {
    /* 设置微信的appKey和appSecret */
    return  [[UMSocialManager defaultManager] setPlaform:[BXShareUtil getUMSocialPlatformType:platformType]
                                                  appKey:appKey
                                               appSecret:appSecret
                                             redirectURL:redirectURL];
}
+ (void)registerUMengAppKey:(NSString *)appKey {
    [UMConfigure initWithAppkey:appKey channel:@"App Store"];
}


+ (void)configPlatforms:(NSArray<NSNumber*>*)platforms {
    staticCustomShareViewPlatforms = platforms;
}

+ (void)showShareViewWithModel:(BXShareModel *)model complete:(BXShareHandler)complete {
//    [UMSocialShareUIConfig shareInstance].sharePageGroupViewConfig.sharePageGroupViewPostionType = UMSocialSharePageGroupViewPositionType_Bottom;
//    [UMSocialShareUIConfig shareInstance].sharePageScrollViewConfig.shareScrollViewPageItemStyleType = UMSocialPlatformItemViewBackgroudType_None;
//    [UMSocialUIManager showShareMenuViewInWindowWithPlatformSelectionBlock:^(UMSocialPlatformType platformType, NSDictionary *userInfo) {
//        NSLog(@"xxxxxxxx = %@", userInfo);
//        [self show:model platformType:platformType];
//    }];

    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    UIView *bgView = [window viewWithTag:NSIntegerMax];
    if (bgView != nil) {
        [bgView removeFromSuperview];
        bgView = nil;
    }
    bgView = [[UIView alloc] initWithFrame:CGRectZero];
    bgView.tag = NSIntegerMax;
    [bgView addGestureRecognizer:({
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:[BXShareManager sharedInstance] action:@selector(dissmissShareView)];
        tap;
    })];
    [window addSubview:bgView];
    bgView.bounds = window.bounds;
    bgView.frame = window.frame;
    bgView.center = window.center;
    
    BXSocialShareView *shareView = [[BXSocialShareView alloc] initWithPlatforms:staticCustomShareViewPlatforms];
    [shareView setItemClickHandler:^(BXSharePlatformType platformType) {
        complete(platformType, BXShareStateBegin, nil, NO);
        [self dissmissShareView];
        [self show:model platformType:platformType complete:complete];
    }];
    shareView.tag = NSIntegerMax;
    [bgView addSubview:shareView];
    
    __block CGRect shareViewFrame = shareView.frame;
    shareViewFrame.origin.y = CGRectGetHeight(bgView.frame);
    shareView.frame = shareViewFrame;

    [UIView animateWithDuration:0.35 animations:^{
        bgView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
        BXShareViewConfig *shareConfig = [BXShareUIConfig sharedInstance].shareViewConfig;        
        shareViewFrame.origin.y = CGRectGetHeight(bgView.frame) - CGRectGetHeight(shareViewFrame) + shareConfig.shareViewCornerRadius;
        shareView.frame = shareViewFrame;
    }];
}

- (void)dissmissShareView {
    [self.class dissmissShareView];
}
+ (void)dissmissShareView{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    UIView *bgView = [window viewWithTag:NSIntegerMax];
    BXSocialShareView *shareView = [bgView viewWithTag:NSIntegerMax];
    bgView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
    [UIView animateWithDuration:0.35 animations:^{
        CGRect shareViewFrame = shareView.frame;
        shareViewFrame.origin.y =CGRectGetHeight(bgView.frame);
        shareView.frame = shareViewFrame;
    } completion:^(BOOL finished) {
        [bgView removeFromSuperview];
    }];
}


+ (void)show:(BXShareModel *)model platformType:(BXSharePlatformType)platformType complete:(BXShareHandler)complete{
    NSDictionary *infoPlist = [[NSBundle mainBundle] infoDictionary];
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    switch (model.shareType) {
        case BXShareModelType_Text: {
            messageObject.text = model.text;
            break;
        }
        case BXShareModelType_IMG: {
            NSString *icon = [[infoPlist valueForKeyPath:@"CFBundleIcons.CFBundlePrimaryIcon.CFBundleIconFiles"] lastObject];
            UIImage* iconImg = [UIImage imageNamed:icon];
            NSData *imgdata;
            if (model.shareImgv != nil) {
                imgdata = UIImageJPEGRepresentation(model.shareImgv, 1);
            }else if (model.shareImgvUrl != nil) {
                imgdata = [NSData dataWithContentsOfURL:[NSURL URLWithString:model.shareImgvUrl]];
            }else{
                imgdata = UIImageJPEGRepresentation(iconImg, 1);
            }
            
            UMShareImageObject *imgObject = [UMShareImageObject shareObjectWithTitle:model.title?model.title:[infoPlist objectForKey:@"CFBundleDisplayName"] descr:model.text thumImage:imgdata];
            imgObject.shareImage = imgdata;
            messageObject.shareObject = imgObject;
            break;
        }
        case BXShareModelType_WEB: {
            NSString *icon = [[infoPlist valueForKeyPath:@"CFBundleIcons.CFBundlePrimaryIcon.CFBundleIconFiles"] lastObject];
            UIImage* iconImg = [UIImage imageNamed:icon];
            
            NSData *imgdata;
            if (model.thumbImg != nil) {
                imgdata = UIImageJPEGRepresentation([UIImage imageCompressToJPGWithImgage:model.thumbImg maxWidth:60 maxHeight:60],1);
            }else if (model.thumbImgUrl != nil) {
                UIImage *img = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:model.thumbImgUrl]]];
                imgdata = UIImageJPEGRepresentation([UIImage imageCompressToJPGWithImgage:img maxWidth:120 maxHeight:120],1);
            }else{
                if (IS_IPHONE_X_SHARE) {
                    imgdata = UIImageJPEGRepresentation([UIImage imageCompressToJPGWithImgage:iconImg maxWidth:120 maxHeight:120],1);
                }else{
                    imgdata = UIImageJPEGRepresentation(iconImg, 1);
                }
            }
            UMShareWebpageObject *shareObject = [UMShareWebpageObject
                                                 shareObjectWithTitle:model.title?:[infoPlist objectForKey:@"CFBundleDisplayName"]
                                                 descr:model.text
                                                 thumImage:imgdata];
            
            shareObject.webpageUrl = model.shareWebUrl;
            [messageObject setShareObject:shareObject];
            break;
        }
        default:break;
    }
    

    [[UMSocialManager defaultManager] shareToPlatform:[BXShareUtil getUMSocialPlatformType:platformType]
                                        messageObject:messageObject
                                currentViewController:nil
                                           completion:^(id data, NSError *error) {
                                               if (error) {
                                                   if (complete) complete(platformType, BXShareStateEnd, error.localizedDescription, NO);
                                               }else{
                                                   if ([data isKindOfClass:[UMSocialShareResponse class]]) {
                                                       UMSocialShareResponse *resp = data;
                                                       if (complete) complete(platformType, BXShareStateEnd, resp.message, YES);
                                                   }else{
                                                       if (complete) complete(platformType, BXShareStateEnd, @"分享成功", YES);
                                                   }
                                               }
                                           }];
}

-(BOOL)handleOpenURL:(NSURL *)url {
    return [[UMSocialManager defaultManager] handleOpenURL:url];
}
-(BOOL)handleOpenURL:(NSURL *)url options:(NSDictionary*)options {
    return [[UMSocialManager defaultManager] handleOpenURL:url options:options];
}
-(BOOL)handleOpenURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    return [[UMSocialManager defaultManager] handleOpenURL:url sourceApplication:sourceApplication annotation:annotation];
}
@end
