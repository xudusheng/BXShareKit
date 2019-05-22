//
//  BXShareUIConfig.h
//  BXShareDemo
//
//  Created by Hmily on 2019/4/10.
//  Copyright © 2019 Document. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "BXShareEnum.h"

/**
 *  ShareTitleView的配置类
 */
@interface BXShareTitleViewConfig : NSObject

@property(nonatomic,readwrite,strong)NSString* shareTitleViewTitleString;//标题的文字
@property(nonatomic,readwrite,strong)UIColor* shareTitleViewTitleColor;//文字颜色
@property(nonatomic,readwrite,strong)UIFont* shareTitleViewFont;//字体
@property(nonatomic,readwrite,strong)UIColor* shareTitleViewBackgroundColor;//背景颜色

@property (nonatomic,assign) NSTextAlignment shareTitleViewTitleAlignment;//标题文字的对齐方式，默认center
@property (nonatomic,assign) UIEdgeInsets shareTitleViewMarginInsets;//外边距。默认为(10,10,10,10)

@end

/**
 *  ShareCancelControl的配置类
 */
@interface BXShareCancelControlConfig : NSObject

@property(nonatomic,readwrite,strong)NSString* shareCancelControlText;//相对父view的左边距
@property(nonatomic,readwrite,strong)UIColor* shareCancelControlTextColor;//文字颜色
@property(nonatomic,readwrite,strong)UIFont* shareCancelControlTextFont;//文字字体
@property(nonatomic,readwrite,strong)UIColor* shareCancelControlBackgroundColor;//背景颜色;
@property(nonatomic,readwrite,strong)UIImage* shareCancelControlImage;//图片;

@property (nonatomic,assign) BXShareCancelControlLocation shareCancelControlLocation;//按钮位置
@property (nonatomic,assign) CGFloat shareCancelControlWidth;//按钮的宽度(底部默认全宽，其他位置默认35)
@property (nonatomic,assign) CGFloat shareCancelControlHeight;//按钮的高度(底部默认高度44，其他位置默认35)
@property (nonatomic,assign) UIEdgeInsets shareCancelControlMarginInsets;//外边距。默认为(10,0,0,0)
@end

/**
 *  BXShareItemContainerView的配置类
 */
@interface BXShareItemContainerViewConfig : NSObject

@property(nonatomic,readwrite,strong)UIColor* shareItemContainerViewBackgroundColor;//背景颜色;
@property (nonatomic,assign) CGFloat shareItemContainerViewMarginLeft;//左边距，默认为0
@property (nonatomic,assign) CGFloat shareItemContainerViewMarginRight;//右边距，默认为0
@property (nonatomic,assign) UIEdgeInsets shareItemContainerViewPaddingInsets;//内边距。默认为(15,15,15,15)

@property (nonatomic,assign) CGFloat shareItemWidth;//分享Item的宽度，默认65
@property (nonatomic,assign) CGFloat shareItemHeight;//分享Item的宽度，默认65
@property (nonatomic,assign) NSUInteger rows;//行数，默认2行
@property (nonatomic,assign) NSUInteger columns;//列数，默认4列

@end

@interface BXShareViewConfig : NSObject

@property(nonatomic,readwrite,strong)UIColor* shareViewBackgroundColor;//背景颜色;
@property (nonatomic,assign) CGFloat shareViewMarginLeft;//左边距，默认为0
@property (nonatomic,assign) CGFloat shareViewMarginRight;//右边距，默认为0
@property (nonatomic,assign) CGFloat shareViewCornerRadius;//圆角，默认为0


//按钮与分享容器的分割线
@property (nonatomic,strong) UIColor *separatorColor;//分割线颜色，默认groupTableViewBackgroundColor
@property (nonatomic,assign) CGFloat separatorHeight;//分割线高度，默认为1
@property (nonatomic,assign) CGFloat separatorMargin;//分割线边距，默认为15

@end


@interface BXShareUIConfig : NSObject
+(BXShareUIConfig*)sharedInstance;

@property(nonatomic,readwrite,strong)BXShareViewConfig*                         shareViewConfig;
@property(nonatomic,readwrite,strong)BXShareTitleViewConfig*                  shareTitleViewConfig;
@property(nonatomic,readwrite,strong)BXShareCancelControlConfig*          shareCancelControlConfig;
@property(nonatomic,readwrite,strong)BXShareItemContainerViewConfig*  shareItemContainerViewConfig;

//@property(nonatomic,readwrite,strong)UMSocialSharePageGroupViewConfig*          sharePageGroupViewConfig;
//@property(nonatomic,readwrite,strong)UMSocialShareContainerConfig*              shareContainerConfig;
//@property(nonatomic,readwrite,strong)UMSocialSharePageScrollViewConfig*         sharePageScrollViewConfig;
//@property(nonatomic,readwrite,strong)UMSocialPlatformItemViewConfig*            sharePlatformItemViewConfig;
//@property(nonatomic,readwrite,strong)UMSocialSharePageControlConfig*            sharePageControlConfig;
@end
