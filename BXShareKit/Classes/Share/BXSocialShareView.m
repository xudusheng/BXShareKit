//
//  BXSocialShareView.m
//  BXShareDemo
//
//  Created by Hmily on 2019/4/10.
//  Copyright © 2019 Document. All rights reserved.
//

#import "BXSocialShareView.h"
#import "BXShareUIConfig.h"
#import "BXShareDefine.h"
#import "UIButton+BXShare.h"
#import "BXShareManager.h"
@interface BXSocialShareView ()

@property (nonatomic,strong) UIView *line;
@property (nonatomic,strong) UIButton *cancelButton;
@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic, strong) UIScrollView *shareContainerview;//按钮容器

@property (nonatomic,strong) NSArray<NSNumber*>*platforms;

@end

@implementation BXSocialShareView

NSInteger const kBXSocialShareViewButtonBaseTag = 1000;

- (instancetype)initWithPlatforms:(NSArray<NSNumber*>*)platforms {
    BXShareViewConfig *shareConfig = [BXShareUIConfig sharedInstance].shareViewConfig;
    CGRect frame = CGRectMake(shareConfig.shareViewMarginLeft, 0, CGRectGetWidth([UIScreen mainScreen].bounds) - shareConfig.shareViewMarginLeft - shareConfig.shareViewMarginRight, 10);
    
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = shareConfig.shareViewBackgroundColor;
        self.layer.cornerRadius = shareConfig.shareViewCornerRadius;
        self.layer.masksToBounds = YES;
        self.platforms = platforms;
        [self createShareView];
        [self addGestureRecognizer:({
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doNothing)];
            tap;
        })];
    }
    return self;
}


- (void)createShareView {
    [self createContainerView];
    [self createCancelButton];
    [self createTitleView];
    [self updateFrames];
}
- (void)createTitleView {
    BXShareTitleViewConfig *titleConfig = [BXShareUIConfig sharedInstance].shareTitleViewConfig;
    self.titleLabel = ({
        UILabel *label = [[UILabel alloc] init];
        label.text = titleConfig.shareTitleViewTitleString;
        label.backgroundColor = titleConfig.shareTitleViewBackgroundColor;
        label.textColor = titleConfig.shareTitleViewTitleColor;
        label.font = titleConfig.shareTitleViewFont;
        label.textAlignment = titleConfig.shareTitleViewTitleAlignment;
        label.numberOfLines = 1;
        [self addSubview:label];
        label;
    });
}
- (void)createCancelButton {
    BXShareCancelControlConfig *cancelConfig = [BXShareUIConfig sharedInstance].shareCancelControlConfig;
    self.cancelButton = ({
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:cancelConfig.shareCancelControlText forState:UIControlStateNormal];
        [button setTitleColor:cancelConfig.shareCancelControlTextColor forState:UIControlStateNormal];
        [button setImage:cancelConfig.shareCancelControlImage forState:UIControlStateNormal];
        button.titleLabel.font = cancelConfig.shareCancelControlTextFont;//字体大小
        [button addTarget:[BXShareManager sharedInstance] action:@selector(dissmissShareView) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        button;
    });
}

