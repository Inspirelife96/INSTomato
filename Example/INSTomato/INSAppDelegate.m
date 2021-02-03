//
//  INSAppDelegate.m
//  INSTomato
//
//  Created by inspirelife@hotmail.com on 01/27/2021.
//  Copyright (c) 2021 inspirelife@hotmail.com. All rights reserved.
//

#import "INSAppDelegate.h"

#import <INSTomato/INSPersistenceConstants.h>

@implementation INSAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    ILDTaskConfiguration *taskConfig1 = [[ILDTaskConfiguration alloc] initWithTaskName:@"自由"];

    ILDTaskConfiguration *taskConfig2 = [[ILDTaskConfiguration alloc] initWithTaskName:@"专题"];

    ILDTaskConfiguration *taskConfig3 = [[ILDTaskConfiguration alloc] initWithTaskName:@"酷文"];
    
    ILDTaskConfiguration *taskConfig4 = [[ILDTaskConfiguration alloc] initWithTaskName:@"奇题"];

    ILDDiligenceConfiguration *diligenceConfig = [[ILDDiligenceConfiguration alloc] init];
    
    diligenceConfig.taskConfigurationArray = @[taskConfig1, taskConfig2, taskConfig3, taskConfig4];
    diligenceConfig.topLeftPluginType = ILDSupportedPluginTypeTask;
    diligenceConfig.topRightPluginType = ILDSupportedPluginTypeStatistics;
    diligenceConfig.bottomLeftPluginType = ILDSupportedPluginTypeStory;
    diligenceConfig.bottomRightPluginType = ILDSupportedPluginTypeSetting;
    
    ILDDiligenceViewController *diligenceVC = [[ILDDiligenceViewController alloc] initWithDiliganceConfiguration:diligenceConfig];
    
//    UITabBarController *viewController = [[CLTabBarViewController alloc]init];
    
    self.window.rootViewController = diligenceVC;

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
