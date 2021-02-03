//
//  INSLogoConfiguration.m
//  INSTomato
//
//  Created by XueFeng Chen on 2021/1/31.
//

#import "INSLogoConfiguration.h"

@implementation INSLogoConfiguration

- (instancetype)init {
    if (self = [super init]) {
        _logoName = @"勤之时";
        _logoDescription = @"美好的励志时光";
        _logoImage = [UIImage imageNamed:@"iphone app 60"];
    }
    
    return self;
}

@end
