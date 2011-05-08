//
//  _20tutorialAppDelegate.m
//  320tutorial
//
//  Created by Ivo Galic on 5/8/11.
//  Copyright 2011 Galic Design. All rights reserved.
//

#import "_20tutorialAppDelegate.h"
#import "LauncherViewController.h" // import the classes

@implementation _20tutorialAppDelegate


@synthesize window=_window;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    LauncherViewController *launcherView = [[LauncherViewController alloc]init]; // allocate launcherview
    // create navigation controller with that viewController
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:launcherView];
    navigationController.navigationBar.barStyle = UIBarStyleBlackOpaque;
    
    // add it to window
    [self.window addSubview:navigationController.view];
    [self.window makeKeyAndVisible];
    return YES;
}
     

- (void)dealloc
{
    [_window release];
    [super dealloc];
}

@end
