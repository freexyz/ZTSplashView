/*
 ******************************************************************************
 * UINavigationController.h -
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
#import "MenuNavigationViewController.h"


/*
 ******************************************************************************
 *
 * for debug
 *
 ******************************************************************************
 */
#define LOGGING_NAVVIEW     1
#include "DbgMsg.h"

#if defined(LOGGING_NAVVIEW) && LOGGING_NAVVIEW
#define _dmsg(fmt, ...)     LOG_FORMAT(fmt, @"NV", ##__VA_ARGS__)
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
@interface MenuNavigationViewController ()

@end


/*
 ******************************************************************************
 *
 * @implementation
 *
 ******************************************************************************
 */
@implementation MenuNavigationViewController

/*---------------------------------------------------------------------------*/
#pragma mark - View Lifecycle
/*---------------------------------------------------------------------------*/
- (void)viewDidLoad
{
    _dmsg(@"viewDidLoad");
    [super viewDidLoad];
    // Do any additional setup after loading the view.

}

- (void)didReceiveMemoryWarning
{
    _dmsg(@"didReceiveMemoryWarning");
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
