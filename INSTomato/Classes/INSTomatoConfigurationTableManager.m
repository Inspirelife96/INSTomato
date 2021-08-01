//
//  INSTomatoConfigurationTableManager.m
//  INSTomato
//
//  Created by XueFeng Chen on 2021/2/22.
//

#import "INSTomatoConfigurationTableManager.h"

#import "INSTomatoConfiguration.h"
#import "INSTaskModel.h"

#import "INSTomatoConfigurationTablePersistence.h"

#import "INSPersistenceConstants.h"

#import <CoreText/CoreText.h>

static INSTomatoConfigurationTableManager *sharedInstance = nil;

@interface INSTomatoConfigurationTableManager ()

@property (strong, nonatomic) NSDictionary *tomatoConfigurationDictionary;

@end

@implementation INSTomatoConfigurationTableManager

+ (void)createTomatoConfigurationTable:(INSTomatoConfiguration *)tomatoConfiguration {
    if ([INSTomatoConfigurationTablePersistence readTomatoConfigurationTable]) {

        // 测试时，每次重新安装会导致安装包的路径发生变化，这就意味着这两个路径必须重新设置。
        // 正式的版本，可能不会有这种问题。
        NSDictionary *tomatoConfigurationDictionary = [INSTomatoConfigurationTablePersistence readTomatoConfigurationTable];
        [tomatoConfigurationDictionary setValue:tomatoConfiguration.specialFontResourcePath forKey:kTomatoConfigurationTableSpecialFontResourcePath];
        
        [tomatoConfigurationDictionary setValue:tomatoConfiguration.musicUrlPathArray forKey:kTomatoConfigurationTableMusicUrlPathArray];
        
        [INSTomatoConfigurationTablePersistence saveTomatoConfigurationTable:tomatoConfigurationDictionary];
        
        return;
    }
    
    [INSTomatoConfigurationTablePersistence createTomatoConfigurationTable];
    
    NSDictionary *tomatoConfigurationDictionary = [INSTomatoConfigurationTablePersistence readTomatoConfigurationTable];
    
    [tomatoConfigurationDictionary setValue:@(tomatoConfiguration.isAddTaskEnabled) forKey:kTomatoConfigurationTableIsAddTaskEnabled];
    [tomatoConfigurationDictionary setValue:tomatoConfiguration.tomatoTitle forKey:kTomatoConfigurationTableTitle];
    [tomatoConfigurationDictionary setValue:tomatoConfiguration.tomatoSubTitle forKey:kTomatoConfigurationTableSubTitle];
    
    if (tomatoConfiguration.tomatoIcon) {
        NSData *iconData = UIImageJPEGRepresentation(tomatoConfiguration.tomatoIcon, 0.5);
        [tomatoConfigurationDictionary setValue:iconData forKey:kTomatoConfigurationTableIconData];
    }
    
    if (tomatoConfiguration.tomatoBackgroundImage) {
        NSData *backgroundImageData = UIImageJPEGRepresentation(tomatoConfiguration.tomatoBackgroundImage, 0.5);
        [tomatoConfigurationDictionary setValue:backgroundImageData forKey:kTomatoConfigurationTableBackgroundImageData];
    }
    
    if (tomatoConfiguration.sharedCodeImage) {
        NSData *sharedCodeImageData = UIImageJPEGRepresentation(tomatoConfiguration.sharedCodeImage, 0.5);
        [tomatoConfigurationDictionary setValue:sharedCodeImageData forKey:kTomatoConfigurationTablesharedCodeImageData];
    }
    
    if (tomatoConfiguration.sharedUrlString) {
        [tomatoConfigurationDictionary setValue:tomatoConfiguration.sharedUrlString forKey:kTomatoConfigurationTablesharedUrlString];
    }
    
    [tomatoConfigurationDictionary setValue:@(tomatoConfiguration.topLeftPluginType) forKey:kTomatoConfigurationTableTopLeftPluginType];
    [tomatoConfigurationDictionary setValue:@(tomatoConfiguration.topRightPluginType) forKey:kTomatoConfigurationTableTopRightPluginType];
    [tomatoConfigurationDictionary setValue:@(tomatoConfiguration.bottomLeftPluginType) forKey:kTomatoConfigurationTableBottomLeftPluginType];
    [tomatoConfigurationDictionary setValue:@(tomatoConfiguration.bottomRightPluginType) forKey:kTomatoConfigurationTableBottomRightPluginType];
    
    [tomatoConfigurationDictionary setValue:[tomatoConfiguration.activedTask convertToDictionary]  forKey:kTomatoConfigurationTableActivedTask];
    
    [tomatoConfigurationDictionary setValue:@(tomatoConfiguration.isSpecialFontOptionEnabled) forKey:kTomatoConfigurationTableIsSpecialFontOptionEnabled];
    [tomatoConfigurationDictionary setValue:tomatoConfiguration.specialFontName forKey:kTomatoConfigurationTableSpecialFontName];
    [tomatoConfigurationDictionary setValue:tomatoConfiguration.specialFontResourcePath forKey:kTomatoConfigurationTableSpecialFontResourcePath];
    
    [tomatoConfigurationDictionary setValue:@(tomatoConfiguration.isMusicOptionEnabled) forKey:kTomatoConfigurationTableIsMusicOptionEnabled];
    [tomatoConfigurationDictionary setValue:tomatoConfiguration.musicNameArray forKey:kTomatoConfigurationTableMusicNameArray];
    [tomatoConfigurationDictionary setValue:tomatoConfiguration.musicUrlPathArray forKey:kTomatoConfigurationTableMusicUrlPathArray];
    
    [tomatoConfigurationDictionary setValue:@(tomatoConfiguration.secondsPerMinute) forKey:kTomatoConfigurationTableSecondsPerMinute];
    
    [INSTomatoConfigurationTablePersistence saveTomatoConfigurationTable:tomatoConfigurationDictionary];
}

