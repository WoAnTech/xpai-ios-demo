//
//  UILabel+VRCLabel.m
//  Xpai
//
//  Created by  cLong on 16/1/12.
//  Copyright © 2016年 B-Star. All rights reserved.
//

#import "UILabel+VRCLabel.h"

@implementation UILabel (VRCLabel)

+(instancetype)labelWithFrame:(CGRect)frame text:(NSString *)text {
    UILabel * label = [[UILabel alloc]initWithFrame:frame];
    label.text = text;
    label.font = [UIFont boldSystemFontOfSize:15.0];
    label.textAlignment = NSTextAlignmentRight;
    
    return label;
}

@end
