//
//  HQTransitioningDelegate.h
//  HQPresentView
//
//  Created by huangqiang on 17/1/19.
//  Copyright © 2017年 huangqiang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@class HQPManager;
@interface HQTransitioningDelegate : NSObject<UIViewControllerTransitioningDelegate>
@property (weak, nonatomic) HQPManager * manager;

+ (HQTransitioningDelegate *)transitioningDelegateWith:(HQPManager *)manager;
@end
