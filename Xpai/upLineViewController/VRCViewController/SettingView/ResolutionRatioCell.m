//
//  resolutionRatioCell.m
//  Xpai
//
//  Created by  cLong on 16/1/14.
//  Copyright © 2016年 北京沃安科技有限公司. All rights reserved.
//

#import "ResolutionRatioCell.h"

@implementation ResolutionRatioCell

-(void)dealloc {
    [_contentLB release];
    [super dealloc];
}

+(instancetype)cellWithTableView:(UITableView *)tableView {
    NSString * str = @"resolutionRation";
    
    ResolutionRatioCell * cell = [tableView dequeueReusableCellWithIdentifier:str];
    
    if (!cell) {
        cell = [[ResolutionRatioCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
        [cell addSubViews];
    }
    return cell;
}

-(void)addSubViews {
    UIView * colorView = [[UIView alloc]initWithFrame:CGRectMake(0, self.height - 2, self.width, 2)];
    [self addSubview:colorView];
    
    _contentLB = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, self.width, self.height - 1)];
    _contentLB.textAlignment = NSTextAlignmentNatural;
    _contentLB.textColor = [UIColor blackColor];
    _contentLB.backgroundColor = [UIColor whiteColor];
    _contentLB.font = [UIFont boldSystemFontOfSize:15.0f];
    [self addSubview:_contentLB];
}

@end
