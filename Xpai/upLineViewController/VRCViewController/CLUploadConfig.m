//
//  CLUploadConfig.m
//  Xpai
//
//  Created by  cLong on 16/2/3.
//  Copyright © 2016年 北京沃安科技有限公司. All rights reserved.
//

#import "CLUploadConfig.h"

@interface CLUploadConfig ()
{
    BOOL isNotFirst;
}

@end

@implementation CLUploadConfig

static CLUploadConfig * _cluploadConfig;

+(instancetype)sharedInstance {
    if (_cluploadConfig == nil) {
        _cluploadConfig = [[CLUploadConfig alloc]init];
    }
    return _cluploadConfig;
}

-(void)loadData {
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    if (![defaults boolForKey:@"isnotfirst"]) {
        _UserName = @"";
        _passWord = @"";
        _serviceCode = @"";
        isNotFirst = YES;
        [self WriteData];

    }
    
    _UserName = [defaults stringForKey:KUserName];
    _passWord = [defaults stringForKey:KPassWord];
    _serviceCode = [defaults stringForKey:KserviceCode];
    _segment = [defaults integerForKey:ksegment];
    isNotFirst = [defaults boolForKey:@"isnotfirst"];
    
    [defaults synchronize];
}

-(void)WriteData {
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:_UserName forKey:KUserName];
    [defaults setObject:_passWord forKey:KPassWord];
    [defaults setObject:_serviceCode forKey:KserviceCode];
    [defaults setInteger:_segment forKey:ksegment];
    [defaults setBool:isNotFirst forKey:@"isnotfirst"];
    [defaults synchronize];
}

@end
