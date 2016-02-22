//
//  NewRecordViewController.m
//  Xpai
//
//  Created by  cLong on 16/1/8.
//  Copyright © 2016年 北京沃安科技有限公司. All rights reserved.
//

#import "NewRecordViewController.h"
#import "ZBYRegisterViewController.h"
#import "SYYRegisterViewController.h"
#import "SPFWQRegisterViewController.h"
#import "VRCViewController.h"

@interface NewRecordViewController ()<UIAlertViewDelegate>
{
    UIImageView * _logoImage;
    UIAlertView * _alert;
    
}

@end

@implementation NewRecordViewController

-(void)dealloc {
    [_logoImage release];
    [_alert release];
    [super dealloc];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor colorWithRed:255 green:255 blue:255 alpha:1];
    self.title = @"Xpai 连接方式";
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:0 green:0.6 blue:1 alpha:1];
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],UITextAttributeTextColor,[UIFont boldSystemFontOfSize:20.0],UITextAttributeFont, nil]];
    _alert = [[UIAlertView alloc]initWithTitle:@"手持方式" message:@"请选择一种手持方向" delegate:self cancelButtonTitle:@"横屏" otherButtonTitles:@"竖屏", nil];
    _alert.delegate = self;
    
    [self addlogoView];
    [self addThreeButton];
}

#pragma mark --搭建界面
//logo界面
-(void)addlogoView {
    //直播云logo图标
    _logoImage = [[UIImageView alloc]initWithFrame:CGRectMake(40, 100,[UIScreen mainScreen].bounds.size.width - 80 ,60 )];
    _logoImage.image = [UIImage imageNamed:@"logo-505-200"];
    _logoImage.backgroundColor = [UIColor clearColor];
    _logoImage.contentMode = UIViewContentModeScaleAspectFill;
    [self.view addSubview:_logoImage];
    
    NSString* phoneVersion = [[UIDevice currentDevice] systemVersion];
    NSLog(@"%@",phoneVersion);
    
}

//三种选择方式、直播云、私有云、视频服务器
-(void)addThreeButton {
    NSArray * buttonNameArray = [[NSArray alloc]initWithObjects:@"直播云",@"私有云",@"视频服务器",nil];
    
    
    CGFloat buttonW = kScreenW - 40; //按钮宽
    CGFloat buttonH = 40; // 按钮高
    CGFloat crack = (kScreenH - _logoImage.maxY - buttonH * 3 - 20 - 100) / 3; //缝隙高度
    
    UIImage * buttonImage = [UIImage imageNamed:@"7"];
    UIEdgeInsets insets = UIEdgeInsetsMake(10  , 10 , 103 , 103 );
    buttonImage = [buttonImage resizableImageWithCapInsets:insets resizingMode:UIImageResizingModeStretch];
    //创建直播云、私有云、视频服务器登录按钮
    for (int i =0; i < 3; i ++) {
        UIButton * button = [UIButton buttonWithType:UIButtonTypeSystem];
        button.frame = CGRectMake(20 , _logoImage.maxY + crack + i * (buttonH + crack) , buttonW, buttonH);
        button.titleLabel.font = [UIFont boldSystemFontOfSize:20.0];
        [button setTitle:buttonNameArray[i] forState:UIControlStateNormal];
        [button setBackgroundImage:buttonImage forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [button setTitleColor:KtitleColor forState:UIControlStateHighlighted];
        [button addTarget:self action:@selector(gotoView:) forControlEvents:UIControlEventTouchUpInside];
        button.tag = newRecordTag + i;
        [self.view addSubview:button];
}
    
    [buttonImage release];
    //离线模式按钮
    UIButton * offLineButton = [UIButton buttonWithType:UIButtonTypeSystem];
    offLineButton.frame = CGRectMake(kScreenW - 100 , kScreenH - 30, 100, 20);
    [offLineButton setTitle:@"离线模式" forState:UIControlStateNormal];
    offLineButton.tag = newRecordTag + 3;
    [offLineButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [offLineButton setTitleColor:KtitleColor forState:UIControlStateHighlighted];
    [offLineButton setBackgroundImage:[UIImage imageNamed:@"2"] forState:UIControlStateNormal];
    [offLineButton setBackgroundImage:[UIImage imageNamed:@"赛包包素材(roador.taobao"] forState:UIControlStateHighlighted];
    [offLineButton addTarget:self action:@selector(gotoView:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:offLineButton];
    
}

#pragma mark --跳转方法
//跳转不同页面
-(void)gotoView:(UIButton * )button{
    switch (button.tag) {
        case newRecordTag ://跳转直播云登录页
        {
            ZBYRegisterViewController * zbyVC = [[ZBYRegisterViewController alloc]init];
            [self.navigationController pushViewController:zbyVC animated:YES];
            
            [zbyVC release];
        }
            break;
        case newRecordTag+ 1 ://跳转私有云登录页
        {
            SYYRegisterViewController * syy = [[SYYRegisterViewController alloc]init];
            
            [self.navigationController pushViewController:syy animated:YES];
            [syy release];
        }
            break;
        case newRecordTag + 2://跳转视频服务器登录页
        {
            SPFWQRegisterViewController * spfwq = [[SPFWQRegisterViewController alloc]init];
            [self.navigationController pushViewController:spfwq animated:YES];
            [spfwq release];
        }
            break;
        case newRecordTag + 3 ://跳转离线模式
        {
            [_alert show];
            
        }
            break;
            
        default:
            break;
    }
}

#pragma mark --提示框代理
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    VRCViewController * VRC = [[VRCViewController alloc]init];
    if (buttonIndex == 0) {
        VRC.isAcross = YES;
    }else {
        VRC.isAcross = NO;
    }
    VRC.isLogin = NO;
    VRC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:VRC animated:YES completion:^{
        [VRC release];
    }];

}

#pragma mark --旋转屏幕
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
    return (toInterfaceOrientation == UIInterfaceOrientationPortrait);
}

-(NSUInteger)supportedInterfaceOrientations {
    
    return UIInterfaceOrientationMaskPortrait;
}

- (BOOL)shouldAutorotate {
    return NO;
}

@end
