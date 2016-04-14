//
//  SwttingView.m
//  Xpai
//
//  Created by  cLong on 16/1/14.
//  Copyright © 2016年 B-Star. All rights reserved.
//

#import "SwttingView.h"
#import "SettingViewCell.h"
#import "resolutionRatioView.h"
#import "CLSettingConfig.h"
#import "NetOverTimeView.h"

@interface SwttingView ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView * _SettingView;
    NSArray *_dataSource;
    NSMutableArray * _ObjectSource;
    
    CGFloat SubViewW;
    CGFloat SubViewH;
    
    NSArray * _resolutionArr;
    NSArray * _transcribeViewArr;
    NSArray * _audioParameterArr;
}

@end
@implementation SwttingView

-(instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor colorWithRed:0 green:0.6 blue:1 alpha:1];
        [self receiveNotification];
        [self initArray];
        [self addData];
        [self addObject];
        [self addSubViews:frame];
        
    }
    return self;
}

//初始化需要的数组
-(void)initArray {
    _resolutionArr = [[NSArray alloc]initWithObjects:@"192x144",@"480x360",@"640x480",@"1280x720",@"640x360", nil];
    
    _transcribeViewArr = [[NSArray alloc]initWithObjects:@"软编码",@"硬编码", nil];
    
    _audioParameterArr = [[NSArray alloc]initWithObjects:@"Amr-NB",@"ACC", nil];
}
//通知中心
-(void)receiveNotification {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(GetResolution:) name:@"resolution" object:nil]; //分辨率通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(GetResolution:) name:@"changOtherPara" object:nil];//改变其他参数
}

-(void)dealloc {
    [_resolutionArr release];
    [_dataSource release];
    [_SettingView release];
    [_transcribeViewArr release];
    [_audioParameterArr release];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [super dealloc];
}

//设置分类内容
-(void)addData {
    _dataSource = [[NSArray alloc]initWithObjects:@"分辨率",@"码流",@"网络超时",@"重连超时",@"录制类型",@"音频编码参数",@"输出格式标签",@"网络自适应",@"保存视频文件", nil];
    
    SubViewW = kScreenH / 3;
    SubViewH = kScreenW - 20;
//    NSLog(@"subView %f subViewH%f",SubViewW,SubViewH);
}

-(void)addObject {
    if (_ObjectSource == nil) {
        _ObjectSource = [NSMutableArray array];
    }
    
}

#pragma mark --搭建视图
//创建视图
-(void)addSubViews:(CGRect)frame {
    UILabel * titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, 30)];
    titleLabel.text = @"设置";
    titleLabel.font = [UIFont boldSystemFontOfSize:25];
    titleLabel.backgroundColor = [UIColor colorWithRed:0 green:0.6 blue:1 alpha:1];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:titleLabel];
    
    _SettingView = [[UITableView alloc]initWithFrame:CGRectMake(0, titleLabel.maxY, frame.size.width- 2, frame.size.height - titleLabel.maxY - 2) style:UITableViewStylePlain];
    _SettingView.delegate = self;
    _SettingView.dataSource = self;
    _SettingView.bounces = NO;
    _SettingView.backgroundColor = [UIColor whiteColor];
    [self addSubview:_SettingView];
    
    [titleLabel release];
    
}

#pragma mark --tableView代理
//创建TableView行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataSource.count;
}

//设置Cell
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    SettingViewCell * cell = [SettingViewCell CellWithTableView:tableView];
    cell.titleLB.text = _dataSource[indexPath.row];
    [[CLSettingConfig sharedInstance] loadData];
    cell.parameterLB.text = @"1231231313";
    
    switch (indexPath.row) {
        case 0:
        {
            int num = (int)[CLSettingConfig sharedInstance].resolution;
            if (num == 9) {
                num = 4;
            }
            
            cell.parameterLB.text = _resolutionArr[num];
        }
            break;
        case 1:
        {
            cell.parameterLB.text = [NSString stringWithFormat:@"%ld",(long)[CLSettingConfig sharedInstance].BitStream];
        }
            break;
        case 2:
        {
         cell.parameterLB.text = [NSString stringWithFormat:@"%ld",(long)[CLSettingConfig sharedInstance].NetOverTime];
        }
            break;
        case 3:
        {
            cell.parameterLB.text = [NSString stringWithFormat:@"%ld",(long)[CLSettingConfig sharedInstance].reconnectOverTime];
            
        }
            break;

        case 4:
        {
            NSLog(@"%ld",(long)[CLSettingConfig sharedInstance].transcribe);
            cell.parameterLB.text = _transcribeViewArr[[CLSettingConfig sharedInstance].transcribe];
        }
            break;
        case 5:
        {
            
            int num = (int)[CLSettingConfig sharedInstance].audioParameter -1 ;
            NSLog(@"audioarmeter %ld",(long)[CLSettingConfig sharedInstance].audioParameter);
            cell.parameterLB.text = _audioParameterArr[num];
        }
            break;
        case 6:
        {
            cell.parameterLB.text = [CLSettingConfig sharedInstance].outPutTag;
            
        }
            break;
        case 7:
        {
            if ([CLSettingConfig sharedInstance].NetDeption == TRUE) {
                cell.parameterLB.text = @"开启";
            }else {
                cell.parameterLB.text = @"关闭";
            }
        }
            break;
        case 8:
        {
            if ([CLSettingConfig sharedInstance].SaveRedio == TRUE) {
                cell.parameterLB.text = @"保存";
            }else {
                cell.parameterLB.text = @"不保存";
            }
        }
            break;
            
        default:
            break;
    }
    
    
    return cell;
}

//点击行数
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [_delegate subViewAppearWithNum:indexPath.row];
    }

//接收通知
-(void)GetResolution:(NSNotification *)num {
    [_SettingView reloadData];
}
@end
