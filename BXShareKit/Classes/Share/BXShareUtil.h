//
//  BXShareUtil.h
//  BXShareModule
//
//  Created by Hmily on 2019/3/21.
//  Copyright © 2019 Document. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BXShareEnum.h"
#import <UMShare/UMSocialPlatformConfig.h>

@interface BXShareUtil : NSObject

+ (UMSocialPlatformType)getUMSocialPlatformType:(BXSharePlatformType)platformType;

@end


