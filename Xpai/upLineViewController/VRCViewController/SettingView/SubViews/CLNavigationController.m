//
//  CLNavigationController.m
//  Xpai
//
//  Created by  cLong on 16/1/29.
//  Copyright © 2016年 B-Star. All rights reserved.
//

#import "CLNavigationController.h"

@implementation CLNavigationController

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
    return (toInterfaceOrientation == UIInterfaceOrientationPortrait);
}

-(NSUInteger)supportedInterfaceOrientations {
    
    return UIInterfaceOrientationMaskPortrait;
}

- (BOOL)shouldAutorotate{
    return NO;
}

@end
