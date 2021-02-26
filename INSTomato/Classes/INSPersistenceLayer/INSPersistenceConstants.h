//
//  INSPersistenceConstants.h
//  ChameleonFramework
//
//  Created by XueFeng Chen on 2021/1/27.
//

#ifndef INSPersistenceConstants_h
#define INSPersistenceConstants_h

#pragma mark - task table column

// 任务列表包括

// 配置表
extern NSString *const kTaskTableConfiguration;

// 核心表
extern NSString *const kTaskTableCore;

// 配置表

// 当前最大的RowId
extern NSString *const kTaskTableConfigurationMaxRowId;

// 当前版本，用于更新
extern NSString *const kTaskTableConfigurationVersion;

// 核心表，核心表记录了当前的任务配置内容

// Id
extern NSString *const kTaskTableCoreIdentifier;

// 名字
extern NSString *const kTaskTableCoreName;

// 配色
extern NSString *const kTaskTableCoreColor;

// 音乐
extern NSString *const kTaskTableCoreMusic;

// 番茄时长，以分钟为单位
extern NSString *const kTaskTableCoreTomatoMinutes;

// 休息时长，以分钟为单位
extern NSString *const kTaskTableCoreRestMinutes;

// 休息模式是否打开，YES状态下，番茄完成后会自动切换为休息状态
extern NSString *const kTaskTableCoreIsRestModeEnabled;

// 音乐是否打开，YES状态下，激活番茄会播放音乐
extern NSString *const kTaskTableCoreIsMusicModeEnabled;

// 推送提醒是否打开，YES状态下，每天的制定时间，会推送消息
extern NSString *const kTaskTableCoreIsAlertModeEnabled;

// 推送提醒的时间
extern NSString *const kTaskTableCoreAlertDate;

#pragma mark - statistics table column

// 统计表包括
// 配置表
// 核心表
// 任务索引
// 时间索引
// 日期索引
// 星期索引

extern NSString *const kStatisticsTableConfiguration;
extern NSString *const kStatisticsTableCore;
extern NSString *const kStatisticsTableTaskIndex;
extern NSString *const kStatisticsTableHourIndex;
extern NSString *const kStatisticsTableDayIndex;
extern NSString *const kStatisticsTableWeekdayIndex;

#pragma mark - statistics table configuration column

// 配置表

// 当前最大的RowId
extern NSString *const kStatisticsTableConfigurationMaxRowId;

// 版本号，用于更新
extern NSString *const kStatisticsTableConfigurationVersion;

#pragma mark - statistics table core column

// 核心表

// Id
extern NSString *const kStatisticsTableCoreIdentifier;

// 任务Id
extern NSString *const kStatisticsTableCoreTaskIdentifier;

// 番茄开始时间
extern NSString *const kStatisticsTableCoreStartDate;

// 番茄结束时间
extern NSString *const kStatisticsTableCoreEndDate;

// 中断次数
extern NSString *const kStatisticsTableCoreBreakTimes;

// 番茄时长
extern NSString *const kStatisticsTableCoreTomatoMinutes;


#pragma mark - bookmark table column

// 书签表

// 书签保存的时间
extern NSString *const kBookMarkSavedDate;

// 图片标题
extern NSString *const kBookMarkTitle;

// 每日一句
extern NSString *const kBookMarkWords;

// 图片数据
extern NSString *const kBookMarkImageData;

#pragma mark - tomato configuration table column

// 是否允许添加/删除任务，当选项为YES时
// 任务列表界面，右上角出现额外的添加选项
// 编辑任务界面，右上角出现额外的删除选项
extern NSString *const kTomatoConfigurationTableIsAddTaskEnabled;

// 标题，任务列表界面，标题，默认为“勤之时”
extern NSString *const kTomatoConfigurationTableTitle;

// 副标题，任务列表界面，副标题，默认为“美好的励志时光”
extern NSString *const kTomatoConfigurationTableSubTitle;

// 应用图标，任务列表界面，应用图标，默认为勤之时的图标
extern NSString *const kTomatoConfigurationTableIconData;

// 背景图片，番茄界面，背景图片，默认为空, 为空时，背景图片会使用书签的背景图片
extern NSString *const kTomatoConfigurationTableBackgroundImageData;

// 链接二维码，书签界面，链接二维码，默认为勤之时的二维码
extern NSString *const kTomatoConfigurationTableSharedLinkImageData;

// 上左，上右，下左，下右四个角标的设置，默认分别为任务，关闭，统计，书签
extern NSString *const kTomatoConfigurationTableTopLeftPluginType;
extern NSString *const kTomatoConfigurationTableTopRightPluginType;
extern NSString *const kTomatoConfigurationTableBottomLeftPluginType;
extern NSString *const kTomatoConfigurationTableBottomRightPluginType;

#endif /* INSPersistenceConstants_h */
