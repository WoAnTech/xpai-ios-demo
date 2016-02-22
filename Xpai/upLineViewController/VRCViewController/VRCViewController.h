//
//  VRCViewController.h
//  Xpai
//
//  Created by  cLong on 16/1/12.
//  Copyright © 2016年 北京沃安科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VRCViewController : UIViewController

@property (nonatomic,assign)BOOL isLogin;

@property (nonatomic,retain)NSString * UserName;//用户名
@property (nonatomic,retain)NSString * PassWord;//密码
@property (nonatomic,retain)NSString * serviceCode;//服务码
@property (nonatomic,retain)NSString * GetVCUrl;//GetVC地址
@property (nonatomic,retain)NSString * mainUrl;//主机地址
@property (nonatomic,assign)UInt16 mainPort;//主机端口
@property (nonatomic,assign)BOOL isTcp;//是否直连TCP
@property (nonatomic,assign)BOOL isAcross;//是否横屏
@property (nonatomic,assign)NSInteger kindOfLogin;//连接类型 直播云、私有云、视频服务器

@end
