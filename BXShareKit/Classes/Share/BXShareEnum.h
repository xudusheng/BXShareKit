//
//  BXShareEnum.h
//  BXShareModule
//
//  Created by Hmily on 2019/3/21.
//  Copyright © 2019 Document. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, BXSharePlatformType) {
    BXSharePlatformType_WeChat = 1,//微信
    BXSharePlatformType_WeChatFriends = 2,//微信朋友圈
    BXSharePlatformType_QQ = 3,//qq
    BXSharePlatformType_Qzone = 4,//空间
    BXSharePlatformType_Sina = 5,//微博
};

typedef NS_ENUM(NSUInteger, BXShareState) {
    BXShareStateBegin = 1,//开始分享（点击分享按钮时）
    BXShareStateEnd = 2,//微信朋友圈 (结束回调时)
};

typedef NS_ENUM(NSUInteger, BXShareModelType) {
    BXShareModelType_Text = 0,
    BXShareModelType_IMG = 1,
    BXShareModelType_WEB = 2,
};

typedef NS_ENUM(NSUInteger, BXShareCancelControlLocation) {
    BXShareCancelControlLocationBottom = 0,
    BXShareCancelControlLocationTopAndRight = 1,
    BXShareCancelControlLocationTopAndLeft = 2,
};

