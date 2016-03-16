//
//  AudioParameterView.h
//  Xpai
//
//  Created by  cLong on 16/1/18.
//  Copyright © 2016年 B-Star. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol chooseAudioSampling <NSObject>

-(void)ShowSamplingView;

@end

@interface AudioParameterView : UIView

@property (nonatomic,assign)id<chooseAudioSampling> delegate;

@end
