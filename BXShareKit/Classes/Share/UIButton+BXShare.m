//
//  UIButton+BXShare.m
//  MaiMkt
//
//  Created by ayi on 2018/5/15.
//  Copyright © 2018 ayi. All rights reserved.
//

#import "UIButton+BXShare.h"

@implementation UIButton (BXShare)

- (void)configWithButtonType:(BXButtonType)buttonType margin:(CGFloat)margin {
    switch (buttonType) {
        case BXButtonTypeTitleImageRightAndLeft:
            [self btnTitleRightImgWithMargin:margin];
            break;
        case BXButtonTypeTitleImageLeftAndRight:
            [self btnTitleLeftImgWithMargin:margin];
            break;
        case BXButtonTypeTitleImageBottomAndTop:
            [self btnTitleUnderImgWithMargin:margin];
            break;
        case BXButtonTypeTitleImageTopAndBottom:
            [self btnImgUnderTitleWithMargin:margin];
            break;
    }
}
- (void)btnTitleUnderImgWithMargin:(CGFloat )margin{
    CGSize imageSize = self.imageView.frame.size;
    CGSize titleSize = self.titleLabel.frame.size;
    CGSize textSize = [self.titleLabel.text sizeWithAttributes:@{NSFontAttributeName:self.titleLabel.font}];
    CGSize frameSize = CGSizeMake(ceilf(textSize.width), ceilf(textSize.height));
    if (titleSize.width + 0.5 < frameSize.width) {
        titleSize.width = frameSize.width;
    }
    CGFloat totalHeight = (imageSize.height + titleSize.height) + margin;
    self.imageEdgeInsets = UIEdgeInsetsMake(- (totalHeight - imageSize.height), 0.0, 0.0, - titleSize.width);
    self.titleEdgeInsets = UIEdgeInsetsMake(totalHeight - titleSize.height , -self.imageView.frame.size.width, 0, 0);
}

- (void)btnImgUnderTitleWithMargin:(CGFloat)margin {
    CGSize imageSize = self.imageView.frame.size;
    CGSize titleSize = self.titleLabel.frame.size;
    CGSize textSize = [self.titleLabel.text sizeWithAttributes:@{NSFontAttributeName:self.titleLabel.font}];
    CGSize frameSize = CGSizeMake(ceilf(textSize.width), ceilf(textSize.height));
    if (titleSize.width + 0.5 < frameSize.width) {
        titleSize.width = frameSize.width;
    }
    CGFloat totalHeight = (imageSize.height + titleSize.height) + margin;
    self.titleEdgeInsets = UIEdgeInsetsMake(- (totalHeight - titleSize.height), -imageSize.width, 0.0, 0.0);
    self.imageEdgeInsets = UIEdgeInsetsMake(totalHeight - imageSize.height , 0.0, 0, -titleSize.width);
}

- (void)btnTitleLeftImgWithMargin:(CGFloat)margin{
    
    CGSize imageSize = self.imageView.frame.size;
    CGSize titleSize = self.titleLabel.frame.size;
    CGSize textSize = [self.titleLabel.text sizeWithAttributes:@{NSFontAttributeName:self.titleLabel.font}];
    CGSize frameSize = CGSizeMake(ceilf(textSize.width), ceilf(textSize.height));
    if (titleSize.width + 0.5 < frameSize.width) {
        titleSize.width = frameSize.width;
    }
    CGFloat totalWidth = (imageSize.width + titleSize.width) + margin/2.0;
    
    [self setTitleEdgeInsets:UIEdgeInsetsMake(0, - (totalWidth - textSize.width), 0, (totalWidth - textSize.width))];
    [self setImageEdgeInsets:UIEdgeInsetsMake(0, (totalWidth-imageSize.width), 0, -(totalWidth-imageSize.width))];
}

- (void)btnTitleRightImgWithMargin:(CGFloat)margin{
    CGSize imageSize = self.imageView.frame.size;
    CGSize titleSize = self.titleLabel.frame.size;
    CGSize textSize = [self.titleLabel.text sizeWithAttributes:@{NSFontAttributeName:self.titleLabel.font}];
    CGSize frameSize = CGSizeMake(ceilf(textSize.width), ceilf(textSize.height));
    if (titleSize.width + 0.5 < frameSize.width) {
        titleSize.width = frameSize.width;
    }
    CGFloat totalWidth = (imageSize.width + titleSize.width) + margin/2.0;
    
    [self setTitleEdgeInsets:UIEdgeInsetsMake(0, margin/2.0, 0, -margin/2.0)];
    [self setImageEdgeInsets:UIEdgeInsetsMake(0, -margin/2.0, 0, margin/2.0)];
}

@end
