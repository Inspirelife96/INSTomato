//
//  INSTaskTableManager.m
//  ChameleonFramework
//
//  Created by XueFeng Chen on 2021/1/28.
//

#import "INSTaskTableManager.h"

#import "INSTaskTablePersistence.h"
#import "INSTaskModel.h"

#import "INSTomatoTableManager.h"

@interface INSTaskTableManager ()

@property (strong, nonatomic) NSMutableDictionary *taskTableDictionary;

@end

@implementation INSTaskTableManager

static INSTaskTableManager *sharedInstance = nil;

#pragma mark - singleton init

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
    }
    
    return self;
}

#pragma mark - Public Method

- (NSArray *)taskIds {
    return [[self.taskTableDictionary allKeys] sortedArrayUsingComparator:^NSComparisonResult(NSString *  _Nonnull taskId1String, NSString *  _Nonnull taskId2String) {
        if ([taskId1String integerValue] < [taskId2String integerValue]){
            return NSOrderedAscending;
        } else {
            return NSOrderedDescending;
        }
    }];
}

- (INSTaskModel *)taskModelByTaskId:(NSString *)taskId {
    return [[INSTaskModel alloc] initWithTaskDictionary:self.taskTableDictionary[taskId]];
}

- (void)addTask:(INSTaskModel *)taskModel {
    NSString *taskId = [self generateTaskId];
    self.taskTableDictionary[taskId] = [taskModel convertToDictionary];
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

#pragma mark - Private Method

- (NSString *)generateTaskId {
    NSArray *taskIds = [self taskIds];
    if (!taskIds || taskIds.count == 0) {
        return @"0";
    }
    
    NSInteger maxNumber = [taskIds[taskIds.count - 1] integerValue];
    return [NSString stringWithFormat:@"%ld", (long)(maxNumber + 1)];
}

- (void)saveTaskTable {
    [INSTaskTablePersistence saveTaskTable:self.taskTableDictionary];
}

@end
