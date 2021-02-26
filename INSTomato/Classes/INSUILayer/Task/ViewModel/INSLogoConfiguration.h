//
//  INSLogoConfiguration.h
//  INSTomato
//
//  Created by XueFeng Chen on 2021/1/31.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface INSLogoConfiguration : NSObject

@property(nonatomic, strong) UIImage *logoImage;
@property(nonatomic, strong) NSString *logoName;
@property(nonatomic, strong) NSString *logoDescription;

@end

NS_ASSUME_NONNULL_END
