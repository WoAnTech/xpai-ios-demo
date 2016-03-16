//
//  transcribeView.m
//  Xpai
//
//  Created by  cLong on 16/1/15.
//  Copyright © 2016年 B-Star. All rights reserved.
//

#import "transcribeView.h"
#import "resolutionRatioCell.h"
#import "CLSettingConfig.h"

@interface transcribeView ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView * _tableView;
    NSArray * _dataSource;
}

@end

@implementation transcribeView

-(void)dealloc {
    [_tableView release];
    [_dataSource release];
    [super dealloc];
}

-(instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = KtitleColor;
        [self addData];
        [self addSubViews];
    }
    return self;
}

-(void)addData {
    NSString* phoneVersion = [[UIDevice currentDevice] systemVersion];
    if ([phoneVersion integerValue]>=8.0) {
        _dataSource = [[NSArray alloc]initWithObjects:@"软编码",@"硬编码", nil];
    }else {
        _dataSource = [[NSArray alloc]initWithObjects:@"软编码", nil];
    }

    
}

-(void)addSubViews {
    UILabel * titiLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.width, 30)];
    titiLabel.textAlignment = NSTextAlignmentCenter;
    titiLabel.text = @"设置录制类型";
    titiLabel.font = [UIFont boldSystemFontOfSize:20.0f];
    titiLabel.textColor = [UIColor whiteColor];
    titiLabel.backgroundColor = KtitleColor;
    [self addSubview:titiLabel];
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(2, titiLabel.maxY , self.width - 4, self.height - titiLabel.maxY - 2) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.bounces = NO;
    [self addSubview:_tableView];
    
    [titiLabel release];
}


#pragma mark tableView代理
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataSource.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    resolutionRatioCell * cell = [resolutionRatioCell cellWithTableView:tableView];
    
    cell.contentLB.text = _dataSource[indexPath.row];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([[[UIDevice currentDevice] systemVersion] integerValue] >= 8.0) {
        if (indexPath.row == 0) {
            UIAlertView * alert= [[UIAlertView alloc]initWithTitle:@"友情提示" message:@"您当前选择的是软编吗，直播云推荐使用硬编码，享受更顺畅的直播体验。" delegate:self cancelButtonTitle:@"我知道了" otherButtonTitles:nil, nil];
            [alert show];
        }
    }
  
    [CLSettingConfig sharedInstance].transcribe = indexPath.row;
    [[CLSettingConfig sharedInstance] WriteData];
    
    kNSNotificationCenter;
}
@end
