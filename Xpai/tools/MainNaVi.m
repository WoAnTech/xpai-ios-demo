//
//  MainNaVi.m
//  Xpai
//
//  Created by  cLong on 16/1/12.
//  Copyright © 2016年  沃安科技. All rights reserved.
//

#import "MainNaVi.h"

@interface MainNaVi ()

@end

@implementation MainNaVi

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma  mark --允许屏幕竖屏
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    return (toInterfaceOrientation == UIInterfaceOrientationPortrait);
}

- (BOOL)shouldAutorotate

{
    return NO;
}

-(NSUInteger)supportedInterfaceOrientations

{
    return UIInterfaceOrientationMaskPortrait;//只支持这一个方向(正常的方向)
}

@end
