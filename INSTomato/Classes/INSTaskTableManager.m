//
//  INSTaskTableManager.m
//  ChameleonFramework
//
//  Created by XueFeng Chen on 2021/1/28.
//

#import "INSTaskTableManager.h"

#import "INSTaskTablePersistence.h"
#import "INSTaskModel.h"

//#import "INSTaskTableConfiguration.h"
#import "INSStatisticsTableManager.h"
#import "INSPersistenceConstants.h"
#import "INSTomatoConfiguration.h"

#import "INSTomatoConfigurationTableManager.h"

NSString *const kNotificationTaskTableSaved = @"task.table.saved";

@interface INSTaskTableManager ()

@property (strong, nonatomic) NSMutableDictionary *taskTableDictionary;
@property (strong, nonatomic) NSMutableDictionary *configurationDictionary;
@property (strong, nonatomic) NSMutableDictionary *coreDictionary;

@end

@implementation INSTaskTableManager

static INSTaskTableManager *sharedInstance = nil;

#pragma mark - singleton init

//+ (BOOL)isTaskTableExists {
//    if ([INSTaskTablePersistence readTaskTable]) {
//        return YES;
//    } else {
//        return NO;
//    }
//}

//+ (void)createTaskTableWithConfigration:(INSTaskTableConfiguration *)taskTableConfiguration {
//    //如果已经存在任务表，则不需要再重新创建了。
//    if ([INSTaskTablePersistence readTaskTable]) {
//        return;
//    }
//
//    [INSTaskTablePersistence createTaskTable];
//
//    NSMutableDictionary *taskTableDictionary = [[INSTaskTablePersistence readTaskTable] mutableCopy];
//    NSMutableDictionary *configurationDictionary = [taskTableDictionary[kTaskTableConfiguration] mutableCopy];
//    NSMutableDictionary *coreDictionary = [taskTableDictionary[kTaskTableCore] mutableCopy];
//
//    NSArray *taskModelArray = taskTableConfiguration.taskModelArray;
//
//    [taskModelArray enumerateObjectsUsingBlock:^(INSTaskModel * _Nonnull taskModel, NSUInteger idx, BOOL * _Nonnull stop) {
//        NSString *identifier = [NSString stringWithFormat:@"%ld", idx];
//        taskModel.identifier = identifier;
//        [coreDictionary setObject:[taskModel convertToDictionary] forKey:identifier];
//    }];
//
//    NSNumber *maxRowId = [NSNumber numberWithInteger:(taskModelArray.count - 1)];
//
//    [configurationDictionary setObject:maxRowId forKey:kTaskTableConfigurationMaxRowId];
//
//    [configurationDictionary setObject:@(taskTableConfiguration.isAddTaskEnabled) forKey:kTaskTableConfigurationIsAddTaskEnabled];
//    [configurationDictionary setObject:taskTableConfiguration.taskTableTitle forKey:kTaskTableConfigurationTitle];
//    [configurationDictionary setObject:taskTableConfiguration.taskTableDescription forKey:kTaskTableConfigurationDescription];
//
//    NSData *iconData = UIImagePNGRepresentation(taskTableConfiguration.taskTableIcon);
//    [configurationDictionary setObject:iconData forKey:kTaskTableConfigurationIconData];
//
//    taskTableDictionary[kTaskTableConfiguration] = configurationDictionary;
//    taskTableDictionary[kTaskTableCore] = coreDictionary;
//
//    [INSTaskTablePersistence saveTaskTable:taskTableDictionary];
//}

+ (void)createTaskTable:(INSTomatoConfiguration *)configuration {
    if ([INSTaskTablePersistence readTaskTable]) {
        return;
    }
    
    NSArray *taskModelArray = configuration.taskModelArray;
    
    if (!taskModelArray || taskModelArray.count <= 0) {
        NSAssert(taskModelArray && taskModelArray.count > 0 , @"任务列表内容不能为空");
        return;
    }
    
    [INSTaskTablePersistence createTaskTable];
    
    NSMutableDictionary *taskTableDictionary = [[INSTaskTablePersistence readTaskTable] mutableCopy];
    NSMutableDictionary *configurationDictionary = [taskTableDictionary[kTaskTableConfiguration] mutableCopy];
    NSMutableDictionary *coreDictionary = [taskTableDictionary[kTaskTableCore] mutableCopy];
    
    [taskModelArray enumerateObjectsUsingBlock:^(INSTaskModel * _Nonnull taskModel, NSUInteger idx, BOOL * _Nonnull stop) {
//        NSString *identifier = [NSString stringWithFormat:@"%ld", idx];
//        taskModel.identifier = identifier;
        
        if (configuration.isMusicOptionEnabled) {
            if ([taskModel.music isEqualToString:@""]) {
                taskModel.music = configuration.musicNameArray[0];
                taskModel.isMusicModeEnabled = YES;
            }
        }
                
        [coreDictionary setObject:[taskModel convertToDictionary] forKey:taskModel.taskId];
    }];
    
//    NSNumber *maxRowId = [NSNumber numberWithInteger:(taskModelArray.count - 1)];
//
//    [configurationDictionary setObject:maxRowId forKey:kTaskTableConfigurationMaxRowId];
    
    taskTableDictionary[kTaskTableConfiguration] = configurationDictionary;
    taskTableDictionary[kTaskTableCore] = coreDictionary;
    
    [INSTaskTablePersistence saveTaskTable:taskTableDictionary];
}

