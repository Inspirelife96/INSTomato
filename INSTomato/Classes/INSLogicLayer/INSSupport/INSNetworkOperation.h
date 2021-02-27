//
//  INSNetworkOperation.h
//  INSTomato
//
//  Created by XueFeng Chen on 2021/2/5.
//

#import <Foundation/Foundation.h>

@class INSBookmarkModel;

NS_ASSUME_NONNULL_BEGIN

@interface INSNetworkOperation : NSObject

- (void)downloadBookmarkData:(void (^_Nullable)(INSBookmarkModel *bookmarkModel, NSError *_Nullable error))block;

@end

NS_ASSUME_NONNULL_END
