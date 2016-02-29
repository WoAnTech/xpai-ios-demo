//
//  SYYRegisterViewController.m
//  Xpai
//
//  Created by  cLong on 16/1/8.
//  Copyright © 2016年 北京沃安科技有限公司. All rights reserved.
//

#import "SYYRegisterViewController.h"
#import "XpaiInterface.h"
#import "ZBYTextField.h"
#import "VRCViewController.h"
#import "CLSettingConfig.h"

@interface SYYRegisterViewController ()<UITextFieldDelegate,UITextViewDelegate>
{
    UILabel * _explainLabel;
    
    ZBYTextField * _UserName;
    ZBYTextField * _PassWord;
    ZBYTextField * _ServiceCode;
    UITextView * _GetVCUrl;
    UISegmentedControl * _segment;
    
    UIAlertView *  _failCodeAlertView;
}

@end

@implementation SYYRegisterViewController

-(void)dealloc {
    [_explainLabel release];
    [_UserName release];
    [_PassWord release];
    [_ServiceCode release];
    [_GetVCUrl release];
    [_failCodeAlertView release];
    [_segment release];
    [super dealloc];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"私有云登录";
    [[CLSettingConfig sharedInstance] loadData];
    UIBarButtonItem * leftItem = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    leftItem.tintColor = [UIColor whiteColor];
    [self.navigationItem setLeftBarButtonItem:leftItem animated:YES];
    [leftItem release];
    
    [XpaiInterface setDelegate:self];
    
    //创建说明
    [self addExplainLabel];
    
    //搭建界面
    [self addSubView];
}

#pragma mark --搭建界面
//添加文字说明
-(void)addExplainLabel {
    _explainLabel = [[UILabel alloc]initWithFrame:CGRectMake(kScreenW , 70, 160, 50)];
    _explainLabel.numberOfLines = 0;
    _explainLabel.text = @"欢迎使用私有云服务";
    _explainLabel.textColor = self.navigationController.navigationBar.tintColor;
    [self.view addSubview:_explainLabel];
    
    CABasicAnimation *animation=[CABasicAnimation animationWithKeyPath:@"transform.translation.x"];
    animation.toValue=@( -kScreenW - 160);
    animation.duration=8;
    animation.repeatCount = MAXFLOAT;
    animation.fillMode=kCAFillModeForwards;
    [_explainLabel.layer addAnimation:animation forKey:nil];

}

//添加TextField
-(void)addSubView{
    NSArray * labelName = [[NSArray alloc]initWithObjects:@"服务码",@"账号",@"密码",@"手持方式",@"GetVs地址", nil];
    
    CGFloat labelW = 80; //提示板 宽度
    CGFloat labelH = 30; //提示板 高度
    CGFloat textFieldH = 30; //输入框高度
    CGFloat textFieldW = 150; //输入框宽度
//    CGFloat crack = (kScreenH - _explainLabel.maxY - 20 - labelH * 3 - 120)/4; //缝隙高度
    CGFloat crack = 10;
    
    //创建TextField
    _ServiceCode = [ZBYTextField initTextFieldWith:@"" frame:CGRectMake(kScreenW * 0.47, _explainLabel.maxY + 5, textFieldW, textFieldH)];
    _ServiceCode.delegate = self;
    _UserName = [ZBYTextField initTextFieldWith:@"" frame:CGRectMake(kScreenW * 0.47, _ServiceCode.maxY + crack, textFieldW, textFieldH)];
    _UserName.delegate = self;
    _UserName.keyboardType = UIKeyboardTypePhonePad;
    _ServiceCode.delegate = self;
     _PassWord = [ZBYTextField initTextFieldWith:@"" frame:CGRectMake(kScreenW * 0.47, _UserName.maxY + crack, textFieldW, textFieldH)];
    _PassWord.keyboardType = UIKeyboardTypePhonePad;
    _PassWord.delegate = self;
    NSArray * kindOfOrientation = @[@"横屏",@"竖屏"];
    _segment = [[UISegmentedControl alloc]initWithItems:kindOfOrientation];
    _segment.frame = CGRectMake(_PassWord.x, _PassWord.maxY + crack, textFieldW, 30);
    _segment.selectedSegmentIndex = 0;
     _GetVCUrl = [[UITextView alloc]initWithFrame:CGRectMake(kScreenW * 0.13, _segment.maxY + crack+ 30, kScreenW - kScreenW * 0.13 *2 + 20, textFieldH)];
    _GetVCUrl.delegate = self;
    _GetVCUrl.keyboardType = UIKeyboardTypeURL;
//    _GetVCUrl.text = @"http://180.153.55.2:10010/api/20140928/get_vs";//测试网址
    
  
    NSString * username = [[NSString alloc]initWithString:[CLSettingConfig sharedInstance].SYYUserName];
    NSString * password = [[NSString alloc]initWithString:[CLSettingConfig sharedInstance].SYYPassWord];
    NSString * service = [[NSString alloc]initWithString:[CLSettingConfig sharedInstance].SYYServiceCode];
    NSString * getUrl = [[NSString alloc]initWithString:[CLSettingConfig sharedInstance].GetVCUrl];
    
    _UserName.text = username;
    _PassWord.text = password;
    _ServiceCode.text = service;
    _GetVCUrl.text = getUrl;
    
//    [username release];
//    [password release];
//    [service release];
//    [getUrl release];
    
    [self.view addSubview:_UserName];
    [self.view addSubview:_PassWord];
    [self.view addSubview:_ServiceCode];
    [self.view addSubview:_GetVCUrl];
    [self.view addSubview:_segment];

    
    //textField名牌
    for (int i = 0; i < 5; i ++) {
        if (i == 4) {
            labelW = 150;
        }
        UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(kScreenW * 0.13 , _ServiceCode.y + i * (labelH + crack), labelW, labelH)];
        label.text = labelName[i];
        label.textColor = [UIColor blueColor];
        label.font = [UIFont boldSystemFontOfSize:20.0];
        [self.view addSubview:label];
        [label release];
    }
    
    UIImage * buttonImage = [UIImage imageNamed:@"7"];
    UIEdgeInsets insets = UIEdgeInsetsMake(10  , 10 , 103 , 103 );
    buttonImage = [buttonImage resizableImageWithCapInsets:insets resizingMode:UIImageResizingModeStretch];
    //登录按钮
    UIButton * loginButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [loginButton setTitle:@"登  录" forState:UIControlStateNormal];
    [loginButton setBackgroundImage:buttonImage forState:UIControlStateNormal];
    [loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [loginButton setTitleColor:KtitleColor forState:UIControlStateHighlighted];
    loginButton.frame = CGRectMake(kScreenW /2 - 150, _GetVCUrl.maxY + 10, 300, 40);
    loginButton.titleLabel.font = [UIFont boldSystemFontOfSize:30];
    [loginButton addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginButton];
    
    [labelName release];
}


