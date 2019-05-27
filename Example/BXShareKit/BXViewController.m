//
//  BXViewController.m
//  BXShareKit
//
//  Created by xudusheng on 05/22/2019.
//  Copyright (c) 2019 xudusheng. All rights reserved.
//

#import "BXViewController.h"

#if __has_include(<BXShareKit/BXShareKit.h>)
#import <BXShareKit/BXShareKit.h>
#else
#import "BXShareKit.h"
#endif

#import "UIButton+BXShare.h"

@interface BXViewController ()
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property (weak, nonatomic) IBOutlet UIButton *registerButton;

@property (weak, nonatomic) IBOutlet UIButton *cancelButton;
@property (weak, nonatomic) IBOutlet UIButton *okButton;
@end

@implementation BXViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    
    [BXShareManager registerUMengAppKey:@"5b7ccb188f4a9d557400001a"];
    [BXShareManager setPlaform:BXSharePlatformType_WeChat appKey:@"wxc81c820b2ebb7a04" appSecret:@"8acea07ac8058f551933fd7a42a6afcc" redirectURL:@""];
    
    BXSharePlatformModel *model1 = [BXSharePlatformModel sharePlatformModelWithPlatformType:BXSharePlatformType_WeChat
                                                                                      title:@"微信好友"
                                                                                      image:[UIImage imageNamed:@"btn_found_WeChat"]];
    
    BXSharePlatformModel *model2 = [[BXSharePlatformModel alloc] init];
    model2.platformType = BXSharePlatformType_WeChat;
    model2.item_title = @"朋友圈";
    model2.item_image = [UIImage imageNamed:@"btn_found_friends"];
    [BXShareManager configPlatformModels:@[model1, model2]];
//    [BXShareManager configPlatforms:@[
//                                      @(BXSharePlatformType_WeChat),
//                                      @(BXSharePlatformType_WeChatFriends),
//                                      @(BXSharePlatformType_QQ),
//                                      @(BXSharePlatformType_Sina),
//                                      @(BXSharePlatformType_WeChat),
//                                      @(BXSharePlatformType_WeChatFriends),
//                                      @(BXSharePlatformType_QQ),
//                                      @(BXSharePlatformType_Sina),
//                                      @(BXSharePlatformType_WeChat),
//                                      @(BXSharePlatformType_WeChatFriends),
//                                      @(BXSharePlatformType_QQ),
//                                      @(BXSharePlatformType_Sina)]];
    [self configShareUI];
    
    [self configButton];
}






#pragma mark - UI相关

- (void)configShareUI {
    BXShareViewConfig *shareConfig = [BXShareUIConfig sharedInstance].shareViewConfig;
    shareConfig.shareViewCornerRadius = 20;
    shareConfig.separatorColor = [UIColor whiteColor];
    
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
    cancelConfig.shareCancelControlHeight = 49;
    cancelConfig.shareCancelControlBackgroundColor = [UIColor groupTableViewBackgroundColor];
    
    BXShareItemContainerViewConfig *itemContainerConfig = [BXShareUIConfig sharedInstance].shareItemContainerViewConfig;
    itemContainerConfig.shareItemHeight = 85;
    itemContainerConfig.rows = 3;
    itemContainerConfig.columns = 4;
    itemContainerConfig.shareItemTitleAndImageMargin = 10;
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

- (void)configButton {
    self.loginButton.imageView.backgroundColor = [UIColor blueColor];
    self.loginButton.titleLabel.backgroundColor = [UIColor greenColor];
    [self.loginButton configWithButtonType:BXButtonTypeTitleImageBottomAndTop margin:10];
    
    self.registerButton.imageView.backgroundColor = [UIColor blueColor];
    self.registerButton.titleLabel.backgroundColor = [UIColor greenColor];
    [self.registerButton configWithButtonType:BXButtonTypeTitleImageTopAndBottom margin:10];
    
    self.cancelButton.imageView.backgroundColor = [UIColor blueColor];
    self.cancelButton.titleLabel.backgroundColor = [UIColor greenColor];
    [self.cancelButton configWithButtonType:BXButtonTypeTitleImageLeftAndRight margin:10];
    
    self.okButton.imageView.backgroundColor = [UIColor blueColor];
    self.okButton.titleLabel.backgroundColor = [UIColor greenColor];
    [self.okButton configWithButtonType:BXButtonTypeTitleImageRightAndLeft margin:10];
}
#pragma mark - request method 网络请求

#pragma mark - delegate method 代理方法

#pragma mark - event response 事件响应处理
- (IBAction)denglu:(id)sender {
    NSLog(@"登录");
}

- (IBAction)register:(id)sender {
    NSLog(@"注册");
}
#pragma mark - private method 其他私有方法

#pragma mark - setter & getter

#pragma mark - memery 内存管理相关

@end
