//
//  BitStreamView.h
//  Xpai
//
//  Created by  cLong on 16/1/15.
//  Copyright © 2016年 北京沃安科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BitStream <NSObject>

-(void)NumWithBitStream:(NSInteger)num;

@end
@interface BitStreamView : UIView
@property (nonatomic,assign)id<BitStream> Delegate;

@end
