//
//  ViedoPlayViewController.m
//  Xpai
//
//  Created by  cLong on 16/1/20.
//  Copyright © 2016年 B-Star. All rights reserved.
//

#import "ViedoPlayViewController.h"
#import "WoanPlayerInterface.h"

@interface ViedoPlayViewController ()
{
    WoanPlayerInterface * _player ; //播放管理者
    UIView * _showViedoPlay;//播放控制页
    UIView * _playView;//播放视频页
    
    UILabel * _currentTimeLB;//当前时间LB
    UILabel * _MAXTimeLB;//总时间LB
    UISlider * _ProgressTimeSlider;//进度条
    
    NSTimer * _timer;
    
    UIButton * playBN;
    UIButton * RotateBN;
    
    BOOL isPlay;
    
}
@end

@implementation ViedoPlayViewController

-(void)dealloc {
    [_player release];
    if (_PlayFileURL) {
        [_PlayFileURL release];
    }
    [_showViedoPlay release];
    [_currentTimeLB release];
    [_MAXTimeLB release];
//    [_timer release];
    [_ProgressTimeSlider release];
    [playBN release];
    [RotateBN release];
    [super dealloc];
}

-(void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    
    
    [self initView];//创建控制页面
    [self createNotificationCentre];//通知中心

    [self CreatePlayView];//创建播放页面
     _timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerWithViedo) userInfo:nil repeats:YES];
    
    [_timer setFireDate:[NSDate distantFuture]];
    
}

#pragma mark --改变时间LB
//改变时间LB
-(void)changeLB {
    int hour = [_player getDuration] / 3600;
    int min =  ([_player getDuration] - hour * 3600) / 60;
    int second = [_player getDuration] - hour * 3600 - min *  60;
    NSLog(@"%d %d %d",hour,min,second);
    NSLog(@"%@",_MAXTimeLB);
    _MAXTimeLB.text = [NSString stringWithFormat:@"%02d:%02d:%02d",hour,min,second];
    NSLog(@"%@",_MAXTimeLB);
    
    _ProgressTimeSlider.minimumValue = 0;
    _ProgressTimeSlider.maximumValue = [_player getDuration];
    
    
    [_timer setFireDate:[NSDate distantPast]];
    
}

//计时器方法
-(void)timerWithViedo {
    NSLog(@"%f",[_player getCurrentPlaybackTime]);
    int hour = [_player getCurrentPlaybackTime] / 3600;
    int min =  ([_player getCurrentPlaybackTime] - hour * 3600) / 60;
    int second = [_player getCurrentPlaybackTime] - hour * 3600 - min *  60;
    NSLog(@"%d %d %d",hour,min,second);
    _currentTimeLB.text = [NSString stringWithFormat:@"%02d:%02d:%02d",hour,min,second];
    _ProgressTimeSlider.value = [_player getCurrentPlaybackTime];
    
    NSLog(@"播放时间%f %f",[_player getCurrentPlaybackTime],[_player getDuration]);
}


#pragma mark 创建通知中心
-(void)createNotificationCentre {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveDuration:) name:WoanPlayerLoadDidPreparedNotification object:nil];//初始化结束
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playOver) name:WoanPlayerPlaybackDidFinishNotification object:nil];//播放结束
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationWillResignActive:)
                                                 name:UIApplicationWillResignActiveNotification object:nil]; //监听是否触发home键挂起程序.
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationDidBecomeActive:)
                                                 name:UIApplicationDidBecomeActiveNotification object:nil]; //监听是否重新进入程序.
}

#pragma mark --搭建界面
//创建播放页面
-(void)CreatePlayView {

    _player = [[WoanPlayerInterface alloc]initWithContentString:_PlayFileURL parameters:nil];//初始化播放管理者
    
    _playView = [_player getPlayViewWithFrame:self.view.bounds];
    _playView.contentMode = UIViewContentModeScaleAspectFit;
    _playView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleBottomMargin;
    [self.view addSubview:_playView];
    [_player prepareToPlay];
    isPlay = YES;
    [self.view sendSubviewToBack:_playView];
    
    NSLog(@"DurationTime%f",[_player getDuration]);

    
}

