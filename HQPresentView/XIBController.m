//
//  XIBController.m
//  HQPresentView
//
//  Created by huangqiang on 17/1/20.
//  Copyright © 2017年 huangqiang. All rights reserved.
//

#import "XIBController.h"

@interface XIBController ()

@end

@implementation XIBController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark HQPresentedViewDelegate
- (void)presentedViewDismissViewController{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
