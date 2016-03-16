//
//  SettingViewCell.h
//  Xpai
//
//  Created by  cLong on 16/1/14.
//  Copyright © 2016年 B-Star. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingViewCell : UITableViewCell

+(instancetype)CellWithTableView:(UITableView * )tableView;
@property (nonatomic,retain)UILabel * titleLB;
@property (nonatomic,retain)UILabel * parameterLB;

@end
