//
//  NetOverTimeView.m
//  Xpai
//
//  Created by  cLong on 16/1/15.
//  Copyright © 2016年 B-Star. All rights reserved.
//

#import "NetOverTimeView.h"
#import "CLSettingConfig.h"

@interface NetOverTimeView ()
{
    UILabel * _titLB;
    UISlider * _slider;
}

@end

@implementation NetOverTimeView

-(void)dealloc {
    [_titLB release];
    [_slider release];
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
    _titLB.text = @"设置网络超时时间";
    _titLB.backgroundColor = KtitleColor;
    _titLB.textAlignment = NSTextAlignmentCenter;
    _titLB.font = [UIFont boldSystemFontOfSize:20.0f];
    [self addSubview:_titLB];
    
    
    CGFloat lbH =  40;
    CGFloat lbW = self.width /6;
    
    
    UILabel * minNumLB = [[UILabel alloc]initWithFrame:CGRectMake(10, _titLB.maxY + 10, 50, lbH)];
    minNumLB.text = @"10";
    [self addSubview:minNumLB];
    [minNumLB release];
    
    
    _slider = [[UISlider alloc]initWithFrame:CGRectMake(minNumLB.maxX + 10, minNumLB.y, self.width - 40 - lbW * 2, lbH)];
    _slider.minimumValue = 10;
    _slider.maximumValue = 100;
    _slider.value = [CLSettingConfig sharedInstance].NetOverTime;
    [_slider addTarget:self action:@selector(changValue:) forControlEvents:UIControlEventValueChanged];
    [self addSubview:_slider];
    
    UILabel * MaxNumLB = [[UILabel alloc]initWithFrame:CGRectMake(_slider.maxX + 10, minNumLB.y, 50, lbH)];
    MaxNumLB.text = @"100";
    [self addSubview:MaxNumLB];
    [MaxNumLB release];
    
}

-(void)changValue:(UISlider *)slider{
    NSLog(@"%f",slider.value);
    [CLSettingConfig sharedInstance].NetOverTime = slider.value;
    [[CLSettingConfig sharedInstance] WriteData];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"resolution" object:nil];
}


@end
