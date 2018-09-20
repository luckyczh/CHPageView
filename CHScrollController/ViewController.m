//
//  ViewController.m
//  CHScrollController
//
//  Created by Jemmy on 2018/9/19.
//  Copyright © 2018年 Jemmy. All rights reserved.
//

#import "ViewController.h"
#import "TestViewController.h"
#import "TestTableViewController.h"
#import "CHPageView.h"
@interface ViewController ()<CHTitleDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CHPageView *vi = [[CHPageView alloc] initWithFrame:self.view.bounds];
    [vi configWithParent:self titleArray:@[@"标题1",@"这是最长的标题",@"哈哈",@"国产片",@"最后一个标题",@"标题1",@"这是最长的标题",@"哈哈",@"国产片",@"最后一个标题"] childVc:@[[TestTableViewController new],[TestTableViewController new],[TestViewController new],[TestTableViewController new],[TestViewController new],[TestTableViewController new],[TestTableViewController new],[TestViewController new],[TestTableViewController new],[TestViewController new]]];
    vi.frame = CGRectMake(0, 44, self.view.bounds.size.width, self.view.bounds.size.height - 44);
    [self.view addSubview:vi];
    
    
}
-(void)clickButton:(UIButton *)sender{
    NSLog(@"%ld---%@",sender.tag,sender.currentTitle);
}

@end
