//
//  INSTaskTablePersistence.h
//  ChameleonFramework
//
//  Created by XueFeng Chen on 2021/1/27.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

// 关于持久性的方案，最终还是采用了PList的方式，而没有用数据库。不过命名上，还是认为这是一张表，保存在PList文件中。
// 提供如下方法：
// - 创建表
// - 读取表
// - 保存
// 至于表的增删改查，交由逻辑层去处理。类似于这是DDL的部分，而逻辑层处理的是DML的部分。

@interface INSTaskTablePersistence : NSObject

+ (void)createTaskTable;
+ (NSDictionary *)readTaskTable;
+ (void)saveTaskTable:(NSDictionary *)taskTableDictionary;
+ (void)deleteTaskTable;

@end

NS_ASSUME_NONNULL_END
