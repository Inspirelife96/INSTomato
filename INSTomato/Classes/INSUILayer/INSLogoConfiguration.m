//
//  INSLogoConfiguration.m
//  INSTomato
//
//  Created by XueFeng Chen on 2021/1/31.
//

#import "INSLogoConfiguration.h"

#import "INSTaskTableManager.h"
#import "INSTomatoBundle.h"

@implementation INSLogoConfiguration

- (instancetype)init {
    if (self = [super init]) {
        _logoName = [[INSTaskTableManager sharedInstance] taskTableTitle];
        _logoDescription = [[INSTaskTableManager sharedInstance] taskTableDescription];
        _logoImage = [[INSTaskTableManager sharedInstance] taskTableIcon];
    }
    
    return self;
}

@end
