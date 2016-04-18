//
//  SetFPSView.m
//  Xpai
//
//  Created by  cLong on 16/4/18.
//  Copyright © 2016年 B-Star. All rights reserved.
//

#import "SetFPSView.h"
#import "CLSettingConfig.h"

@interface SetFPSView ()
{
    UILabel * _titleLabel;
    UISlider * _MaxSlider;
    UISlider * _MinSlider;
    UILabel * _MaxLB;
    UILabel * _MinLB;
    UIButton * _comfirmBN;
}

@end

@implementation SetFPSView


-(void)dealloc {
    [_titleLabel release];
    [_MaxSlider release];
    [_MinSlider release];
    [_comfirmBN release];
    [_MaxLB release];
    [_MinLB release];
    [super dealloc];
    
}

-(instancetype)initWithFrame:(CGRect)frame {
    if ([super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        self.layer.borderWidth = 2;
        self.layer.borderColor = KtitleColor.CGColor;
        [self createSubView];
    }
    return self;
}

-(void)createSubView {
    [self addTitleLB];
    [self addSlider];
    [self addParameterLB];
    [self addComfirmBN];
}

-(void)setAlpha:(CGFloat)alpha {
    [super setAlpha:alpha];
    if (alpha == 0) {
        [[CLSettingConfig sharedInstance]loadData];
        int Max = [CLSettingConfig sharedInstance].MaxFPS;
        int Min = [CLSettingConfig sharedInstance].MinFPS;
        
        _MinSlider.value = Min;
        _MaxSlider.value = Max;
        _MaxLB.text = [NSString stringWithFormat:@"最大FPS：%02d",Max];
        _MinLB.text = [NSString stringWithFormat:@"最小FPS：%02d",Min];
    }
}

-(void)addTitleLB {
    _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.width, 30)];
    _titleLabel.text = @"设置帧率范围";
    _titleLabel.textColor = [UIColor whiteColor];
    _titleLabel.backgroundColor = KtitleColor;
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.font = [UIFont boldSystemFontOfSize:20.0f];
    [self addSubview:_titleLabel];
}

-(void)addSlider {
    CGFloat lbH =  40;
    CGFloat lbW = 20;
    [[CLSettingConfig sharedInstance]loadData];
    
    UILabel * MaxMinLB = [[UILabel alloc]initWithFrame:CGRectMake(10, _titleLabel.maxY + 10, lbW, lbH)];
    MaxMinLB.text = @"1";
    MaxMinLB.font = [UIFont boldSystemFontOfSize:15.0f];
    [self addSubview:MaxMinLB];
    [MaxMinLB release];
    
    _MaxSlider = [[UISlider alloc]initWithFrame:CGRectMake(MaxMinLB.maxX + 10, MaxMinLB.y, self.width - 40 - lbW * 2, lbH)];
    _MaxSlider.maximumValue = 30;
    _MaxSlider.minimumValue = 1;
    _MaxSlider.value = [CLSettingConfig sharedInstance].MaxFPS;
    [_MaxSlider addTarget:self action:@selector(ChangeMaxFPS) forControlEvents:UIControlEventValueChanged];
    [self addSubview:_MaxSlider];
    
    UILabel * MaxMaxLB = [[UILabel alloc]initWithFrame:CGRectMake(_MaxSlider.maxX + 10, MaxMinLB.y, lbW, lbH)];
    MaxMaxLB.text = @"30";
    MaxMaxLB.font = [UIFont boldSystemFontOfSize:15.0f];
    [self addSubview:MaxMaxLB];
    [MaxMaxLB release];
    
    
    UILabel * MinMinLB = [[UILabel alloc]initWithFrame:CGRectMake(10, _MaxSlider.maxY + 10, lbW, lbH)];
    MinMinLB.text = @"1";
    MinMinLB.font = [UIFont boldSystemFontOfSize:15.0f];
    [self addSubview:MinMinLB];
    [MinMinLB release];
    
    _MinSlider = [[UISlider alloc]initWithFrame:CGRectMake(MinMinLB.maxX + 10, MinMinLB.y, self.width - 40 - lbW * 2, lbH)];
    _MinSlider.minimumValue = 1;
    _MinSlider.maximumValue = 30;
    _MinSlider.value = [CLSettingConfig sharedInstance].MinFPS;
    [_MinSlider addTarget: self action:@selector(changeMinFPS) forControlEvents:UIControlEventValueChanged];
    [self addSubview:_MinSlider];
    
    UILabel * MinMaxLB = [[UILabel alloc]initWithFrame:CGRectMake(_MinSlider.maxX + 10, _MinSlider.y, lbW, lbH)];
    MinMaxLB.text = @"30";
    MinMaxLB.font = [UIFont boldSystemFontOfSize:15.0f];
    [self addSubview:MinMaxLB];
    [MinMaxLB release];
}

-(void) addParameterLB {
    _MaxLB = [[UILabel alloc]initWithFrame:CGRectMake(10, _MinSlider.maxY + 10, 100, 10)];
    _MaxLB.text = [NSString stringWithFormat:@"最大FPS：%02d",[CLSettingConfig sharedInstance].MaxFPS];
    _MaxLB.font = [UIFont boldSystemFontOfSize:10.0f];
    [self addSubview:_MaxLB];
    
    _MinLB = [[UILabel alloc]initWithFrame:CGRectMake(10, _MaxLB.maxY + 5, 100, 10)];
    _MinLB.text = [NSString stringWithFormat:@"最小FPS：%02d",[CLSettingConfig sharedInstance].MinFPS];
    _MinLB.font = [UIFont boldSystemFontOfSize:10.0f];
    [self addSubview:_MinLB];
}

-(void)addComfirmBN {
    CGFloat lbw = 60;
    CGFloat lbh = 40;
    _comfirmBN = [UIButton buttonWithType:UIButtonTypeSystem];
    _comfirmBN.frame = CGRectMake(self.width - 10 - lbw, _MinSlider.maxY + 8, lbw, lbh);
    [_comfirmBN setTitle:@"确定" forState:UIControlStateNormal];
    [_comfirmBN setTitleColor:KtitleColor forState:UIControlStateNormal];
    [_comfirmBN addTarget:self action:@selector(comfirmParameter) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_comfirmBN];
}

#pragma mark ---按钮事件

-(void)comfirmParameter {
    [_delegate SetFPSWithMax:_MaxSlider.value Min:_MinSlider.value];
    [CLSettingConfig sharedInstance].MaxFPS = _MaxSlider.value;
    [CLSettingConfig sharedInstance].MinFPS = _MinSlider.value;
    [[CLSettingConfig sharedInstance] WriteData];
    kNSNotificationCenter;

}

-(void)ChangeMaxFPS {
    if (_MaxSlider.value < _MinSlider.value) {
        _MinSlider.value = _MaxSlider.value;
        _MinLB.text = [NSString stringWithFormat:@"最小FPS：%02d",(int)_MinSlider.value];

    }
    _MaxLB.text = [NSString stringWithFormat:@"最大FPS：%02d",(int)_MaxSlider.value];
}

-(void)changeMinFPS {
    if (_MinSlider.value > _MaxSlider.value) {
        _MaxSlider.value = _MinSlider.value;
        _MaxLB.text = [NSString stringWithFormat:@"最大FPS：%02d",(int)_MaxSlider.value];

    }
    _MinLB.text = [NSString stringWithFormat:@"最小FPS：%02d",(int)_MinSlider.value];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
