//
//  BXShareDefine.h
//  BXShareDemo
//
//  Created by Hmily on 2019/4/9.
//  Copyright © 2019 Document. All rights reserved.
//

#define BX_SHARE_FONT_SIZE(__size__) [UIFont systemFontOfSize:__size__]
#define RGB(r, g, b,a)   [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]
#define BX_SHARE_BUNDLE_IMAGE(__name__)  [UIImage imageNamed:__name__]

#define IS_IPHONE_X_SHARE \
({BOOL isPhoneX = NO;\
if (@available(iOS 11.0, *)) {\
isPhoneX = [[UIApplication sharedApplication] delegate].window.safeAreaInsets.bottom > 0.0;\
}\
(isPhoneX);})

#define BTN_SHARE_WIDTH 65
#define BTN_SHARE_HEIGHT 65
