//
//  SKAnimatedTransitioning.m
//  Budayang
//
//  Created by darren on 16/3/24.
//  Copyright © 2016年 chinaPnr. All rights reserved.
//

#import "SKAnimatedTransitioning.h"
#import <UIKit/UIKit.h>
#import "UIView+MJExtension.h"

#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height
@implementation SKAnimatedTransitioning
- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return 1;
}

// 在这个方法中实现转场动画 ：modal和dismis都调用这个方法
- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    if (self.presented) {
        UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];
        toView.mj_x = -ScreenWidth+80;
        [UIView animateWithDuration:0.5 animations:^{
            toView.mj_x = 0;

        } completion:^(BOOL finished) {
            [transitionContext completeTransition:YES];
        }];
    } else {
        UIView *fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
        fromView.mj_x = 0;
        [UIView animateWithDuration:0.5 animations:^{
            fromView.mj_x = -ScreenWidth+80;
        } completion:^(BOOL finished) {
            [transitionContext completeTransition:YES];
        }];
        
    }
}
@end
