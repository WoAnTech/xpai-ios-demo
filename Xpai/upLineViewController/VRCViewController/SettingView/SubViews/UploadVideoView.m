//
//  UploadVideoView.m
//  Xpai
//
//  Created by  cLong on 16/1/22.
//  Copyright © 2016年 B-Star. All rights reserved.
//

#import "UploadVideoView.h"

@interface UploadVideoView ()
{
    UIButton * _UpLoadImageBN; //上传图片
    UIButton * _UpLoadOfflineVideoBN;//上传离线录制视频
    UIButton * _continueUpLoadVideoFileBN;// 续传视频文件
    UIButton * _testBN;//测试按钮
}

@end

@implementation UploadVideoView

-(void)dealloc {

    [super dealloc];
}

-(instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor blackColor];
        self.alpha = 0.5;
        [self createSubView];
    }
    
    return self;
}

-(void)createSubView {
    CGFloat buttonW = self.width / 4 - 10;

    //上传照片按钮
    _UpLoadImageBN = [UIButton buttonWithType:UIButtonTypeSystem];
    [_UpLoadImageBN setTitle:@"上传照片" forState:UIControlStateNormal];
    _UpLoadImageBN.frame = CGRectMake(5, 0, buttonW, self.height);
    _UpLoadImageBN.tag = uploadTag + 0;
    [_UpLoadImageBN addTarget:self action:@selector(clickBN:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_UpLoadImageBN];
    
    //上传离线视频按钮
    _UpLoadOfflineVideoBN = [UIButton buttonWithType:UIButtonTypeSystem];
    [_UpLoadOfflineVideoBN setTitle:@"上传离线视频" forState:UIControlStateNormal];
    _UpLoadOfflineVideoBN.frame = CGRectMake(_UpLoadImageBN.maxX, 0,buttonW, self.height);
    _UpLoadOfflineVideoBN.tag = uploadTag + 1;
    [_UpLoadOfflineVideoBN addTarget:self action:@selector(clickBN:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_UpLoadOfflineVideoBN];
    
    //续传视频
    _continueUpLoadVideoFileBN = [UIButton buttonWithType:UIButtonTypeSystem];
    [_continueUpLoadVideoFileBN setTitle:@"续传视频" forState:UIControlStateNormal];
    _continueUpLoadVideoFileBN.frame = CGRectMake(_UpLoadOfflineVideoBN.maxX, 0, buttonW, self.height);
    _continueUpLoadVideoFileBN.tag = uploadTag + 2;
    [_continueUpLoadVideoFileBN addTarget:self action:@selector(clickBN:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_continueUpLoadVideoFileBN];
    
    //测试按钮
    _testBN = [UIButton buttonWithType:UIButtonTypeSystem];
    [_testBN setTitle:@"测试按钮" forState:UIControlStateNormal];
    _testBN.frame = CGRectMake(_continueUpLoadVideoFileBN.maxX, 0, buttonW, self.height);
    _testBN.tag = uploadTag + 3;
    [_testBN addTarget:self action:@selector(clickBN:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_testBN];
    
}

//点击方法
-(void)clickBN:(UIButton *)button {
    NSInteger num = button.tag - uploadTag;
   
    [_Delegate uploadKindOfNum:num];
}

@end
