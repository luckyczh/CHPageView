//
//  CHContainView.h
//  CHScrollController
//
//  Created by Jemmy on 2018/9/19.
//  Copyright © 2018年 Jemmy. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/**
 底层视图，装载顶部滑动导航栏和中间视图
 */
@interface CHPageView : UIView
-(void)configWithParent:(UIViewController *)parent titleArray:(NSArray<NSString *> *)titles childVc:(NSArray<UIViewController *> *)children;
@end

NS_ASSUME_NONNULL_END

#pragma mark - 滑动导航栏

@protocol CHTitleDelegate <NSObject>

-(void)clickButton:(UIButton *)sender;

@end

@interface CHTitleView : UIScrollView
@property(nonatomic,strong)NSArray<NSString *> *titleArray;
@property(nonatomic,weak)id<CHTitleDelegate> clickDelegate;

-(void)beganAnimal:(UIButton *)sender;
@end

#pragma mark - 内容视图

@protocol CHContentViewDelegate <NSObject>

-(void)didScroll:(UIScrollView *)scrollView index:(NSInteger)index;

@end
@interface CHContentView : UIScrollView<UIScrollViewDelegate>
@property (nonatomic,strong) NSArray<UIViewController *> *vcArray;
@property (nonatomic,weak) id<CHContentViewDelegate> scrollDelegate;
@end

