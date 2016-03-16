//
//  SettingViewCell.m
//  Xpai
//
//  Created by  cLong on 16/1/14.
//  Copyright © 2016年 B-Star. All rights reserved.
//

#import "SettingViewCell.h"

@implementation SettingViewCell

-(void)dealloc {
    [_titleLB release];
    [_parameterLB release];
    
    [super dealloc];
}
+(instancetype)CellWithTableView:(UITableView *)tableView {
    NSString * str = @"settingViewCell";
    
    SettingViewCell * settingCell = [tableView dequeueReusableCellWithIdentifier:str ];
    if (!settingCell) {
        settingCell = [[SettingViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
        
        [settingCell addSubViewsWidth:tableView.width];
    }
    
    return settingCell;
}

-(void)addSubViewsWidth:(CGFloat)TBWidth {
    UIView * colorView = [[UIView alloc]initWithFrame:CGRectMake(0, self.height - 1, TBWidth, 1)];
//    NSLog(@"settingcellW %f %f",TBWidth ,self.height);
    colorView.backgroundColor = [UIColor colorWithRed:0 green:0.6 blue:1 alpha:1];
    [self.contentView addSubview:colorView];
    
    _titleLB = [[UILabel alloc]initWithFrame:CGRectMake(5, 0, 100, self.height)];
    _titleLB.font = [UIFont boldSystemFontOfSize:15.0f];
    _titleLB.textColor = [UIColor blackColor];
    [self addSubview:_titleLB];
    
    _parameterLB = [[UILabel alloc]initWithFrame:CGRectMake(TBWidth - 95,0, 90, self.height)];
    _parameterLB.font = [UIFont boldSystemFontOfSize:10.0f];
    _parameterLB.textColor = [UIColor blueColor];
    _parameterLB.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:_parameterLB];
    
}

@end
