/*
 ******************************************************************************
 * RootContainerViewController.m -
 *
 * Copyright (c) 2015-2016 by ZealTek Electronic Co., Ltd.
 *
 * This software is copyrighted by and is the property of ZealTek
 * Electronic Co., Ltd. All rights are reserved by ZealTek Electronic
 * Co., Ltd. This software may only be used in accordance with the
 * corresponding license agreement. Any unauthorized use, duplication,
 * distribution, or disclosure of this software is expressly forbidden.
 *
 * This Copyright notice MUST not be removed or modified without prior
 * written consent of ZealTek Electronic Co., Ltd.
 *
 * ZealTek Electronic Co., Ltd. reserves the right to modify this
 * software without notice.
 *
 * History:
 *	2016.01.16	T.C. Chiu	frist edition
 *
 ******************************************************************************
 */
#import "SplashViewController.h"
#import "MenuNavigationViewController.h"
#import "RootContainerViewController.h"


/*
 ******************************************************************************
 *
 * for debug
 *
 ******************************************************************************
 */
#define LOGGING_ROOTVIEW        1
#include "DbgMsg.h"

#if defined(LOGGING_ROOTVIEW) && LOGGING_ROOTVIEW
    #define _dmsg(fmt, ...)     LOG_FORMAT(fmt, @"RV", ##__VA_ARGS__)
#else
    #define _dmsg(...)
#endif




/*
 ******************************************************************************
 *
 * @interface
 *
 ******************************************************************************
 */
@interface RootContainerViewController ()

@property (nonatomic, strong) UIViewController *rootViewController;
@property (nonatomic, strong) SplashViewController *splashViewController;

@end


/*
 ******************************************************************************
 *
 * @implementation
 *
 ******************************************************************************
 */
@implementation RootContainerViewController

/*---------------------------------------------------------------------------*/
#pragma mark - View Lifecycle
/*---------------------------------------------------------------------------*/
- (void)viewDidLoad
{
    _dmsg(@"viewDidLoad");
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    [self showSplashViewController];
}

- (void)viewWillAppear:(BOOL)animated
{
    _dmsg(@"viewWillAppear:");
    [super viewWillAppear:animated];

}

- (void)viewDidAppear:(BOOL)animated
{
    _dmsg(@"viewDidAppear:");
    [super viewDidAppear:animated];
    
    
}

- (void)didReceiveMemoryWarning
{
    _dmsg(@"didReceiveMemoryWarning");
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.

}


/*---------------------------------------------------------------------------*/
#pragma mark -
/*---------------------------------------------------------------------------*/
- (BOOL)prefersStatusBarHidden
{
    if ([_rootViewController isKindOfClass:[SplashViewController class]]) {
        _dmsg(@"prefersStatusBarHidden -> YES");
        return YES;
    } else if ([_rootViewController isKindOfClass:[MenuNavigationViewController class]]) {
        _dmsg(@"prefersStatusBarHidden -> NO");
        return NO;
    } else {
        _dmsg(@"prefersStatusBarHidden -> YES");
        return YES;
    }
}


/*---------------------------------------------------------------------------*/
#pragma mark -
/*---------------------------------------------------------------------------*/
- (void)delay:(double)delay closure:(void (^)())callback
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay * (double)NSEC_PER_SEC)), dispatch_get_main_queue(), callback);

}


/*---------------------------------------------------------------------------*/
#pragma mark -
/*---------------------------------------------------------------------------*/
- (void)showSplashViewController
{
    [self showSplashViewControllerNoPing];

    [self delay:3.00 closure:^{
        [self showMenuNavigationViewController];
    }];
}

// Does not transition to any other UIViewControllers, SplashViewController only
- (void)showSplashViewControllerNoPing
{
    if ([_rootViewController isKindOfClass:[SplashViewController class]]) {
        return;
    }

    [_rootViewController willMoveToParentViewController:nil];
    [_rootViewController removeFromParentViewController];
    [_rootViewController.view removeFromSuperview];
    [_rootViewController didMoveToParentViewController:nil];

    _splashViewController = [[SplashViewController alloc] initTtileViewFileName:@"Chimes"];

    _rootViewController = _splashViewController;
    _splashViewController.pulsing = YES;

    [_splashViewController willMoveToParentViewController:self];
    [self addChildViewController:_splashViewController];
    [self.view addSubview:_splashViewController.view];
    [_splashViewController didMoveToParentViewController:self];
}

// Displays the MapViewController
- (void)showMenuNavigationViewController
{
    if ([_rootViewController isKindOfClass:[MenuNavigationViewController class]]) {
        return;
    }

    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Menu" bundle:nil];

    MenuNavigationViewController *nav = [storyboard instantiateViewControllerWithIdentifier:@"MenuNavigationController"];

    [nav willMoveToParentViewController:self];

    [self addChildViewController:nav];


    UIViewController *rootViewController = _rootViewController;
    if (rootViewController != nil) {
        _rootViewController = nav;
        [rootViewController willMoveToParentViewController:nil];

        [self transitionFromViewController:rootViewController
                          toViewController:nav
                                  duration:0.5
                                   options:UIViewAnimationOptionTransitionCrossDissolve
                                animations:^{ }
                                completion:^(BOOL finished){
                                    [nav didMoveToParentViewController:self];
                                    [rootViewController removeFromParentViewController];
                                    [rootViewController didMoveToParentViewController:nil];
                                }];

    } else {
        rootViewController = nav;
        [self.view addSubview:nav.view];
        [nav didMoveToParentViewController:self];
    }
}
                

@end