#pragma mark --按钮方法
//返回
-(void)back {
    [XpaiInterface disconnect];
    [self.navigationController popViewControllerAnimated:YES];
}
//登录
-(void)login {
    [XpaiInterface connectCloud:_GetVCUrl.text u:_UserName.text pd:_PassWord.text svcd:_ServiceCode.text];
    [CLSettingConfig sharedInstance].SYYUserName = _UserName.text;
    [CLSettingConfig sharedInstance].SYYPassWord = _PassWord.text;
    [CLSettingConfig sharedInstance].SYYServiceCode = _ServiceCode.text;
    [CLSettingConfig sharedInstance].GetVCUrl = _GetVCUrl.text;
    [[CLSettingConfig sharedInstance] WriteData];
}

#pragma mark -- 代理方法
-(void)textFieldDidBeginEditing:(UITextField *)textField {
    if ([textField isEqual:_PassWord]) {
        [UIView animateWithDuration:0.3 animations:^{
            self.view.y = -50;
        }];
    }else if ([textField isEqual:_ServiceCode]) {
        [UIView animateWithDuration:0.3 animations:^{
            self.view.y = -50;
        }];
    }else if ([textField isEqual:_UserName]) {
        [UIView animateWithDuration:0.3 animations:^{
            self.view.y = -50;
        }];
    }
}

-(void)textFieldDidEndEditing:(UITextField *)textField {
    [UIView animateWithDuration:0.3 animations:^{
        self.view.y = 0;
    }];
}

-(void)textViewDidBeginEditing:(UITextView *)textView {
    [UIView animateWithDuration:0.3 animations:^{
        self.view.y = -50;
    }];
}

-(void)textViewDidEndEditing:(UITextView *)textView {
    [UIView animateWithDuration:0.3 animations:^{
        self.view.y = 0;
    }];
}

#pragma mark --XpainterFaceDelegate回调
//连接成功
-(void)didConnectToServer {
    NSLog(@"登录成功");
    VRCViewController * VRC = [[VRCViewController alloc]init];
    VRC.isLogin = YES;
    VRC.UserName = _UserName.text;
    VRC.PassWord = _PassWord.text;
    VRC.serviceCode = _ServiceCode.text;
    if (_segment.selectedSegmentIndex == 0) {
        VRC.isAcross = YES;
    }else {
        VRC.isAcross = NO;
    }
    VRC.GetVCUrl = _GetVCUrl.text;
    VRC.kindOfLogin = 2;
    VRC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:VRC animated:YES completion:^{
    }];
}

//连接失败
-(void)failConnectToServer:(int)failCode {
    
    NSLog(@"%d",failCode);
    if (failCode == 1) {
        _failCodeAlertView = [[UIAlertView alloc]initWithTitle:@"登录失败" message:@"查询VS地址出错" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    }else if (failCode == 2) {
        _failCodeAlertView = [[UIAlertView alloc]initWithTitle:@"登录失败" message:@"无法连接到服务器" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    }else if (failCode == 3) {
        _failCodeAlertView = [[UIAlertView alloc]initWithTitle:@"登录失败" message:@"用户名或密码错误" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    }else if (failCode == 4) {
        _failCodeAlertView = [[UIAlertView alloc]initWithTitle:@"登录失败" message:@"获取服务器地址出错" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    }
    
    [_failCodeAlertView show];
}

#pragma mark -- 点击空白处
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [UIView animateWithDuration:0.4 animations:^{
        self.view.y = 0;
    }];
    [self.view endEditing:YES];
}

@end
