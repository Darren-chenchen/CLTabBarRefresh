//
//  CLTabBarVIew.m
//  Relax
//
//  Created by Darren on 15/12/8.
//  Copyright © 2015年 darren. All rights reserved.
//

#import "CLTabBarVIew.h"
#import "CLCustomButton.h"


@interface CLTabBarVIew()

@property(nonatomic,strong)NSMutableArray *customBtns;
@property(nonatomic,weak)CLCustomButton *selectedBtn;


@end

@implementation CLTabBarVIew

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(TabBarEndRefresh:) name:@"TabBarEndRefreshing" object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshBegin) name:@"refreshBegin" object:nil];

    }
    return self;
}

- (void)refreshBegin
{
    if ([self.selectedBtn.currentImage isEqual:[UIImage imageNamed:[NSString stringWithFormat:@"tabBar_S%ld",self.selectedBtn.tag]]]) {
        [self.selectedBtn setImage:[UIImage imageNamed:@"rotation"] forState:UIControlStateSelected];
        CABasicAnimation *rotation = [CABasicAnimation animation];
        
        rotation.duration = 1;
        rotation.repeatCount = MAXFLOAT;
        rotation.keyPath = @"transform.rotation.z";
        rotation.toValue = @(M_PI*2);
        [self.selectedBtn.imageView.layer addAnimation:rotation forKey:nil];
    }
}
- (void)TabBarEndRefresh:(NSNotification *)notic
{
   // 当tabbar正在转动的过程，切换tabbar，点击下一个tabbar转动，如果不加这个判断，转动会比下拉刷新提前结束，原因是首页的延时操作还在进行，是首页的通知触发了这个方法，导致购物车的转动提前结束
    if ([notic.object integerValue] == self.selectedBtn.tag) {
        [self.selectedBtn.imageView.layer removeAllAnimations];
        
        [self.selectedBtn setImage:[UIImage imageNamed:[NSString stringWithFormat:@"tabBar_S%ld",self.selectedBtn.tag]] forState:UIControlStateSelected];
    }
}
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (NSMutableArray *)customBtns
{
    if (_customBtns == nil) {
        _customBtns = [NSMutableArray array];
    }
    return _customBtns;
}

// 一次添加3个button,在每创建一个控制器是就会调用一次这个方法
- (void)addCustomButtonWithitem:(UITabBarItem *)item
{
    CLCustomButton *customBtn = [[CLCustomButton alloc] init];
    customBtn.item = item;
    
    [self addSubview:customBtn];
    [self.customBtns addObject:customBtn];
    
    //监听按钮点击
    [customBtn addTarget:self action:@selector(clickbtn:) forControlEvents:UIControlEventTouchDown];
}

- (void)clickbtn:(CLCustomButton *)btn;
{
    if ([self.delegate respondsToSelector:@selector(tabbar:DidSeletedFrom:To:)]) {
        [self.delegate tabbar:self DidSeletedFrom:self.selectedBtn.tag To:btn.tag];
    }
    
    // 防止重复点击
    if ([btn.currentImage isEqual:[UIImage imageNamed:@"rotation"]]) {
        return;
    }
    
    // 解决转动过程中切换tabbar的bug
    if (btn.tag!=self.selectedBtn.tag) {
        [self.selectedBtn setImage:[UIImage imageNamed:[NSString stringWithFormat:@"tabBar_S%ld",self.selectedBtn.tag]] forState:UIControlStateSelected];
        [self.selectedBtn.imageView.layer removeAllAnimations];
    }

    //选中状态再添加动画
    if (btn.state==UIControlStateSelected) {
        [btn setImage:[UIImage imageNamed:@"rotation"] forState:UIControlStateSelected];
        CABasicAnimation *rotation = [CABasicAnimation animation];
        
        rotation.duration = 1;
        rotation.repeatCount = MAXFLOAT;
        rotation.keyPath = @"transform.rotation.z";
        rotation.toValue = @(M_PI*2);
        [btn.imageView.layer addAnimation:rotation forKey:nil];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"RotationIconBeginRotation" object:nil];

    } 

    self.selectedBtn.selected = NO;
    btn.selected = YES;
    self.selectedBtn = btn;
}

/*设置按钮的尺寸*/
- (void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat btnW = self.frame.size.width / self.subviews.count;
    CGFloat btnY = 0;
    CGFloat btnH = self.frame.size.height;
    for (int i = 0; i < self.subviews.count; i++) {
        CGFloat btnX = i * btnW;
        CLCustomButton *btn = self.customBtns[i];
        btn.tag = i;
        if (btn.tag == 0) {
            self.selectedBtn = btn;
            self.selectedBtn.selected = YES;
        }
        btn.frame = CGRectMake(btnX, btnY, btnW, btnH);
    }
}

@end
