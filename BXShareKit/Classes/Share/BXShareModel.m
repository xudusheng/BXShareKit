//
//  BXShareModel.m
//  BXShareDemo
//
//  Created by Hmily on 2019/4/10.
//  Copyright © 2019 Document. All rights reserved.
//

#import "BXShareModel.h"

@implementation BXShareModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{
             @"title":@"title",
             @"text":@"content",
             @"thumbImgUrl":@"pic",
             @"shareWebUrl":@"url"
             };
}

@end
