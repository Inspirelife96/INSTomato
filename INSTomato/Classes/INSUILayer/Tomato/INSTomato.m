//
//  INSTomato.m
//  INSTomato
//
//  Created by XueFeng Chen on 2021/2/22.
//

#import "INSTomato.h"

#import "INSTomatoConfigurationTableManager.h"
#import "INSTaskTableManager.h"
#import "INSStatisticsTableManager.h"
#import "INSBookmarkTableManager.h"

#import "INSTomatoBundle.h"

#import "INSTomatoConfiguration.h"


@implementation INSTomato

+ (void)initializeWithConfiguration:(INSTomatoConfiguration *)configuration {
    // 初始化配置表
    [INSTomatoConfigurationTableManager createTomatoConfigurationTable:configuration];
    
    // 初始化任务表
    [INSTaskTableManager createTaskTable:configuration.taskModelArray];
    
    // 初始化统计表
    [INSStatisticsTableManager createStatisticsTable];
    
    // 初始化书签表
    [INSBookmarkTableManager createBookmarkTable];
    
    // 初始化特殊的隶书字体
    [INSTomatoBundle loadSpecialFont];
}

+ (void)resetWithConfiguration:(INSTomatoConfiguration *)configuration {
    // 重置配置表
    [INSTomatoConfigurationTableManager resetTomatoConfigurationTable:configuration];
    
    // 重置任务表
    [INSTaskTableManager resetTaskTable:configuration.taskModelArray];
    
    // 重置统计表
    [INSStatisticsTableManager resetStatisticsTable];
    
    // 重置书签表
    [INSBookmarkTableManager resetBookmarkTable];
    
    // 初始化特殊的隶书字体
    [INSTomatoBundle loadSpecialFont];
    
}

@end
