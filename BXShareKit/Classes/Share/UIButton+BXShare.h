//
//  UIButton+BXShare.h
//  MaiMkt
//
//  Created by ayi on 2018/5/15.
//  Copyright © 2018 ayi. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, BXButtonType) {
    BXButtonTypeTitleImageRightAndLeft,
    BXButtonTypeTitleImageLeftAndRight,
    BXButtonTypeTitleImageTopAndBottom,
    BXButtonTypeTitleImageBottomAndTop,
};

@interface UIButton (BXShare)

- (void)btnTitleLeftImg;

- (void)configWithButtonType:(BXButtonType)buttonType margin:(CGFloat)margin;


@end
