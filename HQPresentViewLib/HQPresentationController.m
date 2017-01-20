//
//  HQPresentationController.m
//  HQPresentView
//
//  Created by huangqiang on 17/1/19.
//  Copyright © 2017年 huangqiang. All rights reserved.
//

#import "HQPresentationController.h"
#import "HQPManager.h"
@interface HQPresentationController ()
@property (strong, nonatomic) UIView * backgroundView;
@end

@implementation HQPresentationController
+ (HQPresentationController *)presentationControllerWithPmanager:(HQPManager *)manager presentedVC:(UIViewController *)presentedVC presentingVC:(UIViewController *)presentingVC{
    HQPresentationController * vc = [[HQPresentationController alloc] initWithPresentedViewController:presentedVC presentingViewController:presentingVC];
    vc.manager = manager;
    return vc;
}

- (void)presentationTransitionWillBegin{
    [self.containerView addSubview:self.backgroundView];
    [[self.presentedViewController transitionCoordinator] animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
        self.backgroundView.alpha = 0.6;
    } completion:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
        
    }];
}

- (void)presentationTransitionDidEnd:(BOOL)completed{
    
}

- (void)dismissalTransitionWillBegin{
    [self.presentedViewController.transitionCoordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
        self.backgroundView.alpha = 0;
    } completion:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
        
    }];
}

- (void)dismissalTransitionDidEnd:(BOOL)completed{
    
}

/*屏幕旋转时调用*/
- (void)containerViewWillLayoutSubviews{
    [super containerViewWillLayoutSubviews];
    self.backgroundView.center = self.containerView.center;
    self.backgroundView.bounds = self.containerView.bounds;
    
    if (self.manager.type == HQAlert) {
        self.presentedView.center = self.containerView.center;
        self.presentedView.bounds = CGRectMake(0, 0, self.manager.presentedWidth(), self.manager.presentedViewHeight());
    }else if(self.manager.type == HQActionSheet){
        self.presentedView.frame = CGRectMake(0, CGRectGetHeight(self.containerView.bounds)-self.manager.presentedViewHeight(), self.manager.presentedWidth(), self.manager.presentedViewHeight());
    }else {
        /*
         自定义动画时，如果屏幕支持转屏，需要在此作相应的设置
         */
        self.presentedView.frame = CGRectMake(CGRectGetMinX(self.presentedView.frame),CGRectGetMinY(self.presentedView.frame),self.manager.presentedWidth(),self.manager.presentedViewHeight());
    }
    
}

- (UIView *)backgroundView{
    if (!_backgroundView) {
        _backgroundView = [[UIView alloc] init];
        _backgroundView.backgroundColor = [UIColor blackColor];
        _backgroundView.alpha = 0;
        _backgroundView.bounds = self.containerView.bounds;
        //add tap
        _backgroundView.userInteractionEnabled = YES;
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick:)];
        [_backgroundView addGestureRecognizer:tap];
    }
    return _backgroundView;
}

- (void)tapClick:(UITapGestureRecognizer *)tap{
    SEL closeView = NSSelectorFromString(@"presentedViewDismissViewController");
    if ([self.presentedViewController respondsToSelector:closeView]) {
          [self.presentedViewController performSelector:closeView withObject:nil afterDelay:0];
    }else{
        NSLog(@"请让presentedViewController遵守HQPresentedViewDelegate");
    }
}
@end
