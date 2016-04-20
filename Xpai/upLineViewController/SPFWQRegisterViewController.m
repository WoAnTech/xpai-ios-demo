//
//  SPFWQRegisterViewController.m
//  Xpai
//
//  Created by  cLong on 16/1/8.
//  Copyright © 2016年 B-Star. All rights reserved.
//

#import "SPFWQRegisterViewController.h"
#import "XpaiInterface.h"
#import "ZBYTextField.h"
#import "VRCViewController.h"
#import "CLSettingConfig.h"

@interface SPFWQRegisterViewController ()<UITextFieldDelegate,UITextViewDelegate>
{
    UILabel * _explainLabel;
    UIView * _backgroundView;
    UIView * _lbBackgroundView;
    
    ZBYTextField * _UserName;
    ZBYTextField * _PassWord;
    ZBYTextField * _serviceCode;
    UITextView * _mainUrl;
    ZBYTextField * _mainPort;
    
    UISegmentedControl * _segment;
    
    UISwitch * _TCPWwitch;
    UIAlertView * _failCodeAlertView;
    
    BOOL isLogin;
}

@end

@implementation SPFWQRegisterViewController

-(void)dealloc {
    [_explainLabel release];
    [_UserName release];
    [_PassWord release];
    [_serviceCode release];
    [_mainUrl release];
    [_mainPort release];
    [_backgroundView release];
    [_TCPWwitch release];
    [_failCodeAlertView release];
    [_segment release];
    [_lbBackgroundView release];
    
    [super dealloc];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (isLogin == YES) {
        [self.navigationController popViewControllerAnimated:NO ];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"直播云登录";
    [[CLSettingConfig sharedInstance] loadData];
    UIBarButtonItem * leftItem = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    leftItem.tintColor = [UIColor whiteColor];
    [self.navigationItem setLeftBarButtonItem:leftItem animated:YES];
    [leftItem release];
    
    _backgroundView = [[UIView alloc]initWithFrame:self.view.bounds];
    _backgroundView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_backgroundView];
    
    [XpaiInterface setDelegate:self];
    
    //创建说明
    [self addExplainLabel];
    
    //搭建界面
    [self addSubView];

}

#pragma mark --搭建界面
//创建说明视图
-(void)addExplainLabel {
    _lbBackgroundView = [[UIView alloc]initWithFrame:CGRectMake(0, 46, kScreenW, 60)];
    _lbBackgroundView.backgroundColor = [UIColor whiteColor];
    [_backgroundView addSubview:_lbBackgroundView];
    
    _explainLabel = [[UILabel alloc]initWithFrame:CGRectMake(kScreenW, 5, 300, 50)];
    _explainLabel.numberOfLines = 0;
    _explainLabel.text = @"欢迎使用视频服务器服务";
    _explainLabel.textColor = self.navigationController.navigationBar.tintColor;
    [_lbBackgroundView addSubview:_explainLabel];
    
    CABasicAnimation *animation=[CABasicAnimation animationWithKeyPath:@"transform.translation.x"];
    animation.toValue=@( -kScreenW - 300);
    animation.duration=10;
    animation.repeatCount = MAXFLOAT;
    animation.fillMode=kCAFillModeForwards;
    [_explainLabel.layer addAnimation:animation forKey:nil];

}


