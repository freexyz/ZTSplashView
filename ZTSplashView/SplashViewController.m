/*
 ******************************************************************************
 * SplashViewController.m -
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
#import "CBZSplashView/CBZSplashView.h"
#import "UIColor+HexString.h"
#import "UIBezierPath+Shapes.h"

#import "SplashViewController.h"


/*
 ******************************************************************************
 *
 * for debug
 *
 ******************************************************************************
 */
#define LOGGING_SPLASHVIEW      1
#include "DbgMsg.h"

#if defined(LOGGING_SPLASHVIEW) && LOGGING_SPLASHVIEW
    #define _dmsg(fmt, ...)     LOG_FORMAT(fmt, @"SV", ##__VA_ARGS__)
#else
    #define _dmsg(...)
#endif


/*
 ******************************************************************************
 *
 * local variables
 *
 ******************************************************************************
 */
static NSString * const kTwitterIcon = @"twitterIcon";
static NSString * const kSnapchatIcon = @"snapchatIcon";

static NSString * const kTwitterColor = @"4099FF";
static NSString * const kSnapchatColor = @"FFCC00";


/*
 ******************************************************************************
 *
 * @interface
 *
 ******************************************************************************
 */
@interface SplashViewController ()

@property (nonatomic, strong) CBZSplashView *splashView;
//@property (nonatomic, strong) TileGridView *tileGridView;
@end


/*
 ******************************************************************************
 *
 * @interface
 *
 ******************************************************************************
 */
@implementation SplashViewController

/*---------------------------------------------------------------------------*/
#pragma mark - 
/*---------------------------------------------------------------------------*/
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    _dmsg(@"initWithCoder:");
    if (self = [super initWithCoder:aDecoder]) {

    }
    return self;
}


- (instancetype)initTtileViewFileName:(NSString *)string
{
    _dmsg(@"initTtileViewFileName:");
//    [super initWithNibName:nil bundle:nil];

//    [self.view addSubview:tileGridView];
//    tileGridView.frame = [self.view bounds];



    // Launch screen animation
    __unused UIImage    *icon       = [UIImage imageNamed:@"twitterIcon"];
    UIBezierPath        *bezier     = [UIBezierPath twitterShape];
    UIColor             *color      = [UIColor colorWithHexString:kTwitterColor];
    CBZSplashView       *splashView = [CBZSplashView splashViewWithBezierPath:bezier backgroundColor:color];

    [splashView setAnimationDuration:1.8];

    [self.view addSubview:splashView];
    _splashView = splashView;

    // Override point for customization after application launch.
    [self delay:1.0 closure: ^{
        [_splashView startAnimation];
    }];

    return self;
}

- (void)awakeFromNib
{
    _dmsg(@"awakeFromNib");
    [super awakeFromNib];

}

/*---------------------------------------------------------------------------*/
#pragma mark -
/*---------------------------------------------------------------------------*/
- (BOOL)prefersStatusBarHidden
{
    _dmsg(@"prefersStatusBarHidden");
    return YES;
}


/*---------------------------------------------------------------------------*/
#pragma mark -
/*---------------------------------------------------------------------------*/
- (void)delay:(double)delay closure:(void (^)())callback
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay * (double)NSEC_PER_SEC)), dispatch_get_main_queue(), callback);

}


@end