- (void)createContainerView {
    BXShareItemContainerViewConfig *itemContainerConfig = [BXShareUIConfig sharedInstance].shareItemContainerViewConfig;

    NSInteger columns = itemContainerConfig.columns;
    NSInteger rows = itemContainerConfig.rows;
    NSInteger itemsPerPage = columns*rows;
    CGFloat itemHeight = itemContainerConfig.shareItemHeight;
    CGFloat itemWidth = itemContainerConfig.shareItemWidth;
    CGFloat marginTop = itemContainerConfig.shareItemContainerViewPaddingInsets.top;
    CGFloat marginLeft = itemContainerConfig.shareItemContainerViewPaddingInsets.left;
    CGFloat marginBottom = itemContainerConfig.shareItemContainerViewPaddingInsets.bottom;
    CGFloat marginRight = itemContainerConfig.shareItemContainerViewPaddingInsets.right;
    
    CGFloat containerWidth = CGRectGetWidth(self.frame) - itemContainerConfig.shareItemContainerViewMarginLeft - itemContainerConfig.shareItemContainerViewMarginRight;//容器宽度
    CGFloat containerHeight = itemHeight+marginTop+marginBottom;//容器高度
    CGFloat verticalGap = 15;//竖直间距
    CGFloat horizonalGap = columns>1?(containerWidth - itemWidth*columns - marginLeft - marginRight)/(columns-1):0;//水平间距
    if (self.platforms.count > columns) {
        containerHeight = itemHeight * rows + verticalGap*(rows-1) +marginTop+marginBottom;
    }
    CGRect containerFrame = CGRectMake(0, 0, containerWidth, containerHeight);
    
    _shareContainerview = [[UIScrollView alloc]initWithFrame:containerFrame];
    _shareContainerview.backgroundColor = itemContainerConfig.shareItemContainerViewBackgroundColor;
    _shareContainerview.pagingEnabled = YES;
    _shareContainerview.showsVerticalScrollIndicator = NO;
    _shareContainerview.showsHorizontalScrollIndicator = NO;
    
    __weak typeof(self)weakSelf = self;
//    __block NSInteger count = 0;
    [self.platforms enumerateObjectsUsingBlock:^(NSNumber * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitleColor:RGB(102,102,102,1) forState:UIControlStateNormal];
        btn.titleLabel.font = BX_SHARE_FONT_SIZE(11);
        [btn addTarget:weakSelf action:@selector(shareItemClick:) forControlEvents:UIControlEventTouchUpInside];
        BXSharePlatformType platformType = obj.unsignedIntegerValue;
        
        btn.tag = kBXSocialShareViewButtonBaseTag+platformType;

        switch (platformType) {
            case BXSharePlatformType_WeChat: {
                [btn setTitle:@"微信" forState:UIControlStateNormal];
                [btn setImage:BX_SHARE_BUNDLE_IMAGE(@"BXShareKit.bundle/share_wechat") forState:UIControlStateNormal];
            }
                break;
            case BXSharePlatformType_WeChatFriends: {
                [btn setTitle:@"朋友圈" forState:UIControlStateNormal];
                [btn setImage:BX_SHARE_BUNDLE_IMAGE(@"BXShareKit.bundle/share_friends") forState:UIControlStateNormal];
            }
                break;
            case BXSharePlatformType_QQ: {
                [btn setTitle:@"QQ" forState:UIControlStateNormal];
                [btn setImage:BX_SHARE_BUNDLE_IMAGE(@"BXShareKit.bundle/share_qq") forState:UIControlStateNormal];
            }
                break;
            case BXSharePlatformType_Qzone: {
                [btn setTitle:@"QQ空间" forState:UIControlStateNormal];
                [btn setImage:BX_SHARE_BUNDLE_IMAGE(@"BXShareKit.bundle/share_qq_qzone") forState:UIControlStateNormal];
            }
                break;
            case BXSharePlatformType_Sina:
            {
                [btn setTitle:@"新浪微博" forState:UIControlStateNormal];
                [btn setImage:BX_SHARE_BUNDLE_IMAGE(@"BXShareKit.bundle/sina_weibo") forState:UIControlStateNormal];
            }
                break;
            default:
                [btn setTitle:@"" forState:UIControlStateNormal];
                break;
        }
        
        NSInteger page = idx/itemsPerPage;
        NSInteger itemCountInPage = idx%itemsPerPage;
        
        CGRect itemFrame = CGRectMake(
                                      CGRectGetWidth(weakSelf.shareContainerview.frame)*page + marginLeft+ (itemWidth+horizonalGap)*(itemCountInPage%columns),
                                      marginTop + itemCountInPage/columns * (verticalGap+itemHeight),
                                      itemWidth,
                                      itemHeight);
        btn.frame = itemFrame;
        [btn btnTitleUnderImgWithHeight:13];
        [weakSelf.shareContainerview addSubview:btn];
    }];
    
    if (self.platforms.count <= itemsPerPage) {
        self.shareContainerview.contentSize = self.shareContainerview.frame.size;
        self.shareContainerview.scrollEnabled = NO;
    }else{

        NSInteger totalPages = ((self.platforms.count - 1)/itemsPerPage) + 1;
        self.shareContainerview.contentSize = CGSizeMake(CGRectGetWidth(self.shareContainerview.frame) * totalPages, CGRectGetHeight(self.shareContainerview.frame));
    }
    [self addSubview:self.shareContainerview];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectZero];
    [self addSubview:line];
    self.line = line;
}

