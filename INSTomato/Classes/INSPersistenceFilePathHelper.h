//
//  INSPersistenceFilePathHelper.h
//  ChameleonFramework
//
//  Created by XueFeng Chen on 2021/1/27.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface INSPersistenceFilePathHelper : NSObject

+ (NSString *)persistenceFilePath:(NSString *)persistenceFileName;

@end

NS_ASSUME_NONNULL_END
