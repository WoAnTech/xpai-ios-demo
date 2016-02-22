//
//  BitStreamView.m
//  Xpai
//
//  Created by  cLong on 16/1/15.
//  Copyright © 2016年 北京沃安科技有限公司. All rights reserved.
//

#import "BitStreamView.h"
#import "CLSettingConfig.h"

@interface BitStreamView ()
{
    UILabel * _titLB;
    UISlider * _slider;
}

@end

@implementation BitStreamView

-(void)dealloc {
    [_titLB release];
    [super dealloc];
}

-(instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor whiteColor];
        [self addSubViews];
    }
    return self;
}

-(void)addSubViews {
    _titLB = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.width, 30)];
    _titLB.text = @"设置视频码流";
    _titLB.backgroundColor = KtitleColor;
    _titLB.textAlignment = NSTextAlignmentCenter;
    _titLB.font = [UIFont boldSystemFontOfSize:20.0f];
    [self addSubview:_titLB];
    
    
    CGFloat lbH =  40;
    CGFloat lbW = self.width /6;
    
    
    UILabel * minNumLB = [[UILabel alloc]initWithFrame:CGRectMake(10, _titLB.maxY + 10, 50, lbH)];
    minNumLB.text = @"200";
    [self addSubview:minNumLB];
    [minNumLB release];
    
    
    _slider = [[UISlider alloc]initWithFrame:CGRectMake(minNumLB.maxX + 10, minNumLB.y, self.width - 40 - lbW * 2, lbH)];
    _slider.minimumValue = 200;
    _slider.maximumValue = 10240;
    _slider.value = [CLSettingConfig sharedInstance].BitStream;
    [_slider addTarget:self action:@selector(changValue:) forControlEvents:UIControlEventValueChanged];
    [self addSubview:_slider];
    
    UILabel * MaxNumLB = [[UILabel alloc]initWithFrame:CGRectMake(_slider.maxX + 10, minNumLB.y, 50, lbH)];
    MaxNumLB.text = @"10240";
    [self addSubview:MaxNumLB];
    [MaxNumLB release];
    
}

-(void)changValue:(UISlider *)slider{
    NSLog(@"%f",slider.value);
    [CLSettingConfig sharedInstance].BitStream = slider.value;
    [[CLSettingConfig sharedInstance] WriteData];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"resolution" object:nil];
}

@end
