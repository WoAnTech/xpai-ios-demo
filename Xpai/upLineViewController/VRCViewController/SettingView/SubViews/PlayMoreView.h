//
//  PlayMoreView.h
//  Xpai
//
//  Created by  cLong on 16/1/19.
//  Copyright © 2016年 B-Star. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol chooseOption <NSObject>

-(void)numOfChoose:(NSInteger)num;

@end

@interface PlayMoreView : UIView


@property (nonatomic,assign)id <chooseOption> Delegate;

@end
