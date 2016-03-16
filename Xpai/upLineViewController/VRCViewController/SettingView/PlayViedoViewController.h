//
//  PlayViedoViewController.h
//  Xpai
//
//  Created by  cLong on 16/1/19.
//  Copyright © 2016年 B-Star. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol uploadChooseVideoDelegate <NSObject>

-(void)uploadVideoOfFilePath:(NSString *)filePath;

@end

@interface PlayViedoViewController : UIViewController
@property(nonatomic,assign)BOOL isUpLoad;
@property(nonatomic,assign)id <uploadChooseVideoDelegate>Delegate;


@property(nonatomic,assign)CGFloat screenW;
@property(nonatomic,assign)CGFloat screenH;


@end
