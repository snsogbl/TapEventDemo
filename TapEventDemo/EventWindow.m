//
//  EventWindow.m
//  TapEventDemo
//
//  Created by yangjie on 17/3/10.
//  Copyright © 2017年 yangjie. All rights reserved.
//



#import "EventWindow.h"

@implementation EventWindow

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    UIView *touchView = [super hitTest:point withEvent:event];
    
    self.tapPointX = 0.0f;
    self.tapPointY = 0.0f;
    
    [self positionWithView:touchView];
    
    //点击组件上的位置
    CGPoint tempPoint = [self convertPoint:point toView:touchView];
    
    self.tapPointX += tempPoint.x;
    self.tapPointY += tempPoint.y;
    
    
    NSLog(@"点击位置x:%f,y:%f",self.tapPointX,self.tapPointY);
    return touchView;
}

/**
 *  组件在控制器上的位置
 *
 *  @param view <#view description#>
 */
- (void)positionWithView:(UIView*)view{
    float offetX = 0;
    float offetY = 0;
    offetX += view.frame.origin.x;
    offetY += view.frame.origin.y;
    for (UIView* next = [view superview]; next; next = next.superview) {
        offetX += next.frame.origin.x;
        offetY += next.frame.origin.y;
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            self.tapPointX = offetX;
            self.tapPointY = offetY;
            return;
        }
    }
}

@end
