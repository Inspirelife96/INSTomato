//
//  INSTaskTableManager.h
//  ChameleonFramework
//
//  Created by XueFeng Chen on 2021/1/28.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class INSTaskModel;
@class INSTomatoConfiguration;
//@class INSTaskTableConfiguration;

// 任务表的增删改查，单例模式。APP仅维护一份内存数据，结合INSTaskTablePersistence进行持久化。

// task表以字典的形式进行存储，为taskId(NSString *)：task(INSTaskModel)

// 提供如下方法

// 获取所有taskId
// 根据taskId获取taskModel
// 增
// 删
// 改

extern NSString *const kNotificationTaskTableSaved;

//typedef NSArray *_Nonnull(^SyncFromServerBlock)(void);
typedef void(^SyncTomatoTaskToServerBlock)(INSTaskModel *taskModel);

@interface INSTaskTableManager : NSObject

@property (nonatomic, copy) SyncTomatoTaskToServerBlock syncTomatoTaskToServerBlock;

+ (void)createTaskTable:(INSTomatoConfiguration *)configuration;
+ (void)resetTaskTable:(INSTomatoConfiguration *)configuration;

+ (instancetype)sharedInstance;

+ (BOOL)isTaskTableExists;

//- (BOOL)isAddTaskEnabled;
//- (NSString *)taskTableTitle;
//- (NSString *)taskTableDescription;
//- (UIImage *)taskTableIcon;

- (NSArray<NSString *> *)taskIds;
- (INSTaskModel *)taskModelByTaskId:(NSString *)taskId;
- (NSInteger)indexOfTask:(INSTaskModel *)taskModel;

- (void)addTaskToLocal:(INSTaskModel *)taskModel;
- (void)addTask:(INSTaskModel *)taskModel;
- (void)removeTask:(NSString *)taskId;
- (void)updateTask:(NSString *)taskId taskModel:(INSTaskModel *)taskModel;

// identifer不同，名字相同，则返回YES。
- (BOOL)isTaskNameAlreadyExist:(NSString *)taskName identifier:(NSString *)identifier;

//- (NSString *)generateIdentifier;

@end

NS_ASSUME_NONNULL_END
