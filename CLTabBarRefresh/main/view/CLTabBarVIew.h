//
//  CLTabBarVIew.h
//  Relax
//
//  Created by Darren on 15/12/8.
//  Copyright © 2015年 darren. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^TabbarBtnImageRotationBlock)();


@class CLTabBarVIew;
@protocol CLTabBarVIewDelegate <NSObject>

@optional
- (void)tabbar:(CLTabBarVIew *)tabbar DidSeletedFrom:(NSInteger)from To:(NSInteger)to;

@end


@interface CLTabBarVIew : UIView

@property(nonatomic,weak) id <CLTabBarVIewDelegate> delegate;


@property(nonatomic,copy)TabbarBtnImageRotationBlock TabbarBtnImageRotation;


- (void)addCustomButtonWithitem:(UITabBarItem *)item;


@end
