//
//  MovNameCell.m
//  Xpai
//
//  Created by  cLong on 16/1/19.
//  Copyright © 2016年 北京沃安科技有限公司. All rights reserved.
//

#import "MovNameCell.h"

@implementation MovNameCell

+(instancetype)cellWithTableView:(UITableView *)tableView {
    NSString * str = @"MovName";
    MovNameCell * cell = [tableView dequeueReusableCellWithIdentifier:str];
    if (!cell) {
        cell = [[MovNameCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
        
        [cell createSubView];
    }
    return cell;
}

-(void)createSubView {
    _MovImageView = [[UIImageView alloc]initWithFrame:CGRectMake(5, 0, self.height, self.height)];
    _MovImageView.layer.cornerRadius = 6;
    [self.contentView addSubview:_MovImageView];
    
    _textLB = [[UILabel alloc]initWithFrame:CGRectMake(_MovImageView.maxX + 5, 0, self.width - _MovImageView.maxX, self.height)];
    _textLB.font = [UIFont boldSystemFontOfSize:20.0f];
    _textLB.textColor = KtitleColor;
    [self.contentView addSubview:_textLB];
    
}

@end
