//
//  PlayMoreView.m
//  Xpai
//
//  Created by  cLong on 16/1/19.
//  Copyright © 2016年 B-Star. All rights reserved.
//

#import "PlayMoreView.h"
#import "resolutionRatioCell.h"

@interface PlayMoreView ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView * _tableView;
    NSArray * _DataSource;
}

@end

@implementation PlayMoreView

-(void)dealloc {
    [_tableView release];
    [_DataSource release];
    [super dealloc];
}

-(instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = KtitleColor;
        [self createDataSource];
        [self createSubView];
    }
    return self;
}

-(void)createDataSource {
    _DataSource = [[NSArray alloc]initWithObjects:@"输入视频地址", nil];
}

-(void)createSubView {
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(2, 2, self.width - 4, self.height - 4) style:UITableViewStylePlain];
    _tableView.backgroundColor = [UIColor whiteColor];
    _tableView.bounces = NO;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self addSubview:_tableView];
}

#pragma mark --tableView delegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _DataSource.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    resolutionRatioCell * cell = [resolutionRatioCell cellWithTableView:tableView];
    cell.contentLB.text = _DataSource[indexPath.row];
    return  cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [_Delegate numOfChoose:indexPath.row];
}

@end
