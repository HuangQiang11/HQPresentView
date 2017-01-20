//
//  HQPManager.m
//  HQPresentView
//
//  Created by huangqiang on 17/1/19.
//  Copyright © 2017年 huangqiang. All rights reserved.
//

#import "HQPManager.h"
#import "HQTransitioningDelegate.h"
@implementation HQPManager
+ (HQPManager *)managerWithType:(HQPresentViewType)type presentedViewHeight:(SizeBlock)presentedViewHeight presentedWidth:(SizeBlock)presentedWidth{
    HQPManager * manager = [[HQPManager alloc] init];
    manager.type = type;
    manager.presentedWidth = presentedWidth;
    manager.presentedViewHeight = presentedViewHeight;
    return manager;
}

+ (HQPManager *)managerWithCustomTypeAndPresentedViewHeight:(SizeBlock)presentedViewHeight presentedWidth:(SizeBlock)presentedWidth presentedAnimation:(nonnull AnimationBlock)presentedAnimation dismissedAnimation:(nonnull AnimationBlock)dismissedAnimation{
    HQPManager * manager = [[HQPManager alloc] init];
    manager.type = HQCustom;
    manager.presentedWidth = presentedWidth;
    manager.presentedViewHeight = presentedViewHeight;
    manager.presentedAnimation = presentedAnimation;
    manager.dismissedAnimation = dismissedAnimation;
    return manager;
}

- (HQTransitioningDelegate *)transitioningDelegate{
    if (!_transitioningDelegate) {
        _transitioningDelegate = [HQTransitioningDelegate transitioningDelegateWith:self];
    }
    return _transitioningDelegate;
}
@end
