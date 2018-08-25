//
//  XXJNavgationController.m
//  HGWIOS
//
//  Created by 许小军 on 2018/5/14.
//  Copyright © 2018年 Developer. All rights reserved.
//

#import "XXJNavgationController.h"


@interface XXJNavgationController ()<UIGestureRecognizerDelegate,UINavigationControllerDelegate>

@end

@implementation XXJNavgationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //这样写了以后就可以通过手势滑动返回上一层了
    __weak XXJNavgationController *weakSelf = self;
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)])  {
        self.interactivePopGestureRecognizer.delegate = weakSelf;
        self.delegate = weakSelf;
        
    }
}


- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if ([navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        navigationController.interactivePopGestureRecognizer.enabled = YES;
    }

    /* if rootViewController, set delegate nil */
    if (navigationController.viewControllers.count == 1) {
        navigationController.interactivePopGestureRecognizer.enabled = NO;
        navigationController.interactivePopGestureRecognizer.delegate = nil;
    }

}


@end
