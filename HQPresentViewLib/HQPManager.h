//
//  HQPManager.h
//  HQPresentView
//
//  Created by huangqiang on 17/1/19.
//  Copyright © 2017年 huangqiang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@class HQTransitioningDelegate;
typedef NS_ENUM(NSInteger, HQPresentViewType) {
    HQAlert,
    HQActionSheet,
    HQCustom
};

typedef CGFloat(^SizeBlock)();
typedef void(^AnimationBlock)(UIView* containerView,UIView* fromView,UIView* toView,NSTimeInterval duration,id <UIViewControllerContextTransitioning>transitionContext);
@interface HQPManager : NSObject
/*获取presentedView 的高度*/
@property (copy, nonatomic) SizeBlock presentedViewHeight;
/*获取presentedView 的宽度*/
@property (copy, nonatomic) SizeBlock presentedWidth;
/*presentedView 弹出方式*/
@property (assign, nonatomic) HQPresentViewType type;
/*
 TransitioningDelegate 一般不用自己设置
 */
@property (strong, nonatomic) HQTransitioningDelegate<UIViewControllerTransitioningDelegate> * transitioningDelegate;
/* type 等于custom时，需要自定义的弹出动画*/
@property (copy, nonatomic) AnimationBlock presentedAnimation;
/* type 等于custom时，需要自定义的退出动画*/
@property (copy, nonatomic) AnimationBlock dismissedAnimation;

+ (HQPManager *)managerWithType:(HQPresentViewType)type presentedViewHeight:(SizeBlock)presentedViewHeight presentedWidth:(SizeBlock)presentedWidth;
+ (HQPManager *)managerWithCustomTypeAndPresentedViewHeight:(SizeBlock)presentedViewHeight presentedWidth:(SizeBlock)presentedWidth presentedAnimation:(AnimationBlock)presentedAnimation dismissedAnimation:(AnimationBlock)dismissedAnimation;

@end
