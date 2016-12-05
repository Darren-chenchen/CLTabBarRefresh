//
//  CoustomPresentationController.m
//  Budayang
//
//  Created by darren on 16/3/24.
//  Copyright © 2016年 chinaPnr. All rights reserved.
//

#import "CoustomPresentationController.h"
#import "UIView+MJExtension.h"

#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height
#define TansitionTimer 0.5
#define TansitionWidth 80
#define alpheValue 0.6

@interface CoustomPresentationController()
/**背景*/
@property (nonatomic,strong) UIView *coverView;

@end

@implementation CoustomPresentationController
- (void)presentationTransitionWillBegin
{
    self.presentedView.frame = CGRectMake(0, 0,ScreenWidth-TansitionWidth, ScreenHeight);
    
    [self.containerView addSubview:self.presentedView];
    
    // 添加灰色背景
    self.coverView = [[UIView alloc] init];
    self.coverView.frame = CGRectMake(0, 0, ScreenWidth,  ScreenHeight);
    self.coverView.backgroundColor = [UIColor blackColor];
    self.coverView.alpha = 0;
    [self.coverView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickCover)]];
    [self.coverView addGestureRecognizer:[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(coverpan:)]];
    
    [[UIApplication sharedApplication].keyWindow addSubview:self.coverView];
    
    [UIView animateWithDuration:TansitionTimer animations:^{
        self.presentingViewController.view.mj_x = ScreenWidth-TansitionWidth;
        
        self.coverView.alpha = alpheValue;
        self.coverView.mj_x = self.presentingViewController.view.mj_x;
    }];
}

- (void)clickCover
{
    [self.presentedViewController dismissViewControllerAnimated:YES completion:^{
        [self.coverView removeFromSuperview];
    }];
}
- (void)coverpan:(UIPanGestureRecognizer *)pan
{
    CGPoint point = [pan translationInView:self.coverView];
    
    CGFloat offSetX = point.x;  // x<0是左拽
    
    if (offSetX<=0) {
        self.presentingViewController.view.mj_x = ScreenWidth-TansitionWidth-(-offSetX);
        self.presentedViewController.view.mj_x = offSetX;
        self.coverView.mj_x = self.presentingViewController.view.mj_x;
        
        // 设置背景的透明度
        CGFloat alphe = (-offSetX)/ScreenWidth*alpheValue;
        self.coverView.alpha = alpheValue-alphe;
        
        // 停止拖拽，判断位置
        if (pan.state == UIGestureRecognizerStateEnded) {
            if ((-offSetX)>ScreenWidth*0.5-40) {  // 超过了屏幕的一半
                
                [UIView animateWithDuration:0.2 animations:^{
                    self.presentingViewController.view.mj_x = 0;
                    self.coverView.alpha = 0;
                    self.presentedViewController.view.mj_x = -(ScreenWidth-TansitionWidth);
                    self.coverView.mj_x = self.presentingViewController.view.mj_x;
                    self.presentedViewController.view.mj_x = -(ScreenWidth-TansitionWidth);
                } completion:^(BOOL finished) {
                    [self.presentedViewController dismissViewControllerAnimated:YES completion:^{
                        [self.coverView removeFromSuperview];
                    }];
                }];
                
            } else {
                [UIView animateWithDuration:0.2 animations:^{
                    self.presentingViewController.view.mj_x = ScreenWidth-TansitionWidth;
                    self.coverView.alpha = alpheValue;
                    self.coverView.mj_x = self.presentingViewController.view.mj_x;
                    self.presentedViewController.view.mj_x = 0;
                }];
                
            }
        }
    }

}

- (void)presentationTransitionDidEnd:(BOOL)completed
{
    
}

- (void)dismissalTransitionWillBegin
{
    [UIView animateWithDuration:TansitionTimer animations:^{
        self.presentingViewController.view.mj_x = 0;
        self.presentingViewController.view.mj_y = 0;
        self.presentingViewController.view.mj_h = ScreenHeight;
        
        self.coverView.mj_x = self.presentingViewController.view.mj_x;
        self.coverView.alpha = 0;
    }];
}

- (void)dismissalTransitionDidEnd:(BOOL)completed
{
    [self.presentedView removeFromSuperview];
}
@end
