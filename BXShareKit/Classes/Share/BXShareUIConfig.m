//
//  BXShareUIConfig.m
//  BXShareDemo
//
//  Created by Hmily on 2019/4/10.
//  Copyright © 2019 Document. All rights reserved.
//

#import "BXShareUIConfig.h"
#import "BXShareDefine.h"
static BXShareUIConfig *_instance;

@implementation BXShareUIConfig
+ (BXShareUIConfig *)sharedInstance {
    if (_instance == nil) {
        _instance = [[self alloc] init];
        BXShareTitleViewConfig *titleConfig = [[BXShareTitleViewConfig alloc] init];
        BXShareCancelControlConfig *cancelConfig = [[BXShareCancelControlConfig alloc] init];
        BXShareItemContainerViewConfig *itemContainerConfig = [[BXShareItemContainerViewConfig alloc] init];
        BXShareViewConfig *shareConfig = [[BXShareViewConfig alloc] init];
        _instance.shareTitleViewConfig = titleConfig;
        _instance.shareCancelControlConfig = cancelConfig;
        _instance.shareItemContainerViewConfig = itemContainerConfig;
        _instance.shareViewConfig = shareConfig;
    }
    return _instance;
}

+ (id)allocWithZone:(NSZone *)zone {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [super allocWithZone:zone];
    });
    return _instance;
}
@end


@implementation BXShareTitleViewConfig
- (instancetype)init {
    if (self = [super init]) {
        self.shareTitleViewTitleString = @"分享到";
        self.shareTitleViewTitleColor = [UIColor blackColor];
        self.shareTitleViewFont = [UIFont systemFontOfSize:17];
        self.shareTitleViewBackgroundColor = [UIColor whiteColor];
        self.shareTitleViewTitleAlignment = NSTextAlignmentCenter;
        self.shareTitleViewMarginInsets = UIEdgeInsetsMake(15, 0, 15, 0);
    }
    return self;
}
@end

@implementation BXShareCancelControlConfig
- (instancetype)init {
    if (self = [super init]) {
        self.shareCancelControlText = @"取消";
        self.shareCancelControlTextColor = [UIColor blackColor];
        self.shareCancelControlTextFont = [UIFont systemFontOfSize:17];
        self.shareCancelControlBackgroundColor = [UIColor whiteColor];
        
        self.shareCancelControlLocation = BXShareCancelControlLocationBottom;
        self.shareCancelControlMarginInsets = UIEdgeInsetsMake(10, 0, 0, 0);
    }
    return self;
}


- (CGFloat)shareCancelControlHeight {
    if (_shareCancelControlHeight > 0) {
        return _shareCancelControlHeight;
    }
    return (self.shareCancelControlLocation == BXShareCancelControlLocationBottom)?44:35;
}

- (CGFloat)shareCancelControlWidth {
    if (_shareCancelControlWidth > 0) {
        return _shareCancelControlWidth;
    }
    return (self.shareCancelControlLocation == BXShareCancelControlLocationBottom)?CGRectGetWidth([UIScreen mainScreen].bounds):35;
}
@end

@implementation BXShareItemContainerViewConfig
- (instancetype)init {
    if (self = [super init]) {
        self.shareItemContainerViewBackgroundColor = [UIColor whiteColor];
        self.shareItemContainerViewMarginLeft = 0;
        self.shareItemContainerViewMarginRight = 0;
        self.shareItemContainerViewPaddingInsets = UIEdgeInsetsMake(15, 15, 15, 15);
        self.rows = 2;
        self.columns = 4;
        self.shareItemWidth = 65;
        self.shareItemHeight = 65;
        self.shareItemTitleAndImageMargin = 20;
        self.shareItemTitleColor = RGB(102,102,102,1);
        self.shareItemTitleFont = BX_SHARE_FONT_SIZE(11);
    }
    return self;
}
@end

@implementation BXShareViewConfig

- (instancetype)init {
    if (self = [super init]) {
        self.shareViewBackgroundColor = [UIColor whiteColor];
        self.shareViewMarginLeft = 0;
        self.shareViewMarginRight = 0;
        self.shareViewCornerRadius = 0;
        
        self.separatorColor = [UIColor groupTableViewBackgroundColor];
        self.separatorHeight = 1.0;
        self.separatorMargin = 15.f;
    }
    return self;
}

@end