//创建输入界面
-(void)addSubView {
    NSArray * labelName = [[NSArray alloc]initWithObjects:@"服务码",@"账号",@"密码",@"主机地址",@"主机端口",@"手持方式", nil];
    
    CGFloat labelW = 80; //提示板 宽度
    CGFloat labelH = 30; //提示板 高度
    CGFloat textFieldH = 30; //输入框高度
    CGFloat textFieldW = 150; //输入框宽度
//    CGFloat crack = (kScreenH - _explainLabel.maxY - 20 - labelH * 3 - 120)/6; //缝隙高度
    CGFloat crack = 10;
    
    //设置textField
    _serviceCode = [ZBYTextField initTextFieldWith:@"请输入服务码" frame:CGRectMake(kScreenW * 0.47, _lbBackgroundView.maxY + 10, textFieldW, textFieldH)];
    _serviceCode.delegate = self;
    _UserName = [ZBYTextField initTextFieldWith:@"请输入账号" frame:CGRectMake(kScreenW * 0.47, _serviceCode.maxY + crack, textFieldW, textFieldH)];
    _UserName.delegate = self;
    _UserName.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    _PassWord = [ZBYTextField initTextFieldWith:@"请输入密码" frame:CGRectMake(kScreenW * 0.47, _UserName.maxY + crack, textFieldW, textFieldH)];
    _PassWord.delegate = self;
    _PassWord.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    _mainUrl = [[UITextView alloc]initWithFrame: CGRectMake(kScreenW * 0.13, _PassWord.maxY + crack + textFieldH + 5 ,  kScreenW - kScreenW * 0.13 *2 + 20, textFieldH)];
    _mainUrl.layer.borderWidth = 1;
    _mainUrl.layer.cornerRadius = 8;
    _mainUrl.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _mainUrl.delegate = self;
    _mainUrl.keyboardType = UIKeyboardTypeURL;
    _mainPort = [ZBYTextField initTextFieldWith:@"请输入主机端口" frame:CGRectMake(kScreenW * 0.13, _mainUrl.maxY + 25 + 8,  kScreenW - kScreenW * 0.13 *2 + 20, textFieldH)];
    _mainPort.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    _mainPort.delegate = self;
    
    NSArray * kindOfOrientation = @[@"横屏",@"竖屏"];
    _segment = [[UISegmentedControl alloc]initWithItems:kindOfOrientation];
    _segment.frame = CGRectMake(kScreenW * 0.47, _mainPort.maxY + crack, textFieldW, 30);
    [[CLSettingConfig sharedInstance]loadData];
    _segment.selectedSegmentIndex = [CLSettingConfig sharedInstance].segment;
    [_backgroundView addSubview:_segment];
    
    NSString * userName = [[NSString alloc]initWithString:[CLSettingConfig sharedInstance].SPFWQUserName];
    NSString * password = [[NSString alloc]initWithString:[CLSettingConfig sharedInstance].SPFWQPassWord];
    NSString * serviceCode = [[NSString alloc]initWithString:[CLSettingConfig sharedInstance].SPFWQServiceCode];
    NSString * mainUrl = [[NSString alloc]initWithString:[CLSettingConfig sharedInstance].mainUrl];
    NSString * mainPort = [[NSString alloc]initWithFormat:@"%d",[CLSettingConfig sharedInstance].mainPort];
    
    _UserName.text = userName;
    _PassWord.text = password;
    _serviceCode.text = serviceCode;
    _mainUrl.text = mainUrl;
    _mainPort.text = mainPort;

    [_backgroundView addSubview:_UserName];
    [_backgroundView addSubview:_PassWord];
    [_backgroundView addSubview:_serviceCode];
    [_backgroundView addSubview:_mainUrl];
    [_backgroundView addSubview:_mainPort];
    
    //textField名牌
    for (int i = 0; i < 6; i ++) {

        if (i == 4) {
            crack += 8;
        }else if (i == 5){
            crack += 3.5;
        }
        UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(kScreenW * 0.13 , _lbBackgroundView.maxY + 10 + i * (labelH + crack), labelW, labelH)];
        label.text = labelName[i];
        label.textColor = [UIColor blueColor];
        label.font = [UIFont boldSystemFontOfSize:20.0];
        [_backgroundView addSubview:label];
        [label release];
    }
    
    //TCP按钮
    UILabel * TCPLB = [[UILabel alloc]initWithFrame:CGRectMake(kScreenW * 0.47 , _PassWord.maxY + 10, 80, 30)];
    TCPLB.text = @"直连TCP";
    TCPLB.textColor = [UIColor blueColor];
    [_backgroundView addSubview:TCPLB];
    _TCPWwitch = [[UISwitch alloc]initWithFrame:CGRectMake(TCPLB.maxX + 10, TCPLB.y, 0, 0)];
    [_TCPWwitch addTarget:self action:@selector(OnTcp:) forControlEvents:UIControlEventValueChanged];
    _TCPWwitch.on =[CLSettingConfig sharedInstance].isTcp;
    [_backgroundView addSubview:_TCPWwitch];
    
    UIImage * buttonImage = [UIImage imageNamed:@"7"];
    UIEdgeInsets insets = UIEdgeInsetsMake(10  , 10 , 103 , 103 );
    buttonImage = [buttonImage resizableImageWithCapInsets:insets resizingMode:UIImageResizingModeStretch];
    
    //登录按钮
    UIButton * loginButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [loginButton setTitle:@"登  录" forState:UIControlStateNormal];
    loginButton.frame = CGRectMake(kScreenW /2 - 150, _segment.maxY + 10, 300, 40);
    [loginButton setBackgroundImage:buttonImage forState:UIControlStateNormal];
    [loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [loginButton setTitleColor:KtitleColor forState:UIControlStateHighlighted];
    loginButton.titleLabel.font = [UIFont boldSystemFontOfSize:30];
    [loginButton addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
    [_backgroundView addSubview:loginButton];
    
    [labelName release];
    
    BOOL isTcp = [CLSettingConfig sharedInstance].isTcp;
    _TCPWwitch.selected = isTcp;

//    [TCPLB release];
    
//    [userName release];
//    [password release];
//    [service release];
//    [mainUrl release];

}

#pragma mark --按钮方法
//返回
-(void)back {
    [XpaiInterface disconnect];
    [self.navigationController popViewControllerAnimated:YES];
}

//登录
-(void)login {
    
    NSString * userName = [_UserName.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSString * serviceCode = [_serviceCode.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSString * mainUrl = [_mainUrl.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    mainUrl = [mainUrl stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    NSString * mainPotr = [_mainPort.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    [XpaiInterface connectToServer:mainUrl p:[mainPotr intValue] u:userName pd:_PassWord.text svcd:serviceCode OnUDP:!_TCPWwitch.on];
    [CLSettingConfig sharedInstance].SPFWQUserName = userName;
    [CLSettingConfig sharedInstance].SPFWQPassWord = _PassWord.text;
    [CLSettingConfig sharedInstance].SPFWQServiceCode = serviceCode;
    [CLSettingConfig sharedInstance].mainUrl = mainUrl;
    [CLSettingConfig sharedInstance].mainPort = [mainPotr integerValue];
    [CLSettingConfig sharedInstance].isTcp = _TCPWwitch.on;
    [CLSettingConfig sharedInstance].segment = _segment.selectedSegmentIndex;
    [[CLSettingConfig sharedInstance] WriteData];
    
//            [XpaiInterface connectCloud:@"http://c.zhiboyun.com/api/20140928/get_vs" u:@"001" pd:@"001" svcd:@"ZBK_WEIXIN"];
    
}

-(void)OnTcp:(UISwitch *)tcp {
    if (tcp.on == YES) {
        _explainLabel.text = @"当前为直连Tcp";
    }else {
        _explainLabel.text = @"当前为UDP端口";
    }
}


#pragma mark -- 代理方法
//textFiled代理
-(void)textFieldDidBeginEditing:(UITextField *)textField {
    _explainLabel.textColor = self.navigationController.navigationBar.tintColor;
    [_backgroundView bringSubviewToFront:_lbBackgroundView];
    if ([textField isEqual:_PassWord]) {
        [UIView animateWithDuration:0.3 animations:^{
            _explainLabel.text = @"请输入视频服务器密码";
            _backgroundView.y = 0;
            _lbBackgroundView.y = 46;
        }];
    }else if ([textField isEqual:_serviceCode]) {
        [UIView animateWithDuration:0.3 animations:^{
            _explainLabel.text = @"请输入视频服务器服务码，可以为空";
//            _backgroundView.y = -150;
        }];
    }else if([textField isEqual:_mainPort]) {
        [UIView animateWithDuration:0.3 animations:^{
            _explainLabel.text = @"通常9999为UDP端口,2999为TCP端口";
            _backgroundView.y = -150;
            _lbBackgroundView.y = 46 + 150;
        }];
    }
}

-(void)textViewDidBeginEditing:(UITextView *)textView {
    [_backgroundView bringSubviewToFront:_lbBackgroundView];
    _explainLabel.textColor = self.navigationController.navigationBar.tintColor;
    [self.view bringSubviewToFront:_lbBackgroundView];
    [UIView animateWithDuration:0.3 animations:^{
        _explainLabel.text =@"请输入视频服务器地址";
        _backgroundView.y = -150;
        _lbBackgroundView.y = 46+ 150;
    }];
}

-(void)textFieldDidEndEditing:(UITextField *)textField {
    _explainLabel.textColor = self.navigationController.navigationBar.tintColor;
    _explainLabel.text = @"欢迎使用视频服务器服务";
    [UIView animateWithDuration:0.3 animations:^{
        _backgroundView.y = 0;
        _lbBackgroundView.y = 46;
    }];
}



#pragma mark --XpaiInterface的回调
//连接成功
-(void)didConnectToServer {
    NSLog(@"连接成功");
    VRCViewController * VRC = [[VRCViewController alloc]init];
    VRC.isLogin = YES;
    VRC.UserName = _UserName.text;
    VRC.PassWord = _PassWord.text;
    VRC.serviceCode = _serviceCode.text;
    if (_segment.selectedSegmentIndex == 0) {
        VRC.isAcross = YES;
    }else {
        VRC.isAcross = NO;
    }
    VRC.isTcp = _TCPWwitch.on;
    VRC.mainPort = [_mainPort.text intValue];
    VRC.mainUrl = _mainUrl.text;
    VRC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:VRC animated:YES completion:^{
        isLogin = YES;
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

//点击空白处
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [UIView animateWithDuration:0.3 animations:^{
        _backgroundView.y = 0;
        _lbBackgroundView.y = 46;
    }];
    [_backgroundView endEditing:YES];
}
@end
