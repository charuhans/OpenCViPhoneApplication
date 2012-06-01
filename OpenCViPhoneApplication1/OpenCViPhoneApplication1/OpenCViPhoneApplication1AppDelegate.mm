//
//  OpenCViPhoneApplication1AppDelegate.m
//  OpenCViPhoneApplication1
//
//  Created by MOHAMMED ALSHAIR on 5/29/12.
//  Copyright 2012 University of Houston - Main Campus. All rights reserved.
//

#import "OpenCViPhoneApplication1AppDelegate.h"

#import "OpenCViPhoneApplication1ViewController.h"

@implementation OpenCViPhoneApplication1AppDelegate


@synthesize window=_window;

@synthesize viewController=_viewController;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
     
    self.window.rootViewController = self.viewController;
    [self.window makeKeyAndVisible];
    return YES;
}


- (void)dealloc
{
    [_window release];
    [_viewController release];
    [super dealloc];
}

@end