+ (void)resetTomatoConfigurationTable:(INSTomatoConfiguration *)tomatoConfiguration {
    [INSTomatoConfigurationTablePersistence deleteTomatoConfigurationTable];
    [INSTomatoConfigurationTableManager createTomatoConfigurationTable:tomatoConfiguration];
}

+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[super allocWithZone:NULL] init];
    });
    
    return sharedInstance;
}

+ (id)allocWithZone:(struct _NSZone *)zone {
    return [INSTomatoConfigurationTableManager sharedInstance] ;
}

- (id)copyWithZone:(struct _NSZone *)zone {
    return [INSTomatoConfigurationTableManager sharedInstance] ;
}

- (instancetype)init {
    if (self = [super init]) {
        _tomatoConfigurationDictionary = [INSTomatoConfigurationTablePersistence readTomatoConfigurationTable];
        
        // 如果使用了特殊字体，加载字体
        if ([_tomatoConfigurationDictionary[kTomatoConfigurationTableIsSpecialFontOptionEnabled] boolValue]) {
            NSString *fontName = _tomatoConfigurationDictionary[kTomatoConfigurationTableSpecialFontName];
            NSString *fontResourcePath = _tomatoConfigurationDictionary[kTomatoConfigurationTableSpecialFontResourcePath];
            
            UIFont* specialFont = [UIFont fontWithName:fontName size:12.0];
            
            if (specialFont && [specialFont.fontName compare:fontName] == NSOrderedSame) {
                //
            } else {
                NSData *inData = [NSData dataWithContentsOfFile:fontResourcePath];
                CFErrorRef error;
                CGDataProviderRef provider = CGDataProviderCreateWithCFData((__bridge CFDataRef)inData);
                CGFontRef font = CGFontCreateWithDataProvider(provider);
                if (! CTFontManagerRegisterGraphicsFont(font, &error)) {
                    CFStringRef errorDescription = CFErrorCopyDescription(error);
                    NSLog(@"Failed to load font: %@", errorDescription);
                    CFRelease(errorDescription);
                }
                CFRelease(font);
                CFRelease(provider);
            }
        }
    }
    
    return self;
}

- (void)configBackgroundImage:(UIImage *)backgroundImage {
    if (backgroundImage) {
        NSData *backgroundImageData = UIImageJPEGRepresentation(backgroundImage, 0.5);
        [self.tomatoConfigurationDictionary setValue:backgroundImageData forKey:kTomatoConfigurationTableBackgroundImageData];
        [INSTomatoConfigurationTablePersistence saveTomatoConfigurationTable:self.tomatoConfigurationDictionary];
    }
}

