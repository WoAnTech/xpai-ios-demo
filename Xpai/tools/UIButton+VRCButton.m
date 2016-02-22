//
//  UIButton+VRCButton.m
//  Xpai
//
//  Created by  cLong on 16/1/12.
//  Copyright © 2016年 北京沃安科技有限公司. All rights reserved.
//

#import "UIButton+VRCButton.h"

@implementation UIButton (VRCButton)

+(instancetype)ButtonWithFrame:(CGRect)frame image:(NSString *)imageName {
    UIButton * button = [[UIButton alloc]initWithFrame:frame];
    [button setBackgroundImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    return button;
}

@end
