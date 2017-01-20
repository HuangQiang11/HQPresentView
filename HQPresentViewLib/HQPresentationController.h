//
//  HQPresentationController.h
//  HQPresentView
//
//  Created by huangqiang on 17/1/19.
//  Copyright © 2017年 huangqiang. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HQPManager;
@interface HQPresentationController : UIPresentationController
@property (weak, nonatomic) HQPManager * manager;
+ (HQPresentationController *)presentationControllerWithPmanager:(HQPManager *)manager presentedVC:(UIViewController *)presentedVC presentingVC:(UIViewController *)presentingVC;
@end
