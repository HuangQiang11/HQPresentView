//
//  NextController.m
//  HQPresentView
//
//  Created by huangqiang on 17/1/19.
//  Copyright © 2017年 huangqiang. All rights reserved.
//

#import "NextController.h"

@interface NextController ()

@end

@implementation NextController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor redColor];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark HQPresentedViewDelegate
- (void)presentedViewDismissViewController{
     [self dismissViewControllerAnimated:YES completion:nil];
}

@end
