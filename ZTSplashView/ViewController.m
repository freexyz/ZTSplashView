//
//  ViewController.m
//  ZTSplashView
//
//  Created by Chiu Tzu Chian on 2017/1/11.
//  Copyright © 2017年 zealabs. All rights reserved.
//

#import "UIColor+HexString.h"
#import "ViewController.h"



@interface ViewController ()

@end

@implementation ViewController

- (id)init
{
    NSLog(@"init");
    if (self = [super init])  {
        _showStatusBar = NO;
    }
    return self;
}


- (void)viewDidLoad
{
    NSLog(@"viewDidLoad");
    [super viewDidLoad];

    // Do any additional setup after loading the view, typically from a nib.
    // navigation bar
    self.title = @"UITableView";

    __unused NSString *ver   = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
    __unused NSString *build = [[NSBundle mainBundle] objectForInfoDictionaryKey:(NSString *)kCFBundleVersionKey];
    self.navigationItem.title = [NSString stringWithFormat:@"Launch Test"];
    //    self.navigationItem.rightBarButtonItem = self.editButtonItem;


    [self.view setBackgroundColor:[UIColor colorWithHexString:@"ffffff"]];

}

- (void)viewWillAppear:(BOOL)animated
{
    NSLog(@"viewWillAppear:");
    [super viewWillAppear:animated];

    _showStatusBar = YES;
}

- (void)viewDidAppear:(BOOL)animated
{
    NSLog(@"viewDidAppear:");
    [super viewDidAppear:animated];


}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.

}



- (BOOL)prefersStatusBarHidden
{
    if (_showStatusBar == NO) {
        NSLog(@"prefersStatusBarHidden -> YES");
        return YES;
    }
    NSLog(@"prefersStatusBarHidden -> NO");
    return NO;
}


@end