//创建控制页面
-(void)initView {
    //控制页面背景
    _showViedoPlay = [[UIView alloc]initWithFrame:self.view.bounds];
    _showViedoPlay.contentMode = UIViewContentModeScaleAspectFit;
    _showViedoPlay.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleBottomMargin;
    _showViedoPlay.backgroundColor = [UIColor blackColor];
    _showViedoPlay.alpha = 0;
    _showViedoPlay.userInteractionEnabled = YES;
    [self.view addSubview:_showViedoPlay];
    
    //底部按钮视图
    UIImageView * buttonView = [[UIImageView alloc]initWithFrame:CGRectMake(0, _showViedoPlay.height - 80, kScreenW, 80)];
    buttonView.backgroundColor = [UIColor blackColor];
    buttonView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleTopMargin;
    buttonView.image = [UIImage imageNamed:@"bottomView"];
    buttonView.userInteractionEnabled = YES;
    [_showViedoPlay addSubview:buttonView];
    
    //旋屏按钮
     RotateBN = [[UIButton alloc]initWithFrame:CGRectMake(buttonView.width - 50, buttonView.height - 40, 40, 30)];
    [RotateBN setBackgroundImage:[UIImage imageNamed:@"fitMode"] forState:UIControlStateNormal];
    [RotateBN addTarget:self action:@selector(RotateView) forControlEvents:UIControlEventTouchUpInside];
    RotateBN.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleLeftMargin |UIViewAutoresizingFlexibleHeight;
    [buttonView addSubview:RotateBN];
    
    //暂停播放按钮
     playBN = [[UIButton alloc]initWithFrame:CGRectMake(buttonView.width / 2 - 20,40, 40, 40)];
    [playBN setBackgroundImage:[UIImage imageNamed:@"pauseBtn"] forState:UIControlStateNormal];
    [playBN addTarget:self action:@selector(playViedo:) forControlEvents:UIControlEventTouchUpInside];
    
    [buttonView addSubview:playBN];
    
    //当前时间LB
    _currentTimeLB = [[UILabel alloc]initWithFrame:CGRectMake(5, 0, 75, 40)];
    _currentTimeLB.text = @"00:00:00";
    _currentTimeLB.textColor = KtitleColor;
    [buttonView addSubview:_currentTimeLB];
    
    //进度条
    _ProgressTimeSlider = [[UISlider alloc]initWithFrame:CGRectMake(_currentTimeLB.maxX + 5, 0, buttonView.width - 20 - 150, 40)];
    [_ProgressTimeSlider addTarget:self action:@selector(changeViedoTime:) forControlEvents:UIControlEventTouchUpInside];
    [buttonView addSubview:_ProgressTimeSlider];
    
    //总时长
    _MAXTimeLB = [[UILabel alloc]initWithFrame:CGRectMake(_ProgressTimeSlider.maxX + 5, 0, 75, 40)];
    _MAXTimeLB.textColor = KtitleColor;
    _MAXTimeLB.text = @"00:00:00";
    [buttonView addSubview:_MAXTimeLB];
    
    //退出按钮
    UIButton * finishBN = [[UIButton alloc]initWithFrame:CGRectMake(5, 40, 40, 30)];
    [finishBN setImage:[UIImage imageNamed:@"backBtn"] forState:UIControlStateNormal];
    [finishBN addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [buttonView addSubview:finishBN];
    
    [finishBN release];
    [buttonView release];
}

#pragma mark --按钮点击实现
//旋转
-(void)RotateView {
    if (_playView.contentMode == UIViewContentModeScaleAspectFit) {
        if ([[UIDevice currentDevice] respondsToSelector:@selector(setOrientation:)]) {
            [[UIDevice currentDevice] performSelector:@selector(setOrientation:) withObject:(id)UIInterfaceOrientationLandscapeRight];
        }
        _playView.contentMode = UIViewContentModeScaleToFill;
        NSLog(@"1");
    }else {
        if ([[UIDevice currentDevice] respondsToSelector:@selector(setOrientation:)]) {
            [[UIDevice currentDevice] performSelector:@selector(setOrientation:) withObject:(id)UIInterfaceOrientationPortrait];
        }
        NSLog(@"2");
        _playView.contentMode = UIViewContentModeScaleAspectFit;
    }
}

//播放暂停
-(void)playViedo:(UIButton *)button{
    if (isPlay == YES) {
        [_player pause];
        isPlay = NO;
        [button setBackgroundImage:[UIImage imageNamed:@"playBtn"] forState:UIControlStateNormal];
        [_timer setFireDate:[NSDate distantFuture]];
    }else {
        [_player play];
        isPlay = YES;
        [button setBackgroundImage:[UIImage imageNamed:@"pauseBtn"] forState:UIControlStateNormal];
        [_timer setFireDate:[NSDate distantPast]];
    }
//    NSLog(@"%u",[_player getVideoPlayState]);
//    NSLog(@"Duration%f",[_player getDuration]);

}

//返回按钮
-(void)back {
    [_player stop];
    [_timer setFireDate:[NSDate distantFuture]];
    [_timer invalidate];
    _timer = nil;
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

//改变播放时长
-(void)changeViedoTime:(UISlider * )slider {
    [_player seekTo:slider.value];
//    NSLog(@"sliderValue%f",slider.value);
}
#pragma mark --通知回调方法
//初始化结束
-(void)receiveDuration:(NSNotification * )notification {
    
     [self performSelectorOnMainThread:@selector(changeLB) withObject:nil waitUntilDone:NO];
    NSLog(@"通知回调");
   }

//播放结束
-(void)playOver {
    NSLog(@"播放结束");
    [playBN setBackgroundImage:[UIImage imageNamed:@"playBtn"] forState:UIControlStateNormal];
    [_timer setFireDate:[NSDate distantFuture]];
}

#pragma mark --点击屏幕方法
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if (_showViedoPlay.alpha == 0) {
        _showViedoPlay.alpha = 0.6;
    }else {
        _showViedoPlay.alpha = 0;
    }
}

#pragma mark -- 旋转屏幕方法

- (NSUInteger)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskAllButUpsideDown;
}

-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    return toInterfaceOrientation != UIInterfaceOrientationPortraitUpsideDown;
}


- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
    if (toInterfaceOrientation == UIInterfaceOrientationPortrait) {
        NSLog(@"竖屏");
        [RotateBN setBackgroundImage:[UIImage imageNamed:@"fillMode"] forState:UIControlStateNormal];
        NSLog(@"%f",kScreenW);
    }else {
        NSLog(@"横屏");
        [RotateBN setBackgroundImage:[UIImage imageNamed:@"fitMode"] forState:UIControlStateNormal];
        NSLog(@"%f",kScreenW);
    }
    NSLog(@"屏幕旋转");
}

#pragma mark --监听Home按钮
//按下Home键及电话
- (void)applicationWillResignActive:(UIApplication *)application
//当应用程序将要入非活动状态执行，在此期间，应用程序不接收消息或事件，比如来电话了
{
    [_player pause];
    [_player stop];
}
//重新进入程序
- (void)applicationDidBecomeActive:(UIApplication *)application
//当应用程序入活动状态执行，这个刚好跟上面那个方法相反
{
    [self CreatePlayView];
    [_player play];
    
}


@end
