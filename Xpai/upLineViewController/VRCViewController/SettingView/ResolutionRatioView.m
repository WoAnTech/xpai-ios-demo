//
//  resolutionRatioView.m
//  Xpai
//
//  Created by  cLong on 16/1/14.
//  Copyright © 2016年 B-Star. All rights reserved.
//

#import "resolutionRatioView.h"
#import "resolutionRatioCell.h"
#import "CLSettingConfig.h"

@interface resolutionRatioView ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_resolutionRatioTV;
    NSArray *_dataSource;
}

@end

@implementation resolutionRatioView

-(void)dealloc {
    [_resolutionRatioTV release];
    [_dataSource release];
    
    [super dealloc];
}

-(instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor colorWithRed:0 green:0.6 blue:1 alpha:1];
        [self addDatasource];

        [self addSubViews];
    }
    return self;
}

-(void)addDatasource {
    _dataSource = [[NSArray alloc]initWithObjects:@"192x144",@"480x360",@"640x480",@"1280x720", nil];
}

-(void)addSubViews {
    UILabel * titiLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.width, 30)];
    titiLabel.textAlignment = NSTextAlignmentCenter;
    titiLabel.text = @"设置分辨率";
    titiLabel.font = [UIFont boldSystemFontOfSize:20.0f];
    titiLabel.textColor = [UIColor whiteColor];
    titiLabel.backgroundColor = self.backgroundColor;
    [self addSubview:titiLabel];
    
    _resolutionRatioTV = [[UITableView alloc]initWithFrame:CGRectMake(2, titiLabel.maxY , self.width - 4, self.height - titiLabel.maxY - 2) style:UITableViewStylePlain];
    _resolutionRatioTV.delegate = self;
    _resolutionRatioTV.dataSource = self;
    _resolutionRatioTV.bounces = NO;
    [self addSubview:_resolutionRatioTV];
    
    [titiLabel release];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataSource.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    resolutionRatioCell * cell = [resolutionRatioCell cellWithTableView:tableView];
    cell.contentLB.text = _dataSource[indexPath.row];
    
    return cell;
}

//选中行数
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"%ld",(long)indexPath.row);
    
    NSInteger num = indexPath.row;
    
    [CLSettingConfig sharedInstance].resolution = num;
    [[CLSettingConfig sharedInstance] WriteData];
    //创建通知传值
    NSNotification * notification = [NSNotification notificationWithName:@"resolution" object:_dataSource[num]];
    NSLog(@"分辨率%d",num);
    [[NSNotificationCenter defaultCenter]postNotification:notification];
//    [notification release];
}

@end
