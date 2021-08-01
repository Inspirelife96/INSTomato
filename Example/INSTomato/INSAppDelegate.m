//
//  INSAppDelegate.m
//  INSTomato
//
//  Created by inspirelife@hotmail.com on 01/27/2021.
//  Copyright (c) 2021 inspirelife@hotmail.com. All rights reserved.
//

#import "INSAppDelegate.h"

#import "INSMusicHelper.h"

#import "INSHomeViewController.h"

#import <INSTomato/INSTomato-umbrella.h>

#import <CoreText/CoreText.h>


@implementation INSAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [INSTomato initializeWithConfiguration:[INSTomatoConfiguration initWithBlock:^(INSTomatoConfiguration * _Nonnull tomatoConfiguration) {
        
        tomatoConfiguration.isAddTaskEnabled = NO;
        
        // 必须是m4a后缀的文件
        [tomatoConfiguration enableMusicOptionWithMusicNames:[INSMusicHelper musicNameArray] musicUrlPaths:[INSMusicHelper musicUrlPathArray]];
        
        // 必须是ttf后缀的文件
        [tomatoConfiguration enableSpecialFont:@"-" resourcePath:[[NSBundle mainBundle] pathForResource:@"叶根友蚕燕隶书" ofType:@"ttf"]];
        
        //配置任务列表
        INSTaskModel *taskModel1 = [[INSTaskModel alloc] initWithTaskName:@"专题" musicName:@"云端" colorEnum:INSSupportedColorRed];
        INSTaskModel *taskModel2 = [[INSTaskModel alloc] initWithTaskName:@"酷文" musicName:@"心灵" colorEnum:INSSupportedColorOrange];
        INSTaskModel *taskModel3 = [[INSTaskModel alloc] initWithTaskName:@"奇题" musicName:@"星夜" colorEnum:INSSupportedColorOrange];
        INSTaskModel *taskModel4 = [[INSTaskModel alloc] initWithTaskName:@"随心" musicName:@"森林" colorEnum:INSSupportedColorOrange];        tomatoConfiguration.taskModelArray = @[taskModel1, taskModel2, taskModel3, taskModel4];
        
        // 配置其他选项, 可选，不配置就是使用系统默认的
        //tomatoConfiguration.isAddTaskEnabled = NO;
        tomatoConfiguration.tomatoTitle = @"酷文奇题";
        tomatoConfiguration.tomatoSubTitle = @"美好的励志时光";
        //tomatoConfiguration.tomatoIcon = [UIImage imageNamed:@"xxxx"]; //建议60x60 默认值为勤之时的App Icon
        //tomatoConfiguration.tomatoBackgroundImage = [UIImage imageNamed:@"xxxx"]; //建议符合屏幕大小 默认值为
        
        tomatoConfiguration.topLeftPluginType = INSSupportedPluginTypeClose;
        tomatoConfiguration.topRightPluginType = INSSupportedPluginTypeTask;
        tomatoConfiguration.bottomLeftPluginType = INSSupportedPluginTypeBookmark;
        tomatoConfiguration.bottomRightPluginType = INSSupportedPluginTypeStatistics;
        tomatoConfiguration.secondsPerMinute = 60;
    }]];
    
    

    INSHomeViewController *homeVC = [[INSHomeViewController alloc] init];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    self.window.rootViewController = homeVC;

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
