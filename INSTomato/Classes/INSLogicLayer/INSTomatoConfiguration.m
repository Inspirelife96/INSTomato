//
//  INSTomatoConfiguration.m
//  INSTomato
//
//  Created by XueFeng Chen on 2021/2/3.
//

#import "INSTomatoConfiguration.h"

#import "INSBookmarkTableManager.h"
#import "INSBookmarkModel.h"

#import "INSTomatoBundle.h"

#import "INSTaskModel.h"

@implementation INSTomatoConfiguration

- (instancetype)initDefault {
    if (self = [super init]) {
        INSTaskModel *taskModel1 = [[INSTaskModel alloc] initWithTaskName:@"学习" colorEnum:INSSupportedColorRed];
        INSTaskModel *taskModel2 = [[INSTaskModel alloc] initWithTaskName:@"工作" colorEnum:INSSupportedColorOrange];
        INSTaskModel *taskModel3 = [[INSTaskModel alloc] initWithTaskName:@"冥想" colorEnum:INSSupportedColorYellow];
        INSTaskModel *taskModel4 = [[INSTaskModel alloc] initWithTaskName:@"锻炼" colorEnum:INSSupportedColorGreen];
        
        _taskModelArray = @[taskModel1, taskModel2, taskModel3, taskModel4];

        _isAddTaskEnabled = NO;
        
        _tomatoTitle = @"勤之时";
        _tomatoSubTitle = @"美好的励志时光";
        
        _tomatoIcon = [INSTomatoBundle imageNamed:@"iphone app 60"];
        _sharedLinkImage = [INSTomatoBundle imageNamed:@"daycard_qrcode_50x50_"];
        
        _tomatoBackgroundImage = nil;
        
        _topLeftPluginType = INSSupportedPluginTypeTask;
        _topRightPluginType = INSSupportedPluginTypeClose;
        _bottomLeftPluginType = INSSupportedPluginTypeStatistics;
        _bottomRightPluginType = INSSupportedPluginTypeBookmark;
    }
    
    return self;
}


+ (instancetype)initWithBlock:(void (^)(INSTomatoConfiguration *))configurationBlock {
    return [[self alloc] initWithBlock:configurationBlock];
}

- (instancetype)initWithBlock:(void (^)(INSTomatoConfiguration *))configurationBlock {
    if (self = [self initDefault]) {
        configurationBlock(self);
    }
    
    return self;
}

@end