- (void)configActivedTask:(INSTaskModel *)taskModel {
    if (taskModel) {
        [self.tomatoConfigurationDictionary setValue:[taskModel convertToDictionary] forKey:kTomatoConfigurationTableActivedTask];
        [INSTomatoConfigurationTablePersistence saveTomatoConfigurationTable:self.tomatoConfigurationDictionary];
    }
}

- (INSTaskModel *)activedTask {
    NSDictionary *activedTaskDictionary = self.tomatoConfigurationDictionary[kTomatoConfigurationTableActivedTask];
    return [[INSTaskModel alloc] initWithTaskDictionary:activedTaskDictionary];
}

- (BOOL)isAddTaskEnabled {
    return [self.tomatoConfigurationDictionary[kTomatoConfigurationTableIsAddTaskEnabled] boolValue];
}

- (NSString *)title {
    return self.tomatoConfigurationDictionary[kTomatoConfigurationTableTitle];
}

- (NSString *)subTitle {
    return self.tomatoConfigurationDictionary[kTomatoConfigurationTableSubTitle];
}

- (UIImage *)icon {
    NSData *iconData = self.tomatoConfigurationDictionary[kTomatoConfigurationTableIconData];
    return [UIImage imageWithData:iconData];
}

- (UIImage *)backgroundImage {
    NSData *backgroundImageData = self.tomatoConfigurationDictionary[kTomatoConfigurationTableBackgroundImageData];
    return [UIImage imageWithData:backgroundImageData];
}

- (UIImage *)sharedCodeImage {
    NSData *sharedCodeImageData = self.tomatoConfigurationDictionary[kTomatoConfigurationTablesharedCodeImageData];
    return [UIImage imageWithData:sharedCodeImageData];
}

- (UIImage *)sharedUrlString {
    return self.tomatoConfigurationDictionary[kTomatoConfigurationTablesharedUrlString];
}

- (INSSupportedPluginType)topLeftPluginType {
    return [self.tomatoConfigurationDictionary[kTomatoConfigurationTableTopLeftPluginType] integerValue];
}

- (INSSupportedPluginType)topRightPluginType {
    return [self.tomatoConfigurationDictionary[kTomatoConfigurationTableTopRightPluginType] integerValue];
}

- (INSSupportedPluginType)bottomLeftPluginType {
    return [self.tomatoConfigurationDictionary[kTomatoConfigurationTableBottomLeftPluginType] integerValue];
}

- (INSSupportedPluginType)bottomRightPluginType {
    return [self.tomatoConfigurationDictionary[kTomatoConfigurationTableBottomRightPluginType] integerValue];
}

- (NSInteger)secondsPerMinute {
    return [self.tomatoConfigurationDictionary[kTomatoConfigurationTableSecondsPerMinute] integerValue];
}

- (BOOL)isSpecialFontOptionEnabled {
    return [self.tomatoConfigurationDictionary[kTomatoConfigurationTableIsSpecialFontOptionEnabled] boolValue];
}

- (NSString *)specialFontResourcePath {
    return self.tomatoConfigurationDictionary[kTomatoConfigurationTableSpecialFontResourcePath];
}

- (NSString *)specialFontName {
    return self.tomatoConfigurationDictionary[kTomatoConfigurationTableSpecialFontName];
}

- (BOOL)isMusicOptionEnabled {
    return [self.tomatoConfigurationDictionary[kTomatoConfigurationTableIsMusicOptionEnabled] boolValue];
}

- (NSArray *)musicNameArray {
    return self.tomatoConfigurationDictionary[kTomatoConfigurationTableMusicNameArray];
}

- (NSArray *)musicUrlPathArray {
    return self.tomatoConfigurationDictionary[kTomatoConfigurationTableMusicUrlPathArray];
}

- (NSURL *)musicUrlForMusicName:(NSString *)musicName {
    NSArray *musicArray = self.tomatoConfigurationDictionary[kTomatoConfigurationTableMusicNameArray];
    NSArray *musicUrlPathArray = self.tomatoConfigurationDictionary[kTomatoConfigurationTableMusicUrlPathArray];
    NSInteger index = [musicArray indexOfObject:musicName];

    if (index >= 0) {
        return [NSURL fileURLWithPath: musicUrlPathArray[index]];
    }

    return nil;
}

@end
