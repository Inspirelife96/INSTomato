//
//  INSTomatoConfigurationTablePersistence.h
//  INSTomato
//
//  Created by XueFeng Chen on 2021/2/22.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface INSTomatoConfigurationTablePersistence : NSObject

+ (void)createTomatoConfigurationTable;
+ (NSDictionary *)readTomatoConfigurationTable;
+ (void)saveTomatoConfigurationTable:(NSDictionary *)tomatoConfigurationTableDictionary;
+ (void)deleteTomatoConfigurationTable;

@end

NS_ASSUME_NONNULL_END
