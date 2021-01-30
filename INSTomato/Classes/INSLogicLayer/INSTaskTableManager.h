//
//  INSTaskTableManager.h
//  ChameleonFramework
//
//  Created by XueFeng Chen on 2021/1/28.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class INSTaskModel;

// 任务表的增删改查，单例模式。APP仅维护一份内存数据，结合INSTaskTablePersistence进行持久化。

// task表以字典的形式进行存储，为taskId(NSString *)：task(INSTaskModel)

// 提供如下方法

// 获取所有taskId
// 根据taskId获取taskModel
// 增
// 删
// 改

@interface INSTaskTableManager : NSObject

+ (instancetype)sharedInstance;

- (NSArray<NSString *> *)taskIds;
- (INSTaskModel *)taskModelByTaskId:(NSString *)taskId;

- (void)addTask:(INSTaskModel *)taskModel;
- (void)removeTask:(NSString *)taskId;
- (void)updateTask:(NSString *)taskId taskModel:(INSTaskModel *)taskModel;

@end

NS_ASSUME_NONNULL_END