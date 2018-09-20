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
    
    
    
    
}
-(void)clickButton:(UIButton *)sender{
    NSLog(@"%ld---%@",sender.tag,sender.currentTitle);
}

@end
