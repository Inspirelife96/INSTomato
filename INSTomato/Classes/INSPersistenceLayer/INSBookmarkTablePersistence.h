//
//  INSBookmarkTablePersistence.h
//  INSTomato
//
//  Created by XueFeng Chen on 2021/2/5.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface INSBookmarkTablePersistence : NSObject

+ (void)createBookmarkTable;
+ (NSDictionary *)readBookmarkTable;
+ (void)saveBookmarkTable:(NSDictionary *)bookmarkTableDictionary;
+ (void)deleteBookmarkTable;

@end

NS_ASSUME_NONNULL_END
