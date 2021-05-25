//
//  INSStatisticsTableManager.m
//  ChameleonFramework
//
//  Created by XueFeng Chen on 2021/1/28.
//

#import "INSStatisticsTableManager.h"

#import "INSTaskTableManager.h"
#import "INSStatisticsTodayModel.h"
#import "INSStatisticsHistoryModel.h"
#import "INSPieChartDataModel.h"

#import "INSStatisticsTablePersistence.h"
#import "INSPersistenceConstants.h"

#import "INSTaskModel.h"
#import "INSStatisticsModel.h"
#import "INSDateHelper.h"

@interface INSStatisticsTableManager ()

@property (strong, nonatomic) NSMutableDictionary *statisticsTableDictionary;
@property (strong, nonatomic) NSMutableDictionary *configurationDictionary;
@property (strong, nonatomic) NSMutableDictionary *coreDictionary;
@property (strong, nonatomic) NSMutableDictionary *taskIndexDictionary;
@property (strong, nonatomic) NSMutableDictionary *hourIndexDictionary;
@property (strong, nonatomic) NSMutableDictionary *dayIndexDictionary;
@property (strong, nonatomic) NSMutableDictionary *weekdayIndexDictionary;

@end

@implementation INSStatisticsTableManager

static INSStatisticsTableManager *sharedInstance = nil;

#pragma mark - singleton init

+ (void)createStatisticsTable {
    if ([INSStatisticsTablePersistence readStatisticsTable]) {
        return;
    }
    
    [INSStatisticsTablePersistence createStatisticsTable];
}

+ (void)resetStatisticsTable {
    [INSStatisticsTablePersistence deleteStatisticsTable];
    [INSStatisticsTableManager createStatisticsTable];
}

+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[super allocWithZone:NULL] init];
    });
    
    return sharedInstance;
}

+ (id)allocWithZone:(struct _NSZone *)zone {
    return [INSStatisticsTableManager sharedInstance] ;
}

- (id)copyWithZone:(struct _NSZone *)zone {
    return [INSStatisticsTableManager sharedInstance] ;
}

- (instancetype)init {
    if (self = [super init]) {
        // 读取番茄数据
        _statisticsTableDictionary = [[INSStatisticsTablePersistence readStatisticsTable] mutableCopy];
        
        // 设置配置
        _configurationDictionary = [_statisticsTableDictionary[kStatisticsTableConfiguration] mutableCopy];
        
        // 设置核心数据表
        _coreDictionary = [_statisticsTableDictionary[kStatisticsTableCore] mutableCopy];
        
        // 设置索引
        _taskIndexDictionary = [_statisticsTableDictionary[kStatisticsTableTaskIndex] mutableCopy];
        _hourIndexDictionary = [_statisticsTableDictionary[kStatisticsTableHourIndex] mutableCopy];
        _dayIndexDictionary = [_statisticsTableDictionary[kStatisticsTableDayIndex] mutableCopy];
        _weekdayIndexDictionary = [_statisticsTableDictionary[kStatisticsTableWeekdayIndex] mutableCopy];
    }
    
    return self;
}

- (void)removeAll {
    [self.coreDictionary removeAllObjects];
    [self.taskIndexDictionary removeAllObjects];
    [self.hourIndexDictionary removeAllObjects];
    [self.dayIndexDictionary removeAllObjects];
    [self.weekdayIndexDictionary removeAllObjects];
}

#pragma mark - Public Method

- (void)addStatistics:(INSStatisticsModel *)statisticsModel {
//    NSNumber *maxRowIdNumber = self.configurationDictionary[kStatisticsTableConfigurationMaxRowId];
//    NSNumber *newRowIdNumber = [NSNumber numberWithInteger:([maxRowIdNumber integerValue] + 1)];
//    NSString *tomatoRowId = [newRowIdNumber stringValue];
//    tomatoModel.identifier =tomatoRowId;

    // 添加番茄数据
    [self.coreDictionary setObject:[statisticsModel convertToDictionary] forKey:statisticsModel.identifier];

    // 更新最大RowId
    // self.configurationDictionary[kStatisticsTableConfigurationMaxRowId] = newRowIdNumber;

    // 更新索引
    NSString *stringOfDay = [INSDateHelper stringOfDay:statisticsModel.startDate];
    NSString *stringOfHour = [INSDateHelper stringOfHour:statisticsModel.startDate];
    NSString *stringOfWeekday = [INSDateHelper stringOfWeekday:statisticsModel.startDate];
    
    [self _addStatisticsIdentifier:statisticsModel.identifier toIndexDictionary:self.taskIndexDictionary withIndexKey:statisticsModel.taskId];
    [self _addStatisticsIdentifier:statisticsModel.identifier toIndexDictionary:self.dayIndexDictionary withIndexKey:stringOfDay];
    [self _addStatisticsIdentifier:statisticsModel.identifier toIndexDictionary:self.hourIndexDictionary withIndexKey:stringOfHour];
    [self _addStatisticsIdentifier:statisticsModel.identifier toIndexDictionary:self.weekdayIndexDictionary withIndexKey:stringOfWeekday];
    
    [self saveStatisticsTable];
}

