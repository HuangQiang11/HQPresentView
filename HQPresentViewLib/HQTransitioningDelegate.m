//
//  HQTransitioningDelegate.m
//  HQPresentView
//
//  Created by huangqiang on 17/1/19.
//  Copyright © 2017年 huangqiang. All rights reserved.
//

#import "HQTransitioningDelegate.h"
#import "HQPresentationController.h"
#import "HQAnimationManager.h"
@implementation HQTransitioningDelegate
+ (HQTransitioningDelegate *)transitioningDelegateWith:(HQPManager *)manager{
    HQTransitioningDelegate * tran = [HQTransitioningDelegate new];
    tran.manager = manager;
    return tran;
}

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source{
    return [HQAnimationManager animationManageWithPmanager:self.manager];
}

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed{
    return [HQAnimationManager animationManageWithPmanager:self.manager];
}

- (UIPresentationController *)presentationControllerForPresentedViewController:(UIViewController *)presented presentingViewController:(UIViewController *)presenting sourceViewController:(UIViewController *)source{
    return [HQPresentationController presentationControllerWithPmanager:self.manager presentedVC:presented presentingVC:presenting];
}

@end
