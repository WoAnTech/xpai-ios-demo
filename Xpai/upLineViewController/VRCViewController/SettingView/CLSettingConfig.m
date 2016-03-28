//
//  CLSettingConfig.m
//  Xpai
//
//  Created by  cLong on 16/1/14.
//  Copyright © 2016年 B-Star. All rights reserved.
//

#import "CLSettingConfig.h"

@interface CLSettingConfig ()
{
    BOOL isNotFirst;
}

@end

@implementation CLSettingConfig

static CLSettingConfig * _clSettingConfig;


+(instancetype)sharedInstance {
    if (_clSettingConfig == nil) {
        _clSettingConfig = [[CLSettingConfig alloc]init];
    }
    return _clSettingConfig;
}

-(BOOL)loadData {
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    NSLog(@"%@",defaults);
    NSLog(@"%d",[defaults boolForKey:@"first"]);
    if (![defaults boolForKey:@"first"]) {
        _resolution = 2;
        _BitStream = 480;
        _NetOverTime = 10;
        _reconnectOverTime = 30;
        _segment = 0;
        if ([[[UIDevice currentDevice] systemVersion] integerValue] >= 8.0) {//判断系统版本号
            _transcribe = 1;
        }else {
            _transcribe = 0;//前三个废弃
        }
        _audioParameter = 2;
        _audioSampling = 8000;
        _audioBit = 12200;
        _outPutTag = nil;  //没有特别要求为nil 不能设置为空或其他
        _NetDeption = TRUE;
        _SaveRedio = FALSE;
        isNotFirst = YES;
        _SYYUserName = @"";
        _SYYPassWord = @"";
        _SYYServiceCode = @"";
        _GetVCUrl =  @"http://192.168.1.1/api/20140928/get_vs";
        _SPFWQUserName = @"";
        _SPFWQPassWord = @"";
        _SPFWQServiceCode = @"";
        _mainPort = [@"" integerValue];
        _mainUrl = @"";
        _isTcp = NO;
        
        [self WriteData];
        return YES;
    }
    _resolution = [defaults integerForKey:KResolution];
    _BitStream = [defaults integerForKey:KBitStream];
    _NetOverTime = [defaults integerForKey:KNetOverTime];
    _reconnectOverTime = [defaults integerForKey:KReconnectOverTime];
    _transcribe = [defaults integerForKey:KTranScribe];
    _audioParameter = [defaults integerForKey:KaudioParamter];
    _audioSampling = [defaults integerForKey:kaudioSampling];
    _audioBit = [defaults integerForKey:kaudioBit];
    _outPutTag = [defaults stringForKey:KOutPutTag];
    _NetDeption = [defaults boolForKey:KNetDeption];
    _SaveRedio = [defaults boolForKey:KsaveRedio];
    isNotFirst = [defaults boolForKey:@"first"];

    _SYYUserName = [defaults stringForKey:KSYYUserName];
    _SYYPassWord = [defaults stringForKey:KSYYPassWord];
    _SYYServiceCode = [defaults stringForKey:KSYYServiceCode];
    _GetVCUrl = [defaults stringForKey:KGetVCUrl];
    _SPFWQUserName = [defaults stringForKey:KSPFWQUserName];
    _SPFWQPassWord = [defaults stringForKey:KSPFWQPassWord];
    _SPFWQServiceCode  = [defaults stringForKey:KspfwqServiceCode];
    _mainPort = [defaults integerForKey:KmainPort];
    _mainUrl = [defaults stringForKey:KmainUrl];
    _isTcp = [defaults boolForKey:KisTcp];
    _segment  = [defaults integerForKey:ksegment];
    
    return YES;
}

-(BOOL)WriteData {
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    NSLog(@"%@",defaults);
    [defaults setInteger:_resolution forKey:KResolution];
    [defaults setInteger:_BitStream forKey:KBitStream];
    [defaults setInteger:_NetOverTime forKey:KNetOverTime];
    [defaults setInteger:_reconnectOverTime forKey:KReconnectOverTime];
    [defaults setInteger:_transcribe forKey:KTranScribe];
    [defaults setInteger:_audioParameter forKey:KaudioParamter];
    [defaults setInteger:_audioSampling forKey:kaudioSampling];
    [defaults setInteger:_audioBit forKey:kaudioBit];
    [defaults setObject:_outPutTag forKey:KOutPutTag];
    [defaults setBool:_NetDeption forKey:KNetDeption];
    [defaults setBool:_SaveRedio forKey:KsaveRedio];
    [defaults setBool:isNotFirst forKey:@"first"];
//    [defaults setObject:_UserNames forKey:KUserName];
//    [defaults setObject:_PassWords forKey:KPassWord];
//    [defaults setObject:_serviceCodes forKey:KserviceCode];
    [defaults setObject:_SYYUserName forKey:KSYYUserName];
    [defaults setObject:_SYYPassWord forKey:KSYYPassWord];
    [defaults setObject:_SYYServiceCode forKey:KSYYServiceCode];
    [defaults setObject:_GetVCUrl forKey:KGetVCUrl];
    [defaults setObject:_SPFWQUserName forKey:KSPFWQUserName];
    [defaults setObject:_SPFWQPassWord forKey:KSPFWQPassWord];
    [defaults setObject:_SPFWQServiceCode forKey:KspfwqServiceCode];
    [defaults setInteger:_mainPort forKey:KmainPort];
    [defaults setObject:_mainUrl forKey:KmainUrl];
    [defaults setBool:_isTcp forKey:KisTcp];
    [defaults setInteger:_segment forKey:ksegment];
    
    [defaults setObject:_testing forKey:@"test"];
    
    [defaults synchronize];
    return YES;
}

@end
