//
//  HQAnimationManager.m
//  HQPresentView
//
//  Created by huangqiang on 17/1/19.
//  Copyright © 2017年 huangqiang. All rights reserved.
//

#import "HQAnimationManager.h"
#import "HQPManager.h"
@implementation HQAnimationManager
+ (HQAnimationManager *)animationManageWithPmanager:(HQPManager *)manager{
    HQAnimationManager * ani = [HQAnimationManager new];
    ani.manager = manager;
    return ani;
}

- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext{
    return 0.3;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext{
    UIViewController * fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController * toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView * containerView = [transitionContext containerView];
    UIView * fromView = fromVC.view;
    UIView * toView = toVC.view;
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    if (self.manager.type == HQAlert) {
        //Alert animation
        if (toVC.isBeingPresented) {
            [containerView addSubview:toView];
            CGFloat toViewH = self.manager.presentedViewHeight();
            CGFloat toViewW = self.manager.presentedWidth();
            toView.center = containerView.center;
            toView.bounds = CGRectMake(0, 0, 1, toViewH);
            
            [UIView animateWithDuration:duration animations:^{
                toView.bounds = CGRectMake(0, 0, toViewW, toViewH);
            } completion:^(BOOL finished) {
                BOOL b = [transitionContext  transitionWasCancelled];
                [transitionContext completeTransition:!b];
            }];
        }
        
        if (fromVC.isBeingDismissed) {
            [UIView animateWithDuration:duration animations:^{
                fromView.bounds = CGRectMake(0, 0, 1, fromView.frame.size.height);
            } completion:^(BOOL finished) {
                BOOL b = [transitionContext  transitionWasCancelled];
                [transitionContext completeTransition:!b];
            }];
        }
    }else if(self.manager.type == HQActionSheet){
        //actionSheet animation
        if (toVC.isBeingPresented) {
            [containerView addSubview:toView];
            CGFloat toViewH = self.manager.presentedViewHeight();
            CGFloat toViewW = self.manager.presentedWidth();
            toView.frame = CGRectMake(0, containerView.bounds.size.height, toViewW, toViewH);
            [UIView animateWithDuration:duration animations:^{
                toView.frame = CGRectMake(0, containerView.bounds.size.height-toViewH, toViewW, toViewH);
            } completion:^(BOOL finished) {
                BOOL b = [transitionContext  transitionWasCancelled];
                [transitionContext completeTransition:!b];
            }];
        }
        
        if (fromVC.isBeingDismissed) {
            [UIView animateWithDuration:duration animations:^{
                fromView.frame = CGRectMake(0, containerView.bounds.size.height, fromView.frame.size.width, fromView.frame.size.height);
            } completion:^(BOOL finished) {
                BOOL b = [transitionContext  transitionWasCancelled];
                [transitionContext completeTransition:!b];
            }];
        }
    }else if (self.manager.type == HQCustom){
        //custom animation
        if (toVC.isBeingPresented) {
            self.manager.presentedAnimation(containerView,fromView,toView,duration,transitionContext);
        }
        if (fromVC.isBeingDismissed) {
            self.manager.dismissedAnimation(containerView,fromView,toView,duration,transitionContext);
        }
    }
}
@end
