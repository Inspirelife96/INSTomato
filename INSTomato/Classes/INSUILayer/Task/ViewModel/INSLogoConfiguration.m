//
//  INSLogoConfiguration.m
//  INSTomato
//
//  Created by XueFeng Chen on 2021/1/31.
//

#import "INSLogoConfiguration.h"

#import "INSTomatoConfigurationTableManager.h"
#import "INSTomatoBundle.h"

@implementation INSLogoConfiguration

- (instancetype)init {
    if (self = [super init]) {
        _logoName = [[INSTomatoConfigurationTableManager sharedInstance] title];
        _logoDescription = [[INSTomatoConfigurationTableManager sharedInstance] subTitle];
        _logoImage = [[INSTomatoConfigurationTableManager sharedInstance] icon];
    }
    
    return self;
}

@end
