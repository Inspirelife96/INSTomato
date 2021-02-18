//
//  INSBookmarkTableManager.h
//  INSTomato
//
//  Created by XueFeng Chen on 2021/2/5.
//

#import <Foundation/Foundation.h>

@class INSBookmarkModel;

NS_ASSUME_NONNULL_BEGIN

@interface INSBookmarkTableManager : NSObject

+ (void)createBookmarkTable;

//
+ (void)updateBookmarkTable;

+ (instancetype)sharedInstance;

- (INSBookmarkModel *)prepareBookmarkModel;

@end

NS_ASSUME_NONNULL_END
