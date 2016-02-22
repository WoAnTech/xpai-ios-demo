
//
//  SaveRedioView.m
//  Xpai
//
//  Created by  cLong on 16/1/18.
//  Copyright © 2016年 北京沃安科技有限公司. All rights reserved.
//

#import "SaveRedioView.h"
#import "ResolutionRatioCell.h"
#import "CLSettingConfig.h"

@interface SaveRedioView ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView * _tableView;
    NSArray * _dataSource;
}
@end

@implementation SaveRedioView

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
    _dataSource = [[NSArray alloc]initWithObjects:@"保存",@"不保存", nil];
    
}

-(void)addSubViews {
    UILabel * titiLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.width, 30)];
    titiLabel.textAlignment = NSTextAlignmentCenter;
    titiLabel.text = @"是否保存视频";
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
    ResolutionRatioCell * cell = [ResolutionRatioCell cellWithTableView:tableView];
    
    cell.contentLB.text = _dataSource[indexPath.row];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        [CLSettingConfig sharedInstance].SaveRedio = TRUE;
    }else {
        [CLSettingConfig sharedInstance].SaveRedio = FALSE;
    }
    [[CLSettingConfig sharedInstance] WriteData];
    
    kNSNotificationCenter;
}


@end
