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
    
    
    // 关于INTomato的配置，需要做如下五点：
    
    // 1. 任务表的配置
    
    // 1.1 定义任务模型
    INSTaskModel *taskModel1 = [[INSTaskModel alloc] initWithTaskName:@"学习" colorEnum:INSSupportedColorRed];
    INSTaskModel *taskModel2 = [[INSTaskModel alloc] initWithTaskName:@"工作" colorEnum:INSSupportedColorOrange];
    INSTaskModel *taskModel3 = [[INSTaskModel alloc] initWithTaskName:@"冥想" colorEnum:INSSupportedColorYellow];
    INSTaskModel *taskModel4 = [[INSTaskModel alloc] initWithTaskName:@"锻炼" colorEnum:INSSupportedColorGreen];

    // 1.2 任务表配置INSTaskTableConfiguration，必须以任务数组来初始化。
    INSTaskTableConfiguration *taskTableConfiguration = [[INSTaskTableConfiguration alloc] initWithTaskModelArray:@[taskModel1, taskModel2, taskModel3, taskModel4]];
    
    // 1.3 配置其他选项, 不配置就是使用系统默认的
    //taskTableConfiguration.taskTableTitle = @"勤之时"; // 默认值为 勤之时
    //taskTableConfiguration.taskTableDescription = @"美好的励志时光";// 默认值为美好的励志时光
    //taskTableConfiguration.taskTableIcon = [UIImage imageNamed:@"xxxx"]; 建议60x60 默认值为勤之时的App Icon
    
    // 2. 根据任务表的配置，创建任务表
    [INSTaskTableManager createTaskTableWithConfigration:taskTableConfiguration];
    
    // 3. 统计表的配置
    [INSTomatoTableManager createTomatoTable];
    
    // 4. 书签表的配置
    // 创建书签表
    // 更新书签表
    [INSBookmarkTableManager createBookmarkTable];
    [INSBookmarkTableManager updateBookmarkTable];
    
    // 5. TomatoBundle配置，因需要加载特殊字体。
    [INSTomatoBundle loadSpecialFont];
    
    // 6. 番茄的配置
    // 上下左右四个角标的内容定义
    // 背景图片的定义
    INSTomatoConfiguration *tomatoConfiguration = [[INSTomatoConfiguration alloc] init];
    
    tomatoConfiguration.topLeftPluginType = INSSupportedPluginTypeTask;
    tomatoConfiguration.topRightPluginType = INSSupportedPluginTypeStatistics;
    tomatoConfiguration.bottomLeftPluginType = INSSupportedPluginTypeBookmark;
    tomatoConfiguration.bottomRightPluginType = INSSupportedPluginTypeNone;
    
    //tomatoConfiguration.backgrondImage = [UIImage imageNamed:@"xxxx"]; // 背景图片，默认使用书签表的背景图片。
    
    // 生成番茄视图
    INSTomatoViewController *tomatoVC = [[INSTomatoViewController alloc] initWithTomatoConfiguration:tomatoConfiguration];
    
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
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
