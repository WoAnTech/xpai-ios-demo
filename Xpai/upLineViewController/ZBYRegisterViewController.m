//
//  ZBYRegisterViewController.m
//  Xpai
//
//  Created by  cLong on 16/1/8.
//  Copyright © 2016年 B-Star. All rights reserved.
//

#import "ZBYRegisterViewController.h"
#import "XpaiInterface.h"
#import "ZBYTextField.h"
#import "VRCViewController.h"
#import "CLSettingConfig.h"
#import "CLUploadConfig.h"

@interface ZBYRegisterViewController ()<UITextFieldDelegate>
{
    UILabel * _explainLabel;
    ZBYTextField * _UserName;
    ZBYTextField * _PassWord;
    ZBYTextField * _ServiceCode;
    
    UIAlertView * _alert;
    UISegmentedControl * _segment;//选择手持方式
    
    NSString * _userNameText;
    NSString * _passWordText;
    BOOL isLogin;
    BOOL isClick;
    UIAlertView * _failCodeAlertView;
}

@end

@implementation ZBYRegisterViewController


-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (isLogin == YES) {
        [self.navigationController popViewControllerAnimated:NO ];
    }
    
    
}

-(void)dealloc {

    [_failCodeAlertView release];
    [_explainLabel release];
    [_UserName release];
    [_PassWord release];
    [_ServiceCode release];
    [_segment release];
    [super dealloc];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    [[CLUploadConfig sharedInstance] loadData];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"直播云登录";
    UIBarButtonItem * leftItem = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    leftItem.tintColor = [UIColor whiteColor];
    [self.navigationItem setLeftBarButtonItem:leftItem animated:YES];
    [leftItem release];
    
    
    [XpaiInterface setDelegate:self];
    
    [self addExplainLabel];//文字说明
    [self addUserInformationView]; //用户信息输入
}

#pragma mark --搭建界面
//添加文字说明
-(void)addExplainLabel {
    _explainLabel = [[UILabel alloc]initWithFrame:CGRectMake(kScreenW, 70, 160, 50)];
    _explainLabel.numberOfLines = 0;
    _explainLabel.text = @"欢迎使用直播云服务";
    _explainLabel.textAlignment = NSTextAlignmentCenter;
    _explainLabel.textColor = self.navigationController.navigationBar.tintColor;
    [self.view addSubview:_explainLabel];
    
    CABasicAnimation *animation=[CABasicAnimation animationWithKeyPath:@"transform.translation.x"];
    animation.toValue=@( -kScreenW - 160);
    animation.duration=8;
    animation.repeatCount = MAXFLOAT;
    animation.fillMode=kCAFillModeForwards;
    [_explainLabel.layer addAnimation:animation forKey:nil];
}

//用户登录界面
-(void)addUserInformationView {
    NSArray * labelName = [[NSArray alloc]initWithObjects:@"服务码",@"账号",@"密码",@"手持方向", nil];
    
    CGFloat labelW = 80; //提示板 宽度
    CGFloat labelH = 30; //提示板 高度
    CGFloat textFieldH = 30; //输入框高度
    CGFloat textFieldW = 150; //输入框宽度
//    CGFloat crack = (kScreenH - _explainLabel.maxY - 20 - labelH * 3 - 120)/2; //缝隙高度
    CGFloat crack = 10;
    
    //创建TextField
    _ServiceCode = [ZBYTextField initTextFieldWith:@"" frame:CGRectMake(kScreenW * 0.47, _explainLabel.maxY + 10, textFieldW, textFieldH)];//输入服务码
    _ServiceCode.keyboardType = UIKeyboardTypeDefault;
    _ServiceCode.delegate = self;
    _UserName = [ZBYTextField initTextFieldWith:@"" frame:CGRectMake(kScreenW * 0.47, _ServiceCode.maxY + crack, textFieldW, textFieldH)];//输入用户名
    _UserName.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    _UserName.delegate = self;
    _PassWord = [ZBYTextField initTextFieldWith:@"" frame:CGRectMake(kScreenW * 0.47, _UserName.maxY + crack, textFieldW, textFieldH)];//输入密码
    _PassWord.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    _PassWord.delegate = self;

    NSString * userNames = [[NSString alloc]initWithString:[CLUploadConfig sharedInstance].UserName] ;
      NSString * passwords = [[NSString alloc]initWithString:[CLUploadConfig sharedInstance].passWord] ;
    _UserName.text = userNames ;
    _PassWord.text = passwords;
    NSString * service = [[NSString alloc]initWithString:[CLUploadConfig sharedInstance].serviceCode] ;
    _ServiceCode.text = service;
    NSLog(@"%@ %@ %@",_UserName,_PassWord,_ServiceCode);

    [self.view addSubview:_UserName];
    [self.view addSubview:_PassWord];
    [self.view addSubview:_ServiceCode];
//    [userNames release];
//    [passwords release];
//    [service release];
    
    
    //textField名牌
    for (int i = 0; i < 4; i ++) {
        UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(kScreenW * 0.13 , _ServiceCode.y + i * (labelH + crack), labelW, labelH)];
        label.text = labelName[i];
        label.textColor = [UIColor blueColor];
        label.font = [UIFont boldSystemFontOfSize:20.0];
        [self.view addSubview:label];
        [label release];
    }
    
    //选择手持方式
    NSArray * kindOfOrientation = @[@"横屏",@"竖屏"];
    _segment = [[UISegmentedControl alloc]initWithItems:kindOfOrientation];
    _segment.frame = CGRectMake(_ServiceCode.x, _PassWord.maxY + crack, textFieldW, 30);
    [_segment addTarget:self action:@selector(chooseOrientation:) forControlEvents:UIControlEventValueChanged];
    _segment.selectedSegmentIndex = [CLUploadConfig sharedInstance].segment;
    [self.view addSubview:_segment];
    
    
    
    UIImage * buttonImage = [UIImage imageNamed:@"7"];
    UIEdgeInsets insets = UIEdgeInsetsMake(10  , 10 , 50 , 80 );
    buttonImage = [buttonImage resizableImageWithCapInsets:insets resizingMode:UIImageResizingModeStretch];
    //登录按钮
    UIButton * loginButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [loginButton setTitle:@"登  录" forState:UIControlStateNormal];
    [loginButton setBackgroundImage:buttonImage forState:UIControlStateNormal];
    [loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [loginButton setTitleColor:KtitleColor forState:UIControlStateHighlighted];
    loginButton.frame = CGRectMake(kScreenW /2 - 150, _segment.maxY + 10, 300, 40);
    loginButton.titleLabel.font = [UIFont boldSystemFontOfSize:30];
    [loginButton addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginButton];
    
    [labelName release];
}

