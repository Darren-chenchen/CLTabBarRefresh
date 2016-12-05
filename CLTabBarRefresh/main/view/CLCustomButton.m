//
//  CLCustomButton.m
//  Relax
//
//  Created by Darren on 15/12/8.
//  Copyright © 2015年 darren. All rights reserved.
//

#import "CLCustomButton.h"

@implementation CLCustomButton

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //设置图片居中
        self.imageView.contentMode = UIViewContentModeCenter;
        
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.font = [UIFont systemFontOfSize:11];
        
        [self setTitleColor:[UIColor colorWithRed:216/255. green:0/255. blue:0/255. alpha:1.0] forState:UIControlStateSelected];
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    return self;
}

- (void)setHighlighted:(BOOL)highlighted
{}

/*覆盖父类的方法，设置button的文字位置*/
- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    CGFloat titleW = self.frame.size.width;
    CGFloat titleX = 0;
    CGFloat titleY = self.frame.size.height * 0.6;
    CGFloat titleH = self.frame.size.height * 0.4;
    
    return CGRectMake(titleX, titleY, titleW, titleH);
}

- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    CGFloat imageW = self.frame.size.width;
    CGFloat imageX = 0;
    CGFloat imageY = 0;
    CGFloat imageH = self.frame.size.height * 0.6;
    
    return CGRectMake(imageX, imageY, imageW, imageH);
}

/*重写set方法*/
- (void)setItem:(UITabBarItem *)item
{
    _item = item;
    [self setImage:item.image forState:UIControlStateNormal];
    [self setImage:item.selectedImage forState:UIControlStateSelected];
    [self setTitle:item.title forState:UIControlStateNormal];
}

@end
