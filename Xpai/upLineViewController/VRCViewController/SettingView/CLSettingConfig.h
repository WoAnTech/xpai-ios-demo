//
//  CLSettingConfig.h
//  Xpai
//
//  Created by  cLong on 16/1/14.
//  Copyright © 2016年 B-Star. All rights reserved.
//

#import <Foundation/Foundation.h>

#define KResolution @"resolution"
#define KBitStream @"bitStream"
#define KNetOverTime @"netOverTime"
#define KReconnectOverTime @"reconnectOverTime"
#define KTranScribe @"Transcribe"
#define KaudioParamter @"audioParameter"
#define kaudioSampling @"audioSampling"
#define kaudioBit @"audioBit"
#define KOutPutTag @"outPutTag"
#define KNetDeption @"netDeption"
#define KsaveRedio @"saveRedio"
//#define KUserName @"UserName"
//#define KPassWord @"passWord"
//#define KserviceCode @"serviceCode"
#define KSYYUserName @"SYYUserName"
#define KSYYPassWord @"SYYPassWord"
#define KSYYServiceCode @"SYYServiceCode"
#define KGetVCUrl @"GetVCUrl"
#define KSPFWQUserName @"SPFWQUserName"
#define KSPFWQPassWord @"SPFWQPassWord"
#define KspfwqServiceCode @"SPFWQServiceCode"
#define KmainUrl @"mainUrl"
#define KmainPort @"mainPort"
#define KisTcp @"isTcp"
#define ksegment @"segment"

@interface CLSettingConfig : NSObject


@property(nonatomic,retain)NSString * SYYUserName;//私有云用户名
@property(nonatomic,retain)NSString * SYYPassWord;//私有云密码
@property(nonatomic,retain)NSString * SYYServiceCode;//私有云服务码
@property(nonatomic,retain)NSString * GetVCUrl;//GetVC地址

@property(nonatomic,retain)NSString * SPFWQUserName;//视频服务器用户名
@property(nonatomic,retain)NSString * SPFWQPassWord;//视频服务器密码
@property(nonatomic,retain)NSString * SPFWQServiceCode;//视频服务器服务码
@property (nonatomic,retain)NSString * mainUrl;//主机地址
@property (nonatomic,assign)UInt16 mainPort;//主机端口
@property (nonatomic,assign)BOOL isTcp;//是否直连TCP

@property(nonatomic,retain)NSString * testing;


@property(nonatomic,assign)NSInteger  resolution; //分辨率
@property(nonatomic,assign)NSInteger  BitStream;//码流
@property(nonatomic,assign)NSInteger  NetOverTime;//网络超时
@property(nonatomic,assign)NSInteger  reconnectOverTime;//重连超时时间
@property(nonatomic,assign)NSInteger  transcribe;//录制类型
@property(nonatomic,assign)NSInteger  audioParameter;//音频编码参数
@property(nonatomic,assign)NSInteger audioSampling;//音频编码采样率
@property(nonatomic,assign)NSInteger audioBit;//音频编码比特率
@property(nonatomic,retain)NSString * outPutTag;//输出格式标签
@property(nonatomic,assign)BOOL  NetDeption;//网络自适应
@property(nonatomic,assign)BOOL  SaveRedio;//保存视频文件
@property (nonatomic,assign)NSInteger segment;


//@property(nonatomic,retain)NSString * UserNames;//用户名
//@property(nonatomic,retain)NSString * PassWords;//密码
//@property(nonatomic,retain)NSString * serviceCodes;//服务码


+(instancetype)sharedInstance;
-(BOOL)loadData;
-(BOOL)WriteData;


@end
