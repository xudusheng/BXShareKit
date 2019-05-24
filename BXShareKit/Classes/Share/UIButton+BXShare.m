//
//  UIButton+BXShare.m
//  MaiMkt
//
//  Created by ayi on 2018/5/15.
//  Copyright © 2018 ayi. All rights reserved.
//

#import "UIButton+BXShare.h"

@implementation UIButton (BXShare)


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

- (void)btnTitleLeftImg{
    [self setTitleEdgeInsets:UIEdgeInsetsMake(0, - self.imageView.frame.size.width, 0, self.imageView.frame.size.width)];
    [self setImageEdgeInsets:UIEdgeInsetsMake(0, self.titleLabel.bounds.size.width, 0, -self.titleLabel.bounds.size.width - 10)];
}

- (void)btnImgUnderTitleWithHeight:(CGFloat )height{
    CGFloat img_W = self.imageView.frame.size.width;
    CGFloat img_H = self.imageView.frame.size.height;
    CGFloat tit_W = self.titleLabel.frame.size.width;
    CGFloat tit_H = self.titleLabel.frame.size.height;
    
    self.titleEdgeInsets = (UIEdgeInsets){
        .top    = - (tit_H / 2 + height / 2),
        .left   = - (img_W / 2),
        .bottom =   (tit_H / 2 + height / 2),
        .right  =   (img_W / 2),
    };
    
    self.imageEdgeInsets = (UIEdgeInsets){
        .top    =   (img_H / 2 + height / 2),
        .left   =   (tit_W / 2),
        .bottom = - (img_H / 2 + height / 2),
        .right  = - (tit_W / 2),
    };
}

@end
