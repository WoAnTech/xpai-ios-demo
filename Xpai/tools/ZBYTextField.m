//
//  ZBYTextField.m
//  Xpai
//
//  Created by  cLong on 16/1/11.
//  Copyright © 2016年  沃安科技. All rights reserved.
//

#import "ZBYTextField.h"

@implementation ZBYTextField

+(instancetype)initTextFieldWith:(NSString *)Name frame:(CGRect )frame {
    ZBYTextField * text = [[ZBYTextField alloc]initWithFrame:frame];
    text.placeholder = Name;
    text.borderStyle = UITextBorderStyleRoundedRect;
    text.clearButtonMode = UITextFieldViewModeAlways;
    text.clearsOnBeginEditing = NO;
    
    return text;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
