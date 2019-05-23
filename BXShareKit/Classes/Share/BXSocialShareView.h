//
//  BXSocialShareView.h
//  BXShareDemo
//
//  Created by Hmily on 2019/4/10.
//  Copyright © 2019 Document. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BXShareEnum.h"
#import "BXShareModel.h"
typedef void (^BXShareItemEventHandler)(BXSharePlatformType platformType);


@interface BXSocialShareView : UIView

- (instancetype)initWithPlatforms:(NSArray<BXSharePlatformModel*>*)platforms;

@property (nonatomic,copy) BXShareItemEventHandler itemClickHandler;


@end