#pragma mark --按钮方法
//返回上一页
-(void)back {
//    [XpaiInterface disconnect];
    [self.navigationController popViewControllerAnimated:YES];
}

//登录
-(void)login {
    

    if (isClick == YES) {
        return;
    }
    
    //登录方法
    [XpaiInterface connectCloud:@"http://c.zhiboyun.com/api/20140928/get_vs" u:_UserName.text pd:_PassWord.text svcd:_ServiceCode.text];
    [CLUploadConfig sharedInstance].UserName = _UserName.text;
    [CLUploadConfig sharedInstance].passWord = _PassWord.text;
    [CLUploadConfig sharedInstance].serviceCode = _ServiceCode.text;
    [CLUploadConfig sharedInstance].segment = _segment.selectedSegmentIndex;
    [[CLUploadConfig sharedInstance] WriteData];
    NSLog(@"testing:%@",_userNameText);
    
    isClick = YES;

}


#pragma mark --XpainterFaceDelegate回调
//连接成功
-(void)didConnectToServer {
    VRCViewController * VRC = [[VRCViewController alloc]init];
    VRC.isLogin = YES;
    isLogin = YES;
    VRC.UserName = _UserName.text;
    VRC.PassWord = _PassWord.text;
    VRC.serviceCode = _ServiceCode.text;
    if (_segment.selectedSegmentIndex == 0) {
        VRC.isAcross = YES;
    }else {
        VRC.isAcross = NO;
    }
    VRC.kindOfLogin = 1;
    
    VRC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:VRC animated:YES completion:^{
    }];
    [VRC release];

    
    NSLog(@"登录成功");
    
}

//连接失败
-(void)failConnectToServer:(int)failCode {
    
    NSLog(@"%d",failCode);
    if (failCode == 1) {
       _failCodeAlertView = [[UIAlertView alloc]initWithTitle:@"登录失败" message:@"查询VS地址出错" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        _explainLabel.text = @"查询VS地址出错";
        _explainLabel.textColor = [UIColor redColor];
        isClick = NO;
    }else if (failCode == 2) {
        _failCodeAlertView = [[UIAlertView alloc]initWithTitle:@"登录失败" message:@"无法连接到服务器" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        _explainLabel.text = @"无法连接到服务器";
        _explainLabel.textColor = [UIColor redColor];
        isClick = NO;
    }else if (failCode == 3) {
       _failCodeAlertView = [[UIAlertView alloc]initWithTitle:@"登录失败" message:@"用户名或密码错误" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        _explainLabel.text = @"用户名或密码错误";
        _explainLabel.textColor = [UIColor redColor];
        isClick = NO;
    }else if (failCode == 4) {
        _failCodeAlertView = [[UIAlertView alloc]initWithTitle:@"登录失败" message:@"获取服务器地址出错" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        _explainLabel.text = @"获取服务器地址出错";
        _explainLabel.textColor = [UIColor redColor];
        isClick = NO;
    }
    
    [_failCodeAlertView show];
}

-(void)chooseOrientation:(UISegmentedControl *)sengment {
//    NSLog(@"%ld",(long)sengment.selectedSegmentIndex);
//    NSLog(@"123123");
}

#pragma mark --textField代理方法
-(void)textFieldDidBeginEditing:(UITextField *)textField {
    if ([textField isEqual:_PassWord]) {
//            [UIView animateWithDuration:0.3 animations:^{
//                self.view.y = -150;
//            }];
    }else if([textField isEqual:_ServiceCode]) {
//            [UIView animateWithDuration:0.3 animations:^{
//                self.view.y = -200;
//            }];
    }else if([textField isEqual:_UserName]){
//            [UIView animateWithDuration:0.3 animations:^{
//                self.view.y = -100;
//            }];
    }
}

#pragma mark --点击空白处方法
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [UIView animateWithDuration:0.3 animations:^{
        self.view.y = 0;
    }];
    [self.view endEditing:YES]; //所有放弃第一响应
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