+ (void)resetTaskTable:(INSTomatoConfiguration *)configuration {
    [INSTaskTablePersistence deleteTaskTable];
    [INSTaskTableManager createTaskTable:configuration];
}

+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[super allocWithZone:NULL] init];
    });
    
    return sharedInstance;
}

+ (id)allocWithZone:(struct _NSZone *)zone {
    return [INSTaskTableManager sharedInstance] ;
}

- (id)copyWithZone:(struct _NSZone *)zone {
    return [INSTaskTableManager sharedInstance] ;
}

- (INSTaskTableManager *)init {
    if (self = [super init]) {
        _taskTableDictionary = [[INSTaskTablePersistence readTaskTable] mutableCopy];
        _configurationDictionary = [_taskTableDictionary[kTaskTableConfiguration] mutableCopy];
        _coreDictionary = [_taskTableDictionary[kTaskTableCore] mutableCopy];
        
        _syncTomatoTaskToServerBlock = nil;
    }
    
    return self;
}

#pragma mark - Public Method

- (NSArray *)taskIds {
    return [[self.coreDictionary allKeys] sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        NSDictionary *task1Dictionary = self.coreDictionary[obj1];
        NSDictionary *task2Dictionary = self.coreDictionary[obj2];
        
        NSString *task1SortId = task1Dictionary[kTaskTableCoreSortId];
        NSString *task2SortId = task2Dictionary[kTaskTableCoreSortId];
        
        return [task1SortId compare:task2SortId];
    }];
}

- (INSTaskModel *)taskModelByTaskId:(NSString *)taskId {
    return [[INSTaskModel alloc] initWithTaskDictionary:self.coreDictionary[taskId]];
}

- (NSInteger)indexOfTask:(INSTaskModel *)taskModel {
    NSArray *taskIds = [self taskIds];
    
    __block NSInteger indexOfTask = -1;
    
    [taskIds enumerateObjectsUsingBlock:^(NSString  *_Nonnull taskId, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([taskModel.taskId isEqualToString:taskId]) {
            indexOfTask = idx;
        }
    }];
    
    return indexOfTask;
}

- (void)addTask:(INSTaskModel *)taskModel {
//    NSNumber *maxRowIdNumber = self.configurationDictionary[kTaskTableConfigurationMaxRowId];
//    NSNumber *newRowIdNumber = [NSNumber numberWithInteger:([maxRowIdNumber integerValue] + 1)];
//    NSString *taskRowId = [newRowIdNumber stringValue];
//
//    taskModel.identifier = taskRowId;
    
    self.coreDictionary[taskModel.taskId] = [taskModel convertToDictionary];
    //self.configurationDictionary[kTaskTableConfigurationMaxRowId] = newRowIdNumber;
    
    [self saveTaskTable];
    
    if (self.syncTomatoTaskToServerBlock) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            self.syncTomatoTaskToServerBlock(taskModel);
        });
    }
}

- (void)updateTask:(NSString *)taskId taskModel:(INSTaskModel *)taskModel {
    self.coreDictionary[taskId] = [taskModel convertToDictionary];
    [self saveTaskTable];
    
    if (self.syncTomatoTaskToServerBlock) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            self.syncTomatoTaskToServerBlock(taskModel);
        });
    }
}

- (void)removeTask:(NSString *)taskId {
    [self.coreDictionary removeObjectForKey:taskId];
    [self saveTaskTable];
    [[INSStatisticsTableManager sharedInstance] removeStatisticsByTaskId:taskId];
}

//- (BOOL)isAddTaskEnabled {
//    return [self.configurationDictionary[kTaskTableConfigurationIsAddTaskEnabled] boolValue];
//}
//
//- (NSString *)taskTableTitle {
//    return self.configurationDictionary[kTaskTableConfigurationTitle];
//}
//
//- (NSString *)taskTableDescription {
//    return self.configurationDictionary[kTaskTableConfigurationDescription];
//}
//
//- (UIImage *)taskTableIcon {
//    return [UIImage imageWithData:self.configurationDictionary[kTaskTableConfigurationIconData]];
//}

#pragma mark - Private Method

- (void)saveTaskTable {
    self.taskTableDictionary[kTaskTableConfiguration] = self.configurationDictionary;
    self.taskTableDictionary[kTaskTableCore] = self.coreDictionary;
    
    [INSTaskTablePersistence saveTaskTable:self.taskTableDictionary];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationTaskTableSaved object:nil];
}

- (BOOL)isTaskNameAlreadyExist:(NSString *)taskName identifier:(NSString *)identifier {
    __block BOOL isTaskNameAlreadyExist = NO;

    [self.coreDictionary enumerateKeysAndObjectsUsingBlock:^(NSString  * _Nonnull  taskIdentifier, NSDictionary * _Nonnull taskDictionary, BOOL * _Nonnull stop) {
            if (![taskIdentifier isEqualToString:identifier] && [taskDictionary[kTaskTableCoreName] isEqualToString:taskName]) {
                isTaskNameAlreadyExist =  YES;
            }
    }];
    
    return isTaskNameAlreadyExist;
}

@end
