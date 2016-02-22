//
//  SettingView.h
//  Xpai
//
//  Created by  cLong on 16/1/14.
//  Copyright © 2016年 北京沃安科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SubViewName <NSObject>

-(void)subViewAppearWithNum:(NSInteger)num;

@end

@interface SettingView : UIView

@property (nonatomic,assign)id<SubViewName> delegate;

@end
