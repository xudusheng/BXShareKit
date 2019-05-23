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

@implementation BXSharePlatformModel
+ (instancetype)sharePlatformModelWithPlatformType:(BXSharePlatformType)platformType title:(NSString *)item_title image:(UIImage *)item_image {
    BXSharePlatformModel *model = [[BXSharePlatformModel alloc] init];
    model.platformType = platformType;
    model.item_title = item_title;
    model.item_image = item_image;
    return model;
}
@end
