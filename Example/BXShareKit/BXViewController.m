//
//  BXViewController.m
//  BXShareKit
//
//  Created by xudusheng on 05/22/2019.
//  Copyright (c) 2019 xudusheng. All rights reserved.
//

#import "BXViewController.h"
#import "BXShareKit.h"
@interface BXViewController ()

@end

@implementation BXViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    
    [BXShareManager registerUMengAppKey:@"5b7ccb188f4a9d557400001a"];
    [BXShareManager setPlaform:BXSharePlatformType_WeChat appKey:@"wxc81c820b2ebb7a04" appSecret:@"8acea07ac8058f551933fd7a42a6afcc" redirectURL:@""];
    [BXShareManager configPlatforms:@[
                                      @(BXSharePlatformType_WeChat),
                                      @(BXSharePlatformType_WeChatFriends),
                                      @(BXSharePlatformType_QQ),
                                      @(BXSharePlatformType_Sina),
                                      @(BXSharePlatformType_WeChat),
                                      @(BXSharePlatformType_WeChatFriends),
                                      @(BXSharePlatformType_QQ),
                                      @(BXSharePlatformType_Sina),
                                      @(BXSharePlatformType_WeChat),
                                      @(BXSharePlatformType_WeChatFriends),
                                      @(BXSharePlatformType_QQ),
                                      @(BXSharePlatformType_Sina)]];
    [self configShareUI];
}


- (void)configShareUI {
    BXShareViewConfig *shareConfig = [BXShareUIConfig sharedInstance].shareViewConfig;
    shareConfig.shareViewCornerRadius = 20;
    
    BXShareTitleViewConfig *titleConfig =[BXShareUIConfig sharedInstance].shareTitleViewConfig;
    titleConfig.shareTitleViewTitleString = @"分享到";
    titleConfig.shareTitleViewFont = [UIFont systemFontOfSize:17];
    titleConfig.shareTitleViewTitleAlignment = NSTextAlignmentLeft;
    titleConfig.shareTitleViewMarginInsets = UIEdgeInsetsMake(18, 18, 20, 100);
    [BXShareUIConfig sharedInstance].shareTitleViewConfig = titleConfig;
    
    BXShareCancelControlConfig *cancelConfig = [BXShareUIConfig sharedInstance].shareCancelControlConfig;
    //    cancelConfig.shareCancelControlLocation = BXShareCancelControlLocationTopAndRight;
    //    cancelConfig.shareCancelControlMarginInsets = UIEdgeInsetsMake(0, 0, 0, 15);
    //    cancelConfig.shareCancelControlText = nil;
    //    cancelConfig.shareCancelControlImage = [UIImage imageNamed:@"share_close"];
    cancelConfig.shareCancelControlLocation = BXShareCancelControlLocationBottom;
    cancelConfig.shareCancelControlText = @"取消";
    cancelConfig.shareCancelControlTextFont = [UIFont systemFontOfSize:14];
    cancelConfig.shareCancelControlTextColor = [UIColor blackColor];
    
    BXShareItemContainerViewConfig *itemContainerConfig = [BXShareUIConfig sharedInstance].shareItemContainerViewConfig;
    itemContainerConfig.rows = 3;
    itemContainerConfig.columns = 4;
    itemContainerConfig.shareItemContainerViewPaddingInsets = UIEdgeInsetsMake(20, 20, 20, 10);
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    BXShareModel *shareModel = [BXShareModel new];
    shareModel.title = @"主标题";
    shareModel.text = @"副标题：我今天发成长了一点";
    shareModel.shareWebUrl = @"https://www.baidu.com";
    shareModel.shareType = BXShareModelType_WEB;
    
    [BXShareManager showShareViewWithModel:shareModel complete:^(BXSharePlatformType platformType, BXShareState shareState, NSString *responseMessage, BOOL success) {
        if (shareState == BXShareStateBegin) {
            NSLog(@"shareState = 点击了分享");

        } else {
            NSLog(@"responseMessage = %@", responseMessage);

        }
    }];
}

@end
