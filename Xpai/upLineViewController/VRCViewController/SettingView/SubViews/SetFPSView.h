//
//  SetFPSView.h
//  Xpai
//
//  Created by  cLong on 16/4/18.
//  Copyright © 2016年 B-Star. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SetFPSViewDelegate <NSObject>

-(void)SetFPSWithMax:(int)MaxFPS Min:(int)MinFPS;

@end

@interface SetFPSView : UIView

@property (nonatomic,assign)id <SetFPSViewDelegate>delegate;



@end
