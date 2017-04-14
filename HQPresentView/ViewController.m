//
//  ViewController.m
//  HQPresentView
//
//  Created by huangqiang on 17/1/19.
//  Copyright © 2017年 huangqiang. All rights reserved.
//

#import "ViewController.h"
#import "NextController.h"
#import "HQPManager.h"
#import "HQTransitioningDelegate.h"
@interface ViewController ()
@property (strong, nonatomic) HQPManager * manager;
@property (strong, nonatomic) HQPManager * manager_alert;
@property (strong, nonatomic) HQPManager * manager_custom;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

#pragma mark all click

- (IBAction)buttonClick:(id)sender {
    [self presentViewController:[self nextVCWithDelegate:self.manager.transitioningDelegate] animated:YES completion:nil];
}

- (IBAction)alertButtonClick:(id)sender {
    [self presentViewController:[self nextVCWithDelegate:self.manager_alert.transitioningDelegate] animated:YES completion:nil];
}

- (IBAction)alert_XIBBtnClick:(id)sender {
    [self performSegueWithIdentifier:@"XIBController" sender:nil];
}

- (IBAction)customBtnClick:(id)sender {
    [self presentViewController:[self nextVCWithDelegate:self.manager_custom.transitioningDelegate] animated:YES completion:nil];
}

- (NextController *)nextVCWithDelegate:(id <UIViewControllerTransitioningDelegate>) transitioningDelegate{
    return ({
    NextController * nextVC = [[NextController alloc] init];
    nextVC.transitioningDelegate = transitioningDelegate;
    nextVC.modalPresentationStyle = UIModalPresentationCustom;
    nextVC;
    });
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqual:@"XIBController"]) {
        UIViewController * vc = segue.destinationViewController;
        vc.transitioningDelegate = self.manager_alert.transitioningDelegate;
        vc.modalPresentationStyle = UIModalPresentationCustom;
    }
    [super prepareForSegue:segue sender:sender];
}

#pragma mark lazy
- (HQPManager *)manager{
    if (!_manager) {
        _manager = [HQPManager managerWithType:HQActionSheet presentedViewHeight:^CGFloat{
            return (CGFloat)300;
        } presentedWidth:^CGFloat{
            return [UIScreen mainScreen].bounds.size.width;
        }];
    }
    return _manager;
}

- (HQPManager *)manager_alert{
    if (!_manager_alert) {
        _manager_alert = [HQPManager managerWithType:HQAlert presentedViewHeight:^CGFloat{
            return (CGFloat)200;
        } presentedWidth:^CGFloat{
            return [UIScreen mainScreen].bounds.size.width*2/3.0;
        }];
    }
    return _manager_alert;
}

- (HQPManager *)manager_custom{
    if (!_manager_custom) {
        _manager_custom = [HQPManager managerWithCustomTypeAndPresentedViewHeight:^CGFloat{
            return (CGFloat)300;
        } presentedWidth:^CGFloat{
            return (CGFloat)200;
        } presentedAnimation:^(UIView *containerView, UIView *fromView, UIView *toView, NSTimeInterval duration,id <UIViewControllerContextTransitioning>transitionContext) {
            [containerView addSubview:toView];
            CGFloat toViewH = 300;
            CGFloat toViewW = 200;
            toView.frame = CGRectMake(20, 70, toViewW,1);
            [UIView animateWithDuration:duration animations:^{
                toView.frame = CGRectMake(20, 70, toViewW, toViewH);
            } completion:^(BOOL finished) {
                BOOL b = [transitionContext  transitionWasCancelled];
                [transitionContext completeTransition:!b];
            }];
        } dismissedAnimation:^(UIView *containerView, UIView *fromView, UIView *toView, NSTimeInterval duration,id <UIViewControllerContextTransitioning>transitionContext) {
            CGRect rect = fromView.frame;
            rect.size.height = 1;
            [UIView animateWithDuration:duration animations:^{
                fromView.frame = rect;
            } completion:^(BOOL finished) {
                BOOL b = [transitionContext  transitionWasCancelled];
                [transitionContext completeTransition:!b];
            }];

        }];
    }
    return _manager_custom;
}

@end
