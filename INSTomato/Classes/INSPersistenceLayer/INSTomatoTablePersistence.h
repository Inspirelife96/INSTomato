//
//  INSTomatoTablePersistence.h
//  ChameleonFramework
//
//  Created by XueFeng Chen on 2021/1/27.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface INSTomatoTablePersistence : NSObject

+ (void)createTomatoTable;
+ (NSDictionary *)readTomatoTable;
+ (void)saveTomatoTable:(NSDictionary *)tomatoTableDictionary;

@end

NS_ASSUME_NONNULL_END