- (void)removeStatisticsByTaskId:(NSString *)taskId {
    // 删除索引
    [self removeStatisticsIdentifierInIndexDictionary:self.taskIndexDictionary byTaskId:taskId];
    [self removeStatisticsIdentifierInIndexDictionary:self.hourIndexDictionary byTaskId:taskId];
    [self removeStatisticsIdentifierInIndexDictionary:self.dayIndexDictionary byTaskId:taskId];
    [self removeStatisticsIdentifierInIndexDictionary:self.weekdayIndexDictionary byTaskId:taskId];

    // 删除番茄数据
    [self.coreDictionary enumerateKeysAndObjectsUsingBlock:^(NSString *rowId, NSDictionary *tomatoDictionary, BOOL * _Nonnull stop) {
        if ([tomatoDictionary[kStatisticsTableCoreTaskIdentifier] isEqualToString:taskId]) {
            [self.coreDictionary removeObjectForKey:rowId];
        }
    }];
    
    [self saveStatisticsTable];
}

- (void)_addStatisticsIdentifier:(NSString *)rowId toIndexDictionary:(NSMutableDictionary *)indexDictionary withIndexKey:(NSString *)indexKey {
    NSMutableArray *tomatoRowIdArray = indexDictionary[indexKey];
    if (!tomatoRowIdArray) {
        tomatoRowIdArray = [[NSMutableArray alloc] init];
    }
    
    [tomatoRowIdArray addObject:rowId];
    indexDictionary[indexKey] = tomatoRowIdArray;
}

// 删除的时候有点搞，这边说明下：
// - task索引，非常简单，直接删除当前这个task的索引即可
// - 其他索引，例如dayIndx，格式是 日期：tomatoRowId数组，所以需要遍历所有的内容，查找tomatoRowId对应的taskId是否和需要删除的对象相同。
// - 由于遍历外层是MutableDictionary，所以可以采用并发
// - 由于遍历内层是MutableArray，删除的话，需要逆向遍历（NSEnumerationReverse），以保证不会因为删除而引起遍历崩溃。
- (void)removeStatisticsIdentifierInIndexDictionary:(NSMutableDictionary *)indexDictionary byTaskId:(NSString *)taskId {
    if (indexDictionary == self.taskIndexDictionary) {
        [self.taskIndexDictionary removeObjectForKey:taskId];
    } else {
        [indexDictionary enumerateKeysAndObjectsWithOptions:NSEnumerationConcurrent usingBlock:^(NSString *key, NSMutableArray *rowIdArray, BOOL * _Nonnull stop) {
            [rowIdArray enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(NSString *rowId, NSUInteger idx, BOOL * _Nonnull stop) {
                NSDictionary *tomatoDictionary = self.coreDictionary[rowId];
                if ([tomatoDictionary[kStatisticsTableCoreTaskIdentifier] isEqualToString:taskId]) {
                    [rowIdArray removeObjectAtIndex:idx];
                }
            }];
            
            // 如果没有数据了，删除当前的key。
            if (rowIdArray.count <= 0) {
                [indexDictionary removeObjectForKey:key];
            }
        }];
    }
}


#pragma mark - Public Method

