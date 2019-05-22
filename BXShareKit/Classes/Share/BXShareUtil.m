//
//  BXShareUtil.m
//  BXShareModule
//
//  Created by Hmily on 2019/3/21.
//  Copyright © 2019 Document. All rights reserved.
//

#import "BXShareUtil.h"

@implementation BXShareUtil

+ (UMSocialPlatformType)getUMSocialPlatformType:(BXSharePlatformType)platformType {
    switch (platformType) {
        case BXSharePlatformType_WeChat: //微信
            return UMSocialPlatformType_WechatSession;
            
        case BXSharePlatformType_WeChatFriends: //微信朋友圈
            return UMSocialPlatformType_WechatTimeLine;
            
        case BXSharePlatformType_QQ: //qq
            return UMSocialPlatformType_QQ;
            
        case BXSharePlatformType_Qzone: //空间
            return UMSocialPlatformType_Qzone;
            
        case BXSharePlatformType_Sina: //微博
            return UMSocialPlatformType_Sina;
            
        default:
            return UMSocialPlatformType_UnKnown;
    }
}

@end
