//
//  INSTomatoConfiguration.m
//  INSTomato
//
//  Created by XueFeng Chen on 2021/2/3.
//

#import "INSTomatoConfiguration.h"

#import "INSBookmarkTableManager.h"
#import "INSBookmarkModel.h"

@implementation INSTomatoConfiguration

- (instancetype)init {
    if (self = [super init]) {
        _topLeftPluginType = INSSupportedPluginTypeTask;
        _topRightPluginType = INSSupportedPluginTypeClose;
        _bottomLeftPluginType = INSSupportedPluginTypeStatistics;
        _bottomRightPluginType = INSSupportedPluginTypeBookmark;
        
        INSBookmarkModel *bookMarkModel = [[INSBookmarkTableManager sharedInstance] prepareBookmarkModel];
        _backgrondImage = bookMarkModel.image;
    }
    
    return self;
}

@end