- (INSStatisticsTodayModel *)fetchStatisticsTodayModel {
    NSInteger __block tomatoTimes = 0;
    NSInteger __block tomatoMinutes = 0;
    NSInteger __block tomatoQuality = 0;
    NSMutableArray<INSPieChartDataModel*> *pieChartDataModelArray = [[NSMutableArray alloc] init];
    
    NSString *stringOfDay = [INSDateHelper stringOfDay:[NSDate date]];
    NSArray *tomatoRowIdArray = self.dayIndexDictionary[stringOfDay];
    
    [tomatoRowIdArray enumerateObjectsUsingBlock:^(NSString *rowId, NSUInteger idx, BOOL * _Nonnull stop) {
        NSDictionary *tomatoDictionary = self.coreDictionary[rowId];
        NSInteger currentMinutes = [tomatoDictionary[kStatisticsTableCoreTomatoMinutes] integerValue];
        NSInteger currentBreakTimes = [tomatoDictionary[kStatisticsTableCoreBreakTimes] integerValue];
        
        tomatoTimes++;
        tomatoMinutes += currentMinutes;
        tomatoQuality += 100 - 5 * currentBreakTimes;

        INSTaskModel *taskModel = [[INSTaskTableManager sharedInstance] taskModelByTaskId:tomatoDictionary[kStatisticsTableCoreTaskIdentifier]];
        INSPieChartDataModel *pieChartDataModel = [[INSPieChartDataModel alloc] init];
        pieChartDataModel.taskName = taskModel.name;
        pieChartDataModel.taskColor = taskModel.color;
        pieChartDataModel.tomatoMinutes = [NSNumber numberWithInteger:currentMinutes];
        [pieChartDataModelArray addObject:pieChartDataModel];
    }];
    
    INSStatisticsTodayModel *statisticsTodayModel = [[INSStatisticsTodayModel alloc] init];
    statisticsTodayModel.tomatoTimes = [NSNumber numberWithInteger:tomatoTimes];
    statisticsTodayModel.tomatoMinutes = [NSNumber numberWithFloat:tomatoMinutes];
    if (tomatoTimes != 0) {
        statisticsTodayModel.tomatoQuality = [NSNumber numberWithFloat:((float)tomatoQuality)/tomatoTimes];
    } else {
        statisticsTodayModel.tomatoQuality = [NSNumber numberWithFloat:0.0];
    }
    statisticsTodayModel.pieChartDataModelArray = pieChartDataModelArray;
    
    return statisticsTodayModel;
}

