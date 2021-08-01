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

@interface INSTomatoConfiguration ()

@property (nonatomic, readwrite, assign) BOOL isSpecialFontOptionEnabled;
@property (nonatomic, readwrite, strong) NSString *specialFontName;
@property (nonatomic, readwrite, strong) NSString *specialFontResourcePath;

@property (nonatomic, readwrite, assign) BOOL isMusicOptionEnabled;
@property (nonatomic, readwrite, strong) NSArray *musicNameArray;
@property (nonatomic, readwrite, strong) NSArray *musicUrlPathArray;

@end

@implementation INSTomatoConfiguration

- (instancetype)initDefault {
    if (self = [super init]) {
        INSTaskModel *taskModel1 = [[INSTaskModel alloc] initWithTaskName:@"学习" colorEnum:INSSupportedColorRed];
        INSTaskModel *taskModel2 = [[INSTaskModel alloc] initWithTaskName:@"工作" colorEnum:INSSupportedColorOrange];
        INSTaskModel *taskModel3 = [[INSTaskModel alloc] initWithTaskName:@"冥想" colorEnum:INSSupportedColorYellow];
        INSTaskModel *taskModel4 = [[INSTaskModel alloc] initWithTaskName:@"锻炼" colorEnum:INSSupportedColorGreen];
        
        _taskModelArray = @[taskModel1, taskModel2, taskModel3, taskModel4];
        _activedTask = taskModel1;

        _isAddTaskEnabled = NO;
        
        _tomatoTitle = @"勤之时";
        _tomatoSubTitle = @"美好的励志时光";
        
        _tomatoIcon = [INSTomatoBundle imageNamed:@"ins_appicon_default"];
        _sharedCodeImage = [INSTomatoBundle imageNamed:@"ins_sharedlink_qrcode"];
        _sharedUrlString = @"http://itunes.apple.com/app/id1206687109";
        
        _tomatoBackgroundImage = nil;
        
        _topLeftPluginType = INSSupportedPluginTypeTask;
        _topRightPluginType = INSSupportedPluginTypeClose;
        _bottomLeftPluginType = INSSupportedPluginTypeStatistics;
        _bottomRightPluginType = INSSupportedPluginTypeBookmark;
        
        //
        _isSpecialFontOptionEnabled = NO;
        _specialFontName = @"";
        _specialFontResourcePath = @"";
        
        //
        _isMusicOptionEnabled = NO;
        _musicNameArray = @[];
        _musicUrlPathArray = @[];
        
        _secondsPerMinute = 60;
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

- (void)enableMusicOptionWithMusicNames:(NSArray *)musicNameArray musicUrlPaths:(NSArray *)musicUrlPathArray {
    _isMusicOptionEnabled = YES;
    _musicNameArray = musicNameArray;
    _musicUrlPathArray = musicUrlPathArray;
    
    //如果设置音乐配置，那么音乐名字和路径必须一一对应且至少有一个。
    NSAssert((musicNameArray) && (musicNameArray.count > 0), @"音乐选项配置错误，请参考注释");
    NSAssert((musicUrlPathArray) && (musicUrlPathArray.count > 0), @"音乐选项配置错误，请参考注释");
    NSAssert(musicNameArray.count == musicUrlPathArray.count, @"音乐选项配置错误，请参考注释");
}

- (void)enableSpecialFont:(NSString *)fontName resourcePath:(NSString *)resourcePath {
    _isSpecialFontOptionEnabled = YES;
    _specialFontName = fontName;
    _specialFontResourcePath = resourcePath;
    
    NSAssert((fontName) && (![fontName isEqualToString:@""]), @"至少字体名字不能为空");
    NSAssert((resourcePath) && (![resourcePath isEqualToString:@""]), @"至少路径不能为空");
}

@end
