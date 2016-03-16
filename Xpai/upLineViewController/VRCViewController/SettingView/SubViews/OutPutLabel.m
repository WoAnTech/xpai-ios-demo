//
//  outPutLabel.m
//  Xpai
//
//  Created by  cLong on 16/1/29.
//  Copyright © 2016年 B-Star. All rights reserved.
//

#import "outPutLabel.h"
#import "ZBYTextField.h"
#import "CLSettingConfig.h"

@interface outPutLabel ()<UITextFieldDelegate>
{
    ZBYTextField * _outPutLabel;
}

@end

@implementation outPutLabel

-(void)dealloc {
    [_outPutLabel release];
    [super dealloc];
}

-(instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = KtitleColor;
        [self createSubViews];
    }
    return self;
}

-(void)createSubViews {
    UILabel * titiLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.width, 30)];
    titiLabel.textAlignment = NSTextAlignmentCenter;
    titiLabel.text = @"输出格式标签";
    titiLabel.font = [UIFont boldSystemFontOfSize:20.0f];
    titiLabel.textColor = [UIColor whiteColor];
    titiLabel.backgroundColor = KtitleColor;
    [self addSubview:titiLabel];
    
    
    _outPutLabel = [ZBYTextField initTextFieldWith:nil frame:CGRectMake(5, titiLabel.maxY + 5, self.width - 10, 30)];
    _outPutLabel.delegate = self;
    _outPutLabel.text = [CLSettingConfig sharedInstance].outPutTag;
    [self addSubview:_outPutLabel];
    [titiLabel release];
}

-(void)textFieldDidEndEditing:(UITextField *)textField {
    if (textField.text.length == 0) {
        [CLSettingConfig sharedInstance].outPutTag = nil;
    }else {
        [CLSettingConfig sharedInstance].outPutTag = textField.text;
    }
    
    [[CLSettingConfig sharedInstance] WriteData];
    kNSNotificationCenter;
}

@end
