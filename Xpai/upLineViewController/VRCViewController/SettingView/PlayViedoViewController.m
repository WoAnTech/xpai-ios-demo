//
//  PlayViedoViewController.m
//  Xpai
//
//  Created by  cLong on 16/1/19.
//  Copyright © 2016年 B-Star. All rights reserved.
//

#import "PlayViedoViewController.h"
#import "PlayMoreView.h"
#import "MovNameCell.h"
#import "ViedoPlayViewController.h"
#import "MJChiBaoZiHeader.h"

@interface PlayViedoViewController ()<chooseOption,UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray * _movNameArr;//获取视频文件名
    PlayMoreView * _viedoTableVIew;
    UIView * _titleView;
    UIView *_urlView;
    UITextView * _textView;
    UITableView * ViedoContentsTableView;
    NSString * _pathStr;
    
}

@end

@implementation PlayViedoViewController


-(void)dealloc {
    [_movNameArr release];
    [_viedoTableVIew release];
    [_titleView release];
    [_urlView release];
    [_titleView release];
    [ViedoContentsTableView release];
    [ViedoContentsTableView.tableFooterView release];
    [super dealloc];
}

-(void)viewDidLoad {
    self.view.backgroundColor = [UIColor whiteColor];
    _movNameArr = [[NSMutableArray alloc]init];
    
    [self addData];
    [self addSubViews];
}

//获取数据
-(void)addData {
    NSFileManager * fm = [NSFileManager defaultManager];
    //文件路径
    NSString * FilePath = [NSString stringWithFormat:@"%@/Library",NSHomeDirectory()];
    NSArray * filmNameArr = [fm subpathsAtPath:FilePath];//获取路径内所有文件
    NSString * movStr = @"mov";
    for (NSString * obj in filmNameArr) {//过滤其他文件
        if ([obj hasSuffix:movStr]) {
            
            NSString * path = [NSString stringWithFormat:@"%@/Library/%@",NSHomeDirectory(),obj];
            CGFloat num = [self fileSizeAtPath:path];
            NSLog(@"%@大小%f",obj,num);
            if (num < 1024) {//判断文件大小 是否为空壳 是的话跳过保存
                continue;
            }
            [_movNameArr addObject:obj];
        }
    }
    
}

#pragma mark --搭建界面
//搭建视图
-(void)addSubViews {
    [self titleView];
    [self ViedoTableView];
    [self MoreView];
    [self ViedoURLView];
}

-(void)ViedoTableView {
     ViedoContentsTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, _titleView.maxY, _screenW, _screenH - _titleView.maxY) style:UITableViewStylePlain];
    ViedoContentsTableView.dataSource = self;
    ViedoContentsTableView.delegate = self;
    ViedoContentsTableView.tableFooterView = [[UIView alloc]init];
//    ViedoContentsTableView.bounces = NO;
    ViedoContentsTableView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:ViedoContentsTableView];
    NSLog(@"%lu",(unsigned long)_movNameArr.count);
    ViedoContentsTableView.mj_header = [MJChiBaoZiHeader headerWithRefreshingBlock:^{
        [self refreshData];
    }];
    
    
}

-(void)refreshData {
    [_movNameArr removeAllObjects];
    [self addData];
    [ViedoContentsTableView reloadData];
    [ViedoContentsTableView.mj_header endRefreshing];
}

//视频地址页面
-(void)ViedoURLView {
    CGFloat viewW = _screenW / 3 *2;
    CGFloat viewH = 100;
    _urlView = [[UIView alloc]initWithFrame:CGRectMake(_screenW / 2 - viewW / 2, _screenH / 2 - 70, viewW, viewH)];
    _urlView.backgroundColor = KtitleColor;
    _urlView.alpha = 0;

    [self.view addSubview:_urlView];
    
    UILabel * titileLB = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, viewW, 30)];
    titileLB.text = @"请输入视频播放地址";
    titileLB.backgroundColor = KtitleColor;
    titileLB.textAlignment = NSTextAlignmentCenter;
    titileLB.font = [UIFont boldSystemFontOfSize:20.0f];
    titileLB.textColor = [UIColor whiteColor];
    [_urlView addSubview:titileLB];
    
    UIView * backgroundView = [[UIView alloc]initWithFrame:CGRectMake(2, titileLB.maxY, viewW - 4, viewH - 30 - 2)];
    backgroundView.backgroundColor = [UIColor whiteColor];
    [_urlView addSubview:backgroundView];
    
    _textView = [[UITextView alloc]initWithFrame:CGRectMake(10, 5, viewW - 20, 30)];
    _textView.layer.borderWidth = 1;
    _textView.layer.borderColor = KtitleColor.CGColor;
    _textView.layer.cornerRadius = 6;
    _textView.text = @"http://115.28.33.49:3999/mobile/1-7a6a12c57df0.flv";
    [backgroundView addSubview:_textView];
    
    UIButton * PlayBN = [UIButton buttonWithType:UIButtonTypeSystem];
    [PlayBN setTitle:@"播 放" forState:UIControlStateNormal];
    [PlayBN setTitleColor:KtitleColor forState:UIControlStateNormal];
    PlayBN.frame = CGRectMake(10, 45, 50, 30);
    [PlayBN addTarget:self action:@selector(playViedo) forControlEvents:UIControlEventTouchUpInside];
    [backgroundView addSubview:PlayBN];
    
    UIButton * cancelBN = [UIButton buttonWithType:UIButtonTypeSystem];
    [cancelBN setTitle:@"取 消" forState:UIControlStateNormal];
    [cancelBN setTitleColor:KtitleColor forState:UIControlStateNormal];
    cancelBN.frame = CGRectMake(viewW - 20 - 50, 45, 50, 30);
    [cancelBN addTarget:self action:@selector(cancelViedoURL) forControlEvents:UIControlEventTouchUpInside];
    [backgroundView addSubview:cancelBN];
    
    [titileLB release];
    [backgroundView release];
    [PlayBN release];
    [cancelBN release];
}

