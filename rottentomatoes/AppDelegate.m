//
//  AppDelegate.m
//  rottentomatoes
//
//  Created by Satyajit Rai on 6/3/14.
//  Copyright (c) 2014 Yahoo. All rights reserved.
//

#import "AppDelegate.h"
#import "MoviesViewController.h"

@implementation AppDelegate

static NSString * const TopRentalsURL = @"http://api.rottentomatoes.com/api/public/v1.0/lists/dvds/top_rentals.json?apikey=6wcukn4emcss3akenr7ky5fa";
static NSString * const BoxOfficeURL = @"http://api.rottentomatoes.com/api/public/v1.0/lists/movies/box_office.json?apikey=6wcukn4emcss3akenr7ky5fa";

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    MoviesViewController *vc1 = [[MoviesViewController  alloc] initWithURL:BoxOfficeURL];
    UINavigationController *nc1 = [[UINavigationController alloc] initWithRootViewController:vc1];
    nc1.tabBarItem.title = @"Box Office";
    nc1.tabBarItem.image = [[UIImage imageNamed: @"ticket"] imageWithRenderingMode: UIImageRenderingModeAlwaysOriginal];
    
    MoviesViewController *vc2 = [[MoviesViewController  alloc] initWithURL:TopRentalsURL];
    UINavigationController *nc2 = [[UINavigationController alloc] initWithRootViewController:vc2];
    nc2.tabBarItem.title = @"Top DVDs";
    nc2.tabBarItem.image = [[UIImage imageNamed: @"dvd"] imageWithRenderingMode: UIImageRenderingModeAlwaysOriginal];

    UITabBarController *tabBarController = [[UITabBarController alloc] init];
    tabBarController.viewControllers = @[nc1, nc2];
    
    self.window.rootViewController = tabBarController;

    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
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
