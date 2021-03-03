//
//  INSMusicHelper.h
//  INSTomato
//
//  Created by XueFeng Chen on 2021/2/1.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface INSMusicHelper : NSObject

//+ (NSURL *)musicUrlByName:(NSString *)musicName;
+ (NSArray *)musicNameArray;
+ (NSArray *)musicUrlPathArray;

@end

NS_ASSUME_NONNULL_END
