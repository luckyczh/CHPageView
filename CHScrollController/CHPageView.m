//
//  CHContainView.m
//  CHScrollController
//
//  Created by Jemmy on 2018/9/19.
//  Copyright © 2018年 Jemmy. All rights reserved.
//

#import "CHPageView.h"


 /**菜单栏高度*/
#define Title_Height 40
#define Font(s) [UIFont systemFontOfSize:s]
#define ScreenW [UIScreen mainScreen].bounds.size.width
#define ScreenH [UIScreen mainScreen].bounds.size.height
/**
 整个内容视图，包括分类栏和控制器视图
 */
@interface CHPageView()<CHTitleDelegate,CHContentViewDelegate>
@property (nonatomic,strong) CHTitleView *titleView;
@property (nonatomic,strong) CHContentView *contentView;
@end
@implementation CHPageView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initUI];
    }
    return self;
}

-(void)initUI{
    _titleView = [[CHTitleView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, 40)];
    _titleView.clickDelegate = self;
    [self addSubview:_titleView];
    _contentView = [[CHContentView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_titleView.frame), self.bounds.size.width, self.bounds.size.height - 40)];
    _contentView.scrollDelegate = self;
    [self addSubview:_contentView];
}

// MARK: 配置视图
-(void)configWithParent:(UIViewController *)parent titleArray:(NSArray<NSString *> *)titles childVc:(NSArray<UIViewController *> *)children{
    for (UIViewController *vc  in children) {
        [parent addChildViewController:vc];
    }
    _titleView.titleArray = titles;
    _contentView.vcArray = children;
    _contentView.contentOffset = CGPointMake( 0, 0);
    [_contentView scrollViewDidEndDecelerating:_contentView];
    
}

-(void)clickButton:(UIButton *)sender{
    
    self.contentView.contentOffset = CGPointMake((sender.tag - 999) * ScreenW, 0);
    [_contentView scrollViewDidEndDecelerating:_contentView];
}

- (void)didScroll:(UIScrollView *)scrollView index:(NSInteger)index{
    UIButton *selectBut = [_titleView viewWithTag:index];
    [_titleView beganAnimal:selectBut];
}

@end

#pragma mark - 菜单栏

/**
 分类栏
 */
@implementation CHTitleView{
    UIButton *_lastBut;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initUI];
    }
    return self;
}

-(void)initUI{
    self.showsVerticalScrollIndicator = NO;
    self.showsHorizontalScrollIndicator = NO;
}

- (void)setTitleArray:(NSArray<NSString *> *)titleArray{
    _titleArray = titleArray;
    NSInteger count = titleArray.count;
    CGFloat lastX = 0;
    for (int i = 0; i < count; i ++) {
        NSString * title = titleArray[i];
        UIButton *but = [UIButton buttonWithType:UIButtonTypeCustom];
        [but setTitle:title forState:UIControlStateNormal];
        [but setTitleColor:[UIColor blueColor] forState:UIControlStateSelected];
        but.titleLabel.font = Font(17);
        but.tag = i + 999;
        [but addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
        [but setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        CGSize size = [title sizeWithAttributes:@{NSFontAttributeName:Font(17)}];
        but.frame = CGRectMake(lastX, 0, size.width + 20, Title_Height);
        lastX = CGRectGetMaxX(but.frame);
        [self addSubview:but];
        if (i == 0){
            but.selected = YES;
            but.transform = CGAffineTransformMakeScale(1.2, 1.2);
            _lastBut = but;
        }
    }
    self.contentSize = CGSizeMake(lastX, Title_Height);
}

-(void)titleClick:(UIButton *)sender{
    if (_lastBut == sender){return;}
    [self beganAnimal:sender];
    if ([self.clickDelegate respondsToSelector:@selector(clickButton:)]){
        [self.clickDelegate clickButton:sender];
    }
}

// MARK: 按钮动画
-(void)beganAnimal:(UIButton *)sender{
    // 滑动距离 使标题处于中间
    CGFloat offsetX;
   if (sender.center.x < self.center.x){
        offsetX = 0;
   }else if (sender.center.x > self.center.x && sender.center.x < self.contentSize.width - self.center.x){
       offsetX = -self.center.x + sender.center.x;
   }else{
        offsetX = self.contentSize.width - ScreenW;
    }
    [UIView animateWithDuration:0.1 animations:^{
        self->_lastBut.transform = CGAffineTransformIdentity;
         self.contentOffset = CGPointMake(offsetX, 0);
        sender.transform = CGAffineTransformMakeScale(1.2, 1.2);
    }];
    _lastBut.selected = NO;
    sender.selected = YES;
    _lastBut = sender;
}

@end

#pragma mark - 视图内容


@implementation CHContentView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initUI];
    }
    return self;
}

-(void)initUI{
    self.showsVerticalScrollIndicator = NO;
    self.showsHorizontalScrollIndicator = NO;
    self.pagingEnabled = YES;
    self.delegate = self;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    CGFloat offsetX = scrollView.contentOffset.x;
    NSInteger index = offsetX / ScreenW;
    UIViewController *vc = self.vcArray[index];
    
    if(![vc isViewLoaded]){
        vc.view.frame = CGRectMake(ScreenW * index, 0, ScreenW, self.bounds.size.height);
        [self addSubview:vc.view];
    }
    if ([self.scrollDelegate respondsToSelector:@selector(didScroll:index:)]){
        [self.scrollDelegate didScroll:scrollView index:index + 999];
    }
}


-(void)setVcArray:(NSArray<UIViewController *> *)vcArray{
    _vcArray = vcArray;
    self.contentSize = CGSizeMake(ScreenW * vcArray.count, self.bounds.size.height);
}

@end