//更多操作界面
-(void)MoreView {
    _viedoTableVIew = [[PlayMoreView alloc]initWithFrame:CGRectMake(_screenW - 110, _titleView.maxY, 110, 50)];
    _viedoTableVIew.alpha = 0;
    _viedoTableVIew.Delegate = self;
    [self.view addSubview:_viedoTableVIew];
}

//标题界面
-(void)titleView {
    _titleView = [[UIView alloc]initWithFrame:CGRectMake(0, 20, _screenW,40)];
    _titleView.backgroundColor = KtitleColor;
    [self.view addSubview:_titleView];
    
    UIButton * backButton  = [UIButton buttonWithType:UIButtonTypeSystem];
    [backButton setTitle:@"く" forState:UIControlStateNormal];
    backButton.titleLabel.font = [UIFont boldSystemFontOfSize:20.0f];
    backButton.frame = CGRectMake(0, 5, 50, 30);
    [backButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backView) forControlEvents:UIControlEventTouchUpInside];
    [_titleView addSubview:backButton];
    [backButton release];
    
    UILabel * titleLB = [[UILabel alloc]initWithFrame:CGRectMake(_titleView.width / 2 - 60, 5, 120, 30)];
    NSLog(@"titlb.width%f %f",_titleView.width / 2 - 60,_titleView.width);
    if (_isUpLoad == YES) {
        titleLB.text= @"上传视频列表";
    }else {
        titleLB.text = @"视频播放列表";
    }
    titleLB.textColor = [UIColor whiteColor];
    titleLB.font = [UIFont boldSystemFontOfSize:20.0f];
    [_titleView addSubview:titleLB];
    [titleLB release];
    
    if (!_isUpLoad) {
        UIButton * MoreBT = [[UIButton alloc]initWithFrame:CGRectMake(_screenW - 60, 5, 50, 30)];
        [MoreBT setBackgroundImage:[UIImage imageNamed:@"More"] forState:UIControlStateNormal];
        [MoreBT addTarget:self action:@selector(MoreOperation) forControlEvents:UIControlEventTouchUpInside];
        [_titleView addSubview:MoreBT];
    }
    
}

#pragma mark -- 按钮点击方法
//返回按钮
-(void)backView {
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

//更多操作按钮
-(void)MoreOperation {
    [UIView animateWithDuration:0.3 animations:^{
        if (_viedoTableVIew.alpha == 0) {
            _viedoTableVIew.alpha = 1;
        }else {
            _viedoTableVIew.alpha = 0;
        }
    }];
}

//播放URL页面
-(void)playViedo {
    ViedoPlayViewController * vc = [[ViedoPlayViewController alloc]init];
    vc.PlayFileURL = _textView.text;
    [self presentViewController:vc animated:YES completion:^{
        _urlView.alpha = 0;
        _viedoTableVIew.alpha = 0;
    }];
    [vc release];
}

//取消URL页面
-(void)cancelViedoURL {
    _urlView.alpha = 0;
}

#pragma mark --代理方法
-(void)numOfChoose:(NSInteger)num {
    if (num == 0) {
        [UIView animateWithDuration:0.3 animations:^{
            if (_urlView.alpha == 0) {
                _urlView.alpha =1;
            }else {
                _urlView.alpha = 0;
            }
        }];
    }else {
        [_movNameArr removeAllObjects];
        [self addData];
        [ViedoContentsTableView reloadData];
    }
}

#pragma mark --tableView delegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return _movNameArr.count;
}



-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MovNameCell * cell = [MovNameCell cellWithTableView:tableView];
    cell.textLabel.text = _movNameArr[indexPath.row];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [UIView animateWithDuration:0.3 animations:^{
        _urlView.alpha = 0;
        _viedoTableVIew.alpha = 0;
    }];
    
    if (_isUpLoad == YES) {
        [_Delegate uploadVideoOfFilePath:[NSString stringWithFormat:@"%@/Library/%@",NSHomeDirectory(),_movNameArr[indexPath.row]]];
        [self dismissViewControllerAnimated:YES completion:^{
        }];
        return;
    }
    
    ViedoPlayViewController * viedoPlayView = [[ViedoPlayViewController alloc]init];
//    NSString * str = [NSString stringWithContentsOfFile:<#(nonnull NSString *)#> encoding:NSUTF8StringEncoding error:nil]
    viedoPlayView.PlayFileURL = [NSString stringWithFormat:@"%@/Library/%@",NSHomeDirectory(),_movNameArr[indexPath.row]];
    NSLog(@"%@",viedoPlayView.PlayFileURL);
    
    [self presentViewController:viedoPlayView animated:YES completion:^{
        
    }];
 
}

//-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
//    [UIView animateWithDuration:0.3 animations:^{
//        _urlView.alpha = 0;
//        _viedoTableVIew.alpha = 0;
//    }];
//}

#pragma mark -- 控制屏幕为竖屏显示
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
    return (toInterfaceOrientation == UIInterfaceOrientationPortrait);
}

-(NSUInteger)supportedInterfaceOrientations {
    
    return UIInterfaceOrientationMaskPortrait;
    
}

#pragma mark --判断文件大小
- (long long) fileSizeAtPath:(NSString*) filePath{
    
    NSFileManager* manager = [NSFileManager defaultManager];
    
    if ([manager fileExistsAtPath:filePath]){
        
        return [[manager attributesOfItemAtPath:filePath error:nil] fileSize];
    }
    return 0;
}

@end
