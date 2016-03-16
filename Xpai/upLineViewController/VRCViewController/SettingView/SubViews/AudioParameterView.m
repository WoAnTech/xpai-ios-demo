//
//  AudioParameterView.m
//  Xpai
//
//  Created by  cLong on 16/1/18.
//  Copyright © 2016年 B-Star. All rights reserved.
//

#import "AudioParameterView.h"
#import "CLSettingConfig.h"

@interface AudioParameterView ()
{
    
    UIView * _NBView;
    UIView * _ACCView;
    UIView *_backGroundView;
    
    UISegmentedControl * _segmented;
    UIButton * _samplingBT;
    
    UILabel * _BitNumLB;
    
    UISlider * _BitSlider;
}

@end

@implementation AudioParameterView

-(void)dealloc {
    [_segmented release];
    [_NBView release];
    [_ACCView release];
    [_backGroundView release];
    [_samplingBT release];
    [_BitNumLB release];
    [_BitSlider release];
    [super dealloc];
}

-(instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = KtitleColor;
        [self addSubViews];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeButtonTitle) name:@"numOfSamping" object:nil];
    }
    return self;
}

-(void)addSubViews {
    UILabel * titiLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.width, 30)];
    titiLabel.textAlignment = NSTextAlignmentCenter;
    titiLabel.text = @"设置录制类型";
    titiLabel.font = [UIFont boldSystemFontOfSize:20.0f];
    titiLabel.textColor = [UIColor whiteColor];
    titiLabel.backgroundColor = KtitleColor;
    [self addSubview:titiLabel];
    [titiLabel release];
    
    _backGroundView = [[UIView alloc]initWithFrame:CGRectMake(2, titiLabel.maxY, self.width - 4, 30)];
    _backGroundView.backgroundColor = [UIColor whiteColor];
    [self addSubview:_backGroundView];
    
    NSArray * segmentedArr = [[NSArray alloc]initWithObjects:@"Amr-NB",@"ACC", nil];
    _segmented = [[UISegmentedControl alloc]initWithItems:segmentedArr];
    _segmented.frame = CGRectMake(self.width / 2 - 80, 0, 160, 30);
    [_segmented addTarget:self action:@selector(changeView) forControlEvents:UIControlEventValueChanged];
    if ((int)[CLSettingConfig sharedInstance].audioParameter == 1) {
        _segmented.selectedSegmentIndex = 0;
    }else {
        _segmented.selectedSegmentIndex = 1;
    }
    
    [_backGroundView addSubview:_segmented];
    [segmentedArr release];
    
    
    [self NBView];
    [self ACCView];
    
}

-(void)NBView {
    _NBView = [[UIView alloc]initWithFrame:CGRectMake(2, _backGroundView.maxY, self.width - 4, self.height - _backGroundView.maxY - 2)];
    _NBView.backgroundColor = [UIColor whiteColor];
  
    [self addSubview:_NBView];
    UILabel * NBLB1 = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 100, 30)];
    NBLB1.text = @"采样率：8000";
    NBLB1.font = [UIFont systemFontOfSize:15.0];
    
    UILabel * NBLB2 = [[UILabel alloc]initWithFrame:CGRectMake(10, NBLB1.maxY + 10, 150, 30)];
    NBLB2.text = @"比特率：12200";
    NBLB2.font = [UIFont systemFontOfSize:15.0];
    if ([CLSettingConfig sharedInstance].audioParameter == 2) {
        _NBView.hidden = YES;
    }
    
    [_NBView addSubview:NBLB1];
    [_NBView addSubview:NBLB2];
    [NBLB1 release];
    [NBLB2 release];
    
}

-(void)ACCView {
    _ACCView = [[UIView alloc]initWithFrame:CGRectMake(2, _backGroundView.maxY, self.width - 4, self.height - _backGroundView.maxY - 2)];
    _ACCView.backgroundColor = [UIColor whiteColor];
    if ([CLSettingConfig sharedInstance].audioParameter == 1) {
        _ACCView.hidden = YES;
    }
    [self addSubview:_ACCView];
    UILabel * ACCLB1 = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 80, 30)];
    ACCLB1.text = @"采样率：";
    ACCLB1.font = [UIFont systemFontOfSize:15.0];
    [_ACCView addSubview:ACCLB1];
   
    _samplingBT = [[UIButton alloc]initWithFrame:CGRectMake(self.width - 90, 10, 50, 30)];
    [_samplingBT setBackgroundImage:[UIImage imageNamed:@"6"] forState:UIControlStateNormal];
    [_samplingBT setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_samplingBT setTitle:[NSString stringWithFormat:@"%ld",(long)[CLSettingConfig sharedInstance].audioSampling] forState:UIControlStateNormal];
    _samplingBT.titleLabel.font = [UIFont systemFontOfSize:15.0f];
    [_samplingBT addTarget:self action:@selector(changeSampling) forControlEvents:UIControlEventTouchUpInside];
    [_ACCView addSubview:_samplingBT];
     [ACCLB1 release];
    
    UILabel * ACCLB2 = [[UILabel alloc]initWithFrame:CGRectMake(10, ACCLB1.maxY + 5, 80, 30)];
    ACCLB2.text = @"比特率：";
    ACCLB2.font = [UIFont systemFontOfSize:15.0];
    [_ACCView addSubview:ACCLB2];
    
    _BitNumLB = [[UILabel alloc]initWithFrame:CGRectMake(self.width - 90, ACCLB2.y, 80, 30)];
    _BitNumLB.text = [NSString stringWithFormat:@"%ld",(long)[CLSettingConfig sharedInstance].audioBit];
    _BitNumLB.font = [UIFont systemFontOfSize:15.0];
    [_ACCView addSubview:_BitNumLB];
    
    
    _BitSlider = [[UISlider alloc]initWithFrame:CGRectMake(10, ACCLB2.maxY + 5, self.width - 20, 30)];
    _BitSlider.minimumValue =4000 ;
    _BitSlider.maximumValue =16000;
    _BitSlider.value = [CLSettingConfig sharedInstance].audioBit;
    [_BitSlider addTarget:self action:@selector(changeBitNum:) forControlEvents:UIControlEventValueChanged];
    [_BitSlider addTarget:self action:@selector(saveBitNum:) forControlEvents:UIControlEventTouchUpInside];
   
    [_ACCView addSubview:_BitSlider];
}

//改变比特率
-(void)changeBitNum:(UISlider *)slider {
    _BitNumLB.text = [NSString stringWithFormat:@"%d",(int)slider.value];
   }
//保存比特率
-(void)saveBitNum:(UISlider *)slider {
    [CLSettingConfig sharedInstance].audioBit = slider.value;
    [[CLSettingConfig sharedInstance] WriteData];

}

//改变采样率
-(void)changeSampling {
    [_delegate ShowSamplingView];
}

-(void)changeView {
    if (_segmented.selectedSegmentIndex == 0) {
        _NBView.hidden = NO;
        _ACCView.hidden = YES;
        [CLSettingConfig sharedInstance].audioParameter = 1;
    }else {
        _NBView.hidden = YES;
        _ACCView.hidden = NO;
        [CLSettingConfig sharedInstance].audioParameter = 2;
    }
    [[CLSettingConfig sharedInstance] WriteData];
    
    NSLog(@"selected%ld",(long)_segmented.selectedSegmentIndex);
    
    kNSNotificationCenter;
    KaudioSamlingNotication;
}

-(void)changeButtonTitle {
    [_samplingBT setTitle:[NSString stringWithFormat:@"%ld",(long)[CLSettingConfig sharedInstance].audioSampling] forState:UIControlStateNormal];
}


@end
