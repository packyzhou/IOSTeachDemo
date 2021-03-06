//
//  PKAppDelegate.m
//  NetworkDemo
//
//  Created by 周经伟 on 14-8-1.
//  Copyright (c) 2014年 packy. All rights reserved.
//

#import "PKAppDelegate.h"

@implementation PKAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    PKNetworkViewController *networkViewController = [[PKNetworkViewController alloc] initWithNibName:@"PKNetworkViewController" bundle:nil];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:networkViewController];
    self.window.rootViewController = navigationController;
    
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    // 监测网络情况
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(reachabilityChanged:)
                                                 name: kReachabilityChangedNotification
                                               object: nil];
    Reachability *hostReach = [Reachability reachabilityWithHostname:@"www.google.com"];
    [hostReach startNotifier];
    
    return YES;
}

-(void) reachabilityChanged:(NSNotification *) note
{
    NSLog(@"网络变化");
    Reachability *currentReach = [note object];
    NetworkStatus status = [currentReach currentReachabilityStatus];
    switch (status) {
        case NotReachable:
            NSLog(@"没有网络");
            break;
        case ReachableViaWiFi:
            NSLog(@"wifi网络");
            break;
        case ReachableViaWWAN:
            NSLog(@"3G/GPRS网络");
            break;
    }
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
