//
//  BXShareManager.h
//  BXShareDemo
//
//  Created by Hmily on 2019/4/9.
//  Copyright © 2019 Document. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BXShareEnum.h"
#import "BXShareModel.h"

typedef void (^BXShareHandler)(BXSharePlatformType platformType, BXShareState shareState, NSString *responseMessage, BOOL success);


@interface BXShareManager : NSObject

+ (BXShareManager *)sharedInstance;

/**
 *  设置平台的appkey
 *
 *  @param platformType 平台类型 @see BXSharePlatformType
 *  @param appKey       第三方平台的appKey（QQ平台为appID）
 *  @param appSecret    第三方平台的appSecret（QQ平台为appKey）
 *  @param redirectURL  redirectURL
 */
+ (BOOL)setPlaform:(BXSharePlatformType)platformType
            appKey:(NSString *)appKey
         appSecret:(NSString *)appSecret
       redirectURL:(NSString *)redirectURL;

+ (void)registerUMengAppKey:(NSString *)appKey;

+ (void)configPlatforms:(NSArray<NSNumber*>*)platforms;

+ (void)showShareViewWithModel:(BXShareModel *)model complete:(BXShareHandler)complete;
+ (void)dissmissShareView;//移除分享视图

/**
 *  获得从sso或者web端回调到本app的回调
 *  @return 是否处理  YES代表处理成功，NO代表不处理
 */
-(BOOL)handleOpenURL:(NSURL *)url;
-(BOOL)handleOpenURL:(NSURL *)url options:(NSDictionary*)options;
-(BOOL)handleOpenURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation;
@end

