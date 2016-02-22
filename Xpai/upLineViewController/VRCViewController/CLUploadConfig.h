//
//  CLUploadConfig.h
//  Xpai
//
//  Created by  cLong on 16/2/3.
//  Copyright © 2016年 北京沃安科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CLUploadConfig : NSObject

#define KUserName @"userName"
#define KPassWord @"passWord"
#define KserviceCode @"serviceCode"
#define ksegment @"segment"

@property (nonatomic,retain)NSString *  UserName;
@property (nonatomic,retain)NSString *  passWord;
@property (nonatomic,retain)NSString * serviceCode;
@property (nonatomic,assign)NSInteger segment;

+(instancetype)sharedInstance;
-(void)loadData;
-(void)WriteData;

@end
