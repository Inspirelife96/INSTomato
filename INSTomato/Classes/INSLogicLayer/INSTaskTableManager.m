//
//  INSTaskTableManager.m
//  ChameleonFramework
//
//  Created by XueFeng Chen on 2021/1/28.
//

#import "INSTaskTableManager.h"

#import "INSTaskTablePersistence.h"
#import "INSTaskModel.h"

#import "INSTaskTableConfiguration.h"
#import "INSTomatoTableManager.h"
#import "INSPersistenceConstants.h"

NSString *const kNotificationTaskTableSaved = @"task.table.saved";

@interface INSTaskTableManager ()

@property (strong, nonatomic) NSMutableDictionary *taskTableDictionary;
@property (strong, nonatomic) NSMutableDictionary *configurationDictionary;
@property (strong, nonatomic) NSMutableDictionary *coreDictionary;

@end

@implementation INSTaskTableManager

static INSTaskTableManager *sharedInstance = nil;

#pragma mark - singleton init

+ (BOOL)isTaskTableExists {
    if ([INSTaskTablePersistence readTaskTable]) {
        return YES;
    } else {
        return NO;
    }
}

+ (void)createTaskTableWithConfigration:(INSTaskTableConfiguration *)taskTableConfiguration {
    //如果已经存在任务表，则不需要再重新创建了。
    if ([INSTaskTablePersistence readTaskTable]) {
        return;
    }
    
    [INSTaskTablePersistence createTaskTable];
    
    NSMutableDictionary *taskTableDictionary = [[INSTaskTablePersistence readTaskTable] mutableCopy];
    NSMutableDictionary *configurationDictionary = [taskTableDictionary[kTaskTableConfiguration] mutableCopy];
    NSMutableDictionary *coreDictionary = [taskTableDictionary[kTaskTableCore] mutableCopy];
    
    NSArray *taskModelArray = taskTableConfiguration.taskModelArray;
    
    [taskModelArray enumerateObjectsUsingBlock:^(INSTaskModel * _Nonnull taskModel, NSUInteger idx, BOOL * _Nonnull stop) {
        NSString *identifier = [NSString stringWithFormat:@"%ld", idx];
        taskModel.identifier = identifier;
        [coreDictionary setObject:[taskModel convertToDictionary] forKey:identifier];
    }];
    
    NSNumber *maxRowId = [NSNumber numberWithInteger:(taskModelArray.count - 1)];
    
    [configurationDictionary setObject:maxRowId forKey:kTaskTableConfigurationMaxRowId];
    
    [configurationDictionary setObject:@(taskTableConfiguration.isAddTaskEnabled) forKey:kTaskTableConfigurationIsAddTaskEnabled];
    [configurationDictionary setObject:taskTableConfiguration.taskTableTitle forKey:kTaskTableConfigurationTitle];
    [configurationDictionary setObject:taskTableConfiguration.taskTableDescription forKey:kTaskTableConfigurationDescription];
    
    NSData *iconData = UIImagePNGRepresentation(taskTableConfiguration.taskTableIcon);
    [configurationDictionary setObject:iconData forKey:kTaskTableConfigurationIconData];
    
    taskTableDictionary[kTaskTableConfiguration] = configurationDictionary;
    taskTableDictionary[kTaskTableCore] = coreDictionary;
    
    [INSTaskTablePersistence saveTaskTable:taskTableDictionary];
}

//+ (void)createTaskTable:(NSArray<INSTaskModel *> *)taskModelArray {
//    if ([INSTaskTablePersistence readTaskTable]) {
//        return;
//    }
//    
//    if (!taskModelArray || taskModelArray.count <= 0) {
//        return;
//    }
//    
//    [INSTaskTablePersistence createTaskTable];
//    
//    NSMutableDictionary *taskTableDictionary = [[INSTaskTablePersistence readTaskTable] mutableCopy];
//    NSMutableDictionary *configurationDictionary = [taskTableDictionary[kTaskTableConfiguration] mutableCopy];
//    NSMutableDictionary *coreDictionary = [taskTableDictionary[kTaskTableCore] mutableCopy];
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
//    taskTableDictionary[kTaskTableConfiguration] = configurationDictionary;
//    taskTableDictionary[kTaskTableCore] = coreDictionary;
//    
//    [INSTaskTablePersistence saveTaskTable:taskTableDictionary];
//}

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
    }
    
    return self;
}

#pragma mark - Public Method

- (NSArray *)taskIds {
    return [[self.coreDictionary allKeys] sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        NSInteger taskId1 = [(NSString *)obj1 integerValue];
        NSInteger taskId2 = [(NSString *)obj2 integerValue];
        if (taskId1 < taskId2){
            return NSOrderedAscending;
        } else {
            return NSOrderedDescending;
        }
    }];
}

- (INSTaskModel *)taskModelByTaskId:(NSString *)taskId {
    return [[INSTaskModel alloc] initWithTaskDictionary:self.coreDictionary[taskId]];
}

- (void)addTask:(INSTaskModel *)taskModel {
    NSNumber *maxRowIdNumber = self.configurationDictionary[kTaskTableConfigurationMaxRowId];
    NSNumber *newRowIdNumber = [NSNumber numberWithInteger:([maxRowIdNumber integerValue] + 1)];
    NSString *taskRowId = [newRowIdNumber stringValue];
    
    taskModel.identifier = taskRowId;
    self.taskTableDictionary[taskRowId] = [taskModel convertToDictionary];
    self.configurationDictionary[kTaskTableConfigurationMaxRowId] = newRowIdNumber;
    
    [self saveTaskTable];
}

- (void)updateTask:(NSString *)taskId taskModel:(INSTaskModel *)taskModel {
    self.taskTableDictionary[taskId] = [taskModel convertToDictionary];
    [self saveTaskTable];
}

- (void)removeTask:(NSString *)taskId {
    [self.taskTableDictionary removeObjectForKey:taskId];
    [self saveTaskTable];
    [[INSTomatoTableManager sharedInstance] removeTomatoByTaskId:taskId];
}

- (BOOL)isAddTaskEnabled {
    return [self.configurationDictionary[kTaskTableConfigurationIsAddTaskEnabled] boolValue];
}

- (NSString *)taskTableTitle {
    return self.configurationDictionary[kTaskTableConfigurationTitle];
}

- (NSString *)taskTableDescription {
    return self.configurationDictionary[kTaskTableConfigurationDescription];
}

- (UIImage *)taskTableIcon {
    return [UIImage imageWithData:self.configurationDictionary[kTaskTableConfigurationIconData]];
}

#pragma mark - Private Method

- (void)saveTaskTable {
    self.taskTableDictionary[kTaskTableConfiguration] = self.configurationDictionary;
    self.taskTableDictionary[kTaskTableCore] = self.coreDictionary;
    
    [INSTaskTablePersistence saveTaskTable:self.taskTableDictionary];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationTaskTableSaved object:nil];
}

@end
