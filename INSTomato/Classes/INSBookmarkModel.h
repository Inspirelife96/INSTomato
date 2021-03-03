//
//  INSBookmarkModel.h
//  INSTomato
//
//  Created by XueFeng Chen on 2021/2/5.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface INSBookmarkModel : NSObject

@property (nonatomic, copy) NSDate *date;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *words;
@property (nonatomic, copy) UIImage *image;

- (NSDictionary *)toDictionary;

@end

NS_ASSUME_NONNULL_END
