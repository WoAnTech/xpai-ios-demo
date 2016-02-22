//
//  UploadVideoView.h
//  Xpai
//
//  Created by  cLong on 16/1/22.
//  Copyright © 2016年 北京沃安科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol upLoadVideoDelegate <NSObject>

-(void)uploadKindOfNum:(NSInteger)num;

@end

@interface UploadVideoView : UIView

@property(nonatomic,assign)id <upLoadVideoDelegate>Delegate;


@end