- (void)updateFrames {
    
    CGRect selfFrame = self.frame;

    self.line.hidden = YES;
    BXShareUIConfig *uiConfig = [BXShareUIConfig sharedInstance];
    BXShareViewConfig *shareConfig = uiConfig.shareViewConfig;
    BXShareTitleViewConfig *titleConfig = uiConfig.shareTitleViewConfig;
    BXShareCancelControlConfig *cancelConfig = uiConfig.shareCancelControlConfig;
    BXShareItemContainerViewConfig *itemContainerViewConfig = uiConfig.shareItemContainerViewConfig;
    //title
    CGSize titleSize = [titleConfig.shareTitleViewTitleString sizeWithAttributes:@{NSFontAttributeName:titleConfig.shareTitleViewFont}];
    CGRect titleLabelFrame = CGRectMake(
                                        titleConfig.shareTitleViewMarginInsets.left,
                                        titleConfig.shareTitleViewMarginInsets.top,
                                        CGRectGetWidth(self.frame) - titleConfig.shareTitleViewMarginInsets.left - titleConfig.shareTitleViewMarginInsets.right,
                                        titleSize.height);
    self.titleLabel.frame = titleLabelFrame;

    //container
    CGRect containerFrame = self.shareContainerview.frame;
    containerFrame.origin.x = itemContainerViewConfig.shareItemContainerViewMarginLeft;
    containerFrame.origin.y = CGRectGetMaxY(self.titleLabel.frame) + titleConfig.shareTitleViewMarginInsets.bottom;
    self.shareContainerview.frame = containerFrame;
    
    //cancelButton
    [self bringSubviewToFront:self.cancelButton];
    if (cancelConfig.shareCancelControlLocation == BXShareCancelControlLocationBottom) {
        self.line.hidden = NO;
        CGRect lineFrame = CGRectZero;
        lineFrame.origin.x = shareConfig.separatorMargin;
        lineFrame.origin.y = CGRectGetMaxY(containerFrame);
        lineFrame.size.width = CGRectGetWidth(selfFrame) - CGRectGetMinX(lineFrame)*2;
        lineFrame.size.height = shareConfig.separatorHeight;
        self.line.frame = lineFrame;
        self.line.backgroundColor = shareConfig.separatorColor;
        
        CGRect cancelButtonFrame = CGRectMake(
                                              cancelConfig.shareCancelControlMarginInsets.left,
                                              CGRectGetMaxY(lineFrame) + cancelConfig.shareCancelControlMarginInsets.top,
                                              CGRectGetWidth(self.frame) - cancelConfig.shareCancelControlMarginInsets.left - cancelConfig.shareCancelControlMarginInsets.right,
                                              cancelConfig.shareCancelControlHeight);
        self.cancelButton.frame = cancelButtonFrame;
        selfFrame.size.height = CGRectGetMaxY(cancelButtonFrame) + cancelConfig.shareCancelControlMarginInsets.bottom;
        
    } else if (cancelConfig.shareCancelControlLocation == BXShareCancelControlLocationTopAndLeft) {
        CGRect cancelButtonFrame = CGRectMake(0, 0, cancelConfig.shareCancelControlHeight, cancelConfig.shareCancelControlHeight);
        self.cancelButton.frame = cancelButtonFrame;
        self.cancelButton.center = CGPointMake(cancelConfig.shareCancelControlMarginInsets.left + CGRectGetMidX(cancelButtonFrame), CGRectGetMidY(titleLabelFrame));

        selfFrame.size.height = CGRectGetMaxY(containerFrame);
    } else if (cancelConfig.shareCancelControlLocation == BXShareCancelControlLocationTopAndRight) {
        CGRect cancelButtonFrame = CGRectMake(0, 0, cancelConfig.shareCancelControlHeight, cancelConfig.shareCancelControlHeight);
        self.cancelButton.frame = cancelButtonFrame;
        self.cancelButton.center = CGPointMake(CGRectGetWidth(self.frame) - CGRectGetMidX(cancelButtonFrame) - cancelConfig.shareCancelControlMarginInsets.right, CGRectGetMidY(titleLabelFrame));

        selfFrame.size.height = CGRectGetMaxY(containerFrame);
    }
    
    selfFrame.size.height = CGRectGetHeight(selfFrame) + shareConfig.shareViewCornerRadius;
    if (@available(iOS 11.0, *)) {
        selfFrame.size.height = CGRectGetHeight(selfFrame) + [UIApplication sharedApplication].delegate.window.safeAreaInsets.bottom;
    }
    self.frame = selfFrame;
}


- (void)shareItemClick:(UIButton *)shareItem {
    if (self.itemClickHandler) {
        BXSharePlatformType platformType= shareItem.tag - kBXSocialShareViewButtonBaseTag;
        self.itemClickHandler(platformType);
    }
}

- (void)doNothing {}
@end
