//
//  BXShareModel.h
//  BXShareDemo
//
//  Created by Hmily on 2019/4/10.
//  Copyright © 2019 Document. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "BXShareEnum.h"

@interface BXShareModel : NSObject

@property (nonatomic, strong) NSString *title;//标题    默认@“”
@property (nonatomic, strong) NSString *text;//内容/描述。 默认@“”
@property (nonatomic, strong) UIImage *thumbImg;//缩略图。  默认app 图标
@property (nonatomic, strong) NSString *thumbImgUrl;//缩略图url。  优先判断 thumbImg
@property (nonatomic, assign) BXShareModelType shareType;//分享类型。默认 0 分享文字

@property (nonatomic, strong) UIImage *shareImgv;//需要分享的图片  选填
@property (nonatomic, strong) NSString *shareImgvUrl;//需要分享的图片url     选填
@property (nonatomic, strong) NSString *shareWebUrl;//网页分享url  选填

@end


