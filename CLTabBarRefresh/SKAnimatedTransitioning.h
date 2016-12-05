//
//  SKAnimatedTransitioning.h
//  Budayang
//
//  Created by darren on 16/3/24.
//  Copyright © 2016年 chinaPnr. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface SKAnimatedTransitioning : NSObject<UIViewControllerAnimatedTransitioning>

@property (nonatomic,assign) BOOL presented;
@end
