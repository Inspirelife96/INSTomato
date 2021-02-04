//
//  INSAppDelegate.m
//  INSTomato
//
//  Created by inspirelife@hotmail.com on 01/27/2021.
//  Copyright (c) 2021 inspirelife@hotmail.com. All rights reserved.
//

#import "INSAppDelegate.h"

#import <INSTomato/INSTomato-umbrella.h>

@implementation INSAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    INSTaskModel *taskModel1 = [[INSTaskModel alloc] initWithIdentifier:@"0" name:@"学习" color:@"赤色" music:@"纯然"];
    
    INSTaskModel *taskModel2 = [[INSTaskModel alloc] initWithIdentifier:@"0" name:@"工作" color:@"蓝色" music:@"纯然"];
    
    INSTaskModel *taskModel3 = [[INSTaskModel alloc] initWithIdentifier:@"0" name:@"冥想" color:@"绿色" music:@"纯然"];
    
    INSTaskModel *taskModel4 = [[INSTaskModel alloc] initWithIdentifier:@"0" name:@"锻炼" color:@"橙色" music:@"纯然"];
    
    [INSTaskTableManager createTaskTable:@[taskModel1, taskModel2,taskModel3, taskModel4]];
    [INSTomatoTableManager createTomatoTable];
    
    INSTomatoConfiguration *tomatoConfiguration = [[INSTomatoConfiguration alloc] init];
    
    tomatoConfiguration.topLeftPluginType = INSSupportedPluginTypeTask;
    tomatoConfiguration.topRightPluginType = INSSupportedPluginTypeNone;
    tomatoConfiguration.bottomLeftPluginType = INSSupportedPluginTypeNone;
    tomatoConfiguration.bottomRightPluginType = INSSupportedPluginTypeNone;
    
    INSTomatoViewController *tomatoVC = [[INSTomatoViewController alloc] initWithTomatoConfiguration:tomatoConfiguration];
    
    self.window.rootViewController = tomatoVC;

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
