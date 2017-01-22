使用自定义Modal 转场实现自定义UIAlertView ，UIActionSheet

1.将HQPresentViewLib文件夹拷贝到工程目录

2.在presentingViewController中创建HQPManager实例属性

3.需要在HQPManager实例的初始化中，设置presentedView的大小，例如：
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

4.弹出方式有三种方式：
typedef NS_ENUM(NSInteger, HQPresentViewType) {
    HQAlert,
    HQActionSheet,
    HQCustom
};
当弹出方式为：HQCustom时，HQPManager实例初始化需要自定义动画：
- (HQPManager *)manager_custom{
    if (!_manager_custom) {
        _manager_custom = [HQPManager managerWithCustomTypeAndPresentedViewHeight:^CGFloat{
            return (CGFloat)300;
        } presentedWidth:^CGFloat{
            return (CGFloat)200;
        } presentedAnimation:^(UIView *containerView, UIView *fromView, UIView *toView, NSTimeInterval duration,id <UIViewControllerContextTransitioning>transitionContext) {
           //自定义弹出动画
        } dismissedAnimation:^(UIView *containerView, UIView *fromView, UIView *toView, NSTimeInterval duration,id <UIViewControllerContextTransitioning>transitionContext) {
         //自定义退出动画
    }
    return _manager_custom;
}

5.设置presentedViewController的转场方式为UIModalPresentationCustom和设置转场代理
    NextController * nextVC = [[NextController alloc] init];
    nextVC.transitioningDelegate = self.manager.transitioningDelegate;
    nextVC.modalPresentationStyle = UIModalPresentationCustom;
    [self presentViewController:nextVC animated:YES completion:nil];
    
6.如需点击点击背景dismiss presentedViewController，presentedViewController需要遵循HQPresentedViewDelegate
