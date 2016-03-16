//
//  SwttingView.h
//  Xpai
//
//  Created by  cLong on 16/1/14.
//  Copyright © 2016年 B-Star. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SubViewName <NSObject>

-(void)subViewAppearWithNum:(NSInteger)num;

@end

@interface SwttingView : UIView

@property (nonatomic,assign)id<SubViewName> delegate;

@end
