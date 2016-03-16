//
//  MovNameCell.h
//  Xpai
//
//  Created by  cLong on 16/1/19.
//  Copyright © 2016年 B-Star. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MovNameCell : UITableViewCell

+(instancetype)cellWithTableView:(UITableView *)tableView;

@property (nonatomic,retain)UIImageView * MovImageView;
@property (nonatomic,retain)UILabel * textLB;

@end