- (INSStatisticsHistoryModel *)fetchStatisticsHistoryModel {
    
    NSInteger tomatoTimes = [self.coreDictionary count];
    NSInteger tomatoMinutes = [self calculateTomatoMinutes:[self.coreDictionary allKeys]];
    NSInteger tomatoDays = [self.dayIndexDictionary count];
    NSInteger everageMinutes = 0;
    if (tomatoDays > 0) {
        everageMinutes = tomatoMinutes/tomatoDays;
    }
    
    __block NSString *bestTaskName = @"-";
    NSMutableArray *pieChartDataModelArray = [[NSMutableArray alloc] init];
    
    if ([self.taskIndexDictionary count] > 0) {
        
        __block NSInteger bestTaskMinutes = 0;
        
        [self.taskIndexDictionary enumerateKeysAndObjectsUsingBlock:^(NSString *taskId, NSArray *rowIdArray, BOOL * _Nonnull stop) {
            INSTaskModel *taskModel = [[INSTaskTableManager sharedInstance] taskModelByTaskId:taskId];
            NSInteger currentTaskMinutes = [self calculateTomatoMinutes:rowIdArray];
            
            INSPieChartDataModel *pieChartDataModel = [[INSPieChartDataModel alloc] init];
            pieChartDataModel.taskName = taskModel.name;
            pieChartDataModel.taskColor = taskModel.color;
            pieChartDataModel.tomatoMinutes = [NSNumber numberWithInteger:currentTaskMinutes];
            [pieChartDataModelArray addObject:pieChartDataModel];

            if (bestTaskMinutes < currentTaskMinutes) {
                bestTaskMinutes = currentTaskMinutes;
                bestTaskName = taskModel.name;
            }
        }];
    }
    
    __block NSString *bestWeekday = @"-";
    NSInteger bestWeekdayPlus = 0;
    
    if ([self.weekdayIndexDictionary count] > 0) {
        __block NSInteger bestWeekdayMinutes = 0;
        __block NSInteger weekdayMinutesInTotal = 0;
        [self.weekdayIndexDictionary enumerateKeysAndObjectsUsingBlock:^(NSString *weekday, NSArray *rowIdArray, BOOL * _Nonnull stop) {
            
            NSInteger currentWeekdayMinutes = [self calculateTomatoMinutes:rowIdArray];
            weekdayMinutesInTotal += currentWeekdayMinutes;
            
            if (bestWeekdayMinutes < currentWeekdayMinutes) {
                bestWeekdayMinutes = currentWeekdayMinutes;
                bestWeekday = weekday;
            }
        }];
        
        NSInteger everageMinutesByWeekday = weekdayMinutesInTotal / [self.weekdayIndexDictionary count];
        bestWeekdayPlus = (bestWeekdayMinutes - everageMinutesByWeekday) * 100 / everageMinutesByWeekday;
    }
    
    __block NSString *bestHour = @"-";
    NSInteger bestHourPlus = 0;
    
    if ([self.hourIndexDictionary count] > 0) {
        __block NSInteger bestHourMinutes = 0;
        __block NSInteger hourMinutesInTotal = 0;
        [self.hourIndexDictionary enumerateKeysAndObjectsUsingBlock:^(NSString *hour, NSArray *rowIdArray, BOOL * _Nonnull stop) {
            
            NSInteger currentHourMinutes = [self calculateTomatoMinutes:rowIdArray];
            hourMinutesInTotal += currentHourMinutes;
            
            if (bestHourMinutes < currentHourMinutes) {
                bestHourMinutes = currentHourMinutes;
                bestHour = hour;
            }
        }];
        
        NSInteger everageMinutesByHour = hourMinutesInTotal / [self.hourIndexDictionary count];
        bestHourPlus = (bestHourMinutes - everageMinutesByHour) * 100 / everageMinutesByHour;
    }

    NSMutableArray *barChartDataModelArray = [[NSMutableArray alloc] init];
    
    for (int i = 0; i <= 30; i++) {
        NSDate *date = [NSDate dateWithTimeIntervalSinceNow:-(i * 3600 * 24)];
        NSString *stringOfDay = [INSDateHelper stringOfDay:date];
        NSArray *rowIdArray = self.dayIndexDictionary[stringOfDay];
        if (rowIdArray) {
            NSInteger tomatoMinutes = [self calculateTomatoMinutes:rowIdArray];
            [barChartDataModelArray addObject:[NSNumber numberWithInteger:tomatoMinutes]];
        } else {
            [barChartDataModelArray addObject:@0];
        }
    }
    
    INSStatisticsHistoryModel *statisticsHistoryModel = [[INSStatisticsHistoryModel alloc] init];
    statisticsHistoryModel.tomatoTimes = [NSNumber numberWithInteger:tomatoTimes];
    statisticsHistoryModel.tomatoMinutes = [NSNumber numberWithFloat:tomatoMinutes];
    statisticsHistoryModel.tomatoDays = [NSNumber numberWithInteger:tomatoDays];
    statisticsHistoryModel.bestWeekday = bestWeekday;
    statisticsHistoryModel.bestHour = bestHour;
    statisticsHistoryModel.bestTask = bestTaskName;
    statisticsHistoryModel.bestWeekdayPlus = [NSNumber numberWithInteger:bestWeekdayPlus];
    statisticsHistoryModel.bestHourPlus = [NSNumber numberWithInteger:bestWeekdayPlus];
    statisticsHistoryModel.everageMinutes = [NSNumber numberWithInteger:everageMinutes];
    statisticsHistoryModel.pieChartDataModelArray = pieChartDataModelArray;
    statisticsHistoryModel.barChartDataModelArray = barChartDataModelArray;

    return statisticsHistoryModel;
}

- (NSInteger)calculateTomatoMinutes:(NSArray *)tomatoRowIdArray {
    __block NSInteger totalTime = 0;
    
    [tomatoRowIdArray enumerateObjectsUsingBlock:^(NSString *rowId, NSUInteger idx, BOOL * _Nonnull stop) {
        NSDictionary *tomatoDictionary = self.coreDictionary[rowId];
        NSInteger currentTime = [tomatoDictionary[kStatisticsTableCoreTomatoMinutes] integerValue];
        totalTime += currentTime;
    }];
    
    return totalTime;
}

#pragma mark - Private Method

- (void)saveStatisticsTable {
    // update diligence data
    self.statisticsTableDictionary[kStatisticsTableConfiguration] = self.configurationDictionary;
    self.statisticsTableDictionary[kStatisticsTableCore] = self.coreDictionary;
    self.statisticsTableDictionary[kStatisticsTableTaskIndex] = self.taskIndexDictionary;
    self.statisticsTableDictionary[kStatisticsTableDayIndex] = self.dayIndexDictionary;
    self.statisticsTableDictionary[kStatisticsTableHourIndex] = self.hourIndexDictionary;
    self.statisticsTableDictionary[kStatisticsTableWeekdayIndex] = self.weekdayIndexDictionary;
    
    [INSStatisticsTablePersistence saveStatisticsTable:self.statisticsTableDictionary];
}

@end
