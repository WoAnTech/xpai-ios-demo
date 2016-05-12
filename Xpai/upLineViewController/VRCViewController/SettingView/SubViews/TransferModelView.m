//
//  TransferModelView.m
//  Xpai
//
//  Created by  cLong on 16/4/28.
//  Copyright © 2016年 B-Star. All rights reserved.
//

#import "TransferModelView.h"
#import "resolutionRatioCell.h"
#import "CLSettingConfig.h"

@interface TransferModelView ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView * _transferTableView;
    NSArray * _dataSource;
}

@end

@implementation TransferModelView

-(void)dealloc {
    [_transferTableView release];
    [_dataSource release];
    [super dealloc];
}

-(instancetype)initWithFrame:(CGRect)frame {
    if ([super initWithFrame:frame]) {
        self.layer.borderWidth = 2;
        self.layer.borderColor = [KtitleColor CGColor];
        self.backgroundColor = KtitleColor;
        [self initData];
        [self createSubview];
    }
    return self;
}

-(void)initData {
    _dataSource = [[NSArray alloc]initWithObjects:@"视频+音频",@"仅视频",@"仅音频", nil];
}

-(void)createSubview {
    UILabel * titiLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.width, 30)];
    titiLabel.textAlignment = NSTextAlignmentCenter;
    titiLabel.text = @"设置录制格式";
    titiLabel.font = [UIFont boldSystemFontOfSize:20.0f];
    titiLabel.textColor = [UIColor whiteColor];
    titiLabel.backgroundColor = self.backgroundColor;
    [self addSubview:titiLabel];
    
    _transferTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, titiLabel.maxY, self.width, self.height - 30) style:UITableViewStylePlain];
    _transferTableView.delegate = self;
    _transferTableView.dataSource = self;
    _transferTableView.bounces = NO;
    [self addSubview:_transferTableView];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataSource.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    resolutionRatioCell * cell = [resolutionRatioCell cellWithTableView:tableView];
    cell.contentLB.text = _dataSource[indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [CLSettingConfig sharedInstance].TransferModel = indexPath.row;
    [[CLSettingConfig sharedInstance]WriteData];
    kNSNotificationCenter;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
