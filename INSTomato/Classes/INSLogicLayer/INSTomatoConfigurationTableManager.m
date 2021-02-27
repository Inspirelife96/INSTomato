//
//  INSTomatoConfigurationTableManager.m
//  INSTomato
//
//  Created by XueFeng Chen on 2021/2/22.
//

#import "INSTomatoConfigurationTableManager.h"

#import "INSTomatoConfigurationTablePersistence.h"
#import "INSPersistenceConstants.h"
#import "INSTomatoConfiguration.h"

static INSTomatoConfigurationTableManager *sharedInstance = nil;

@interface INSTomatoConfigurationTableManager ()

@property (strong, nonatomic) NSDictionary *tomatoConfigurationDictionary;

@end

@implementation INSTomatoConfigurationTableManager

+ (void)createTomatoConfigurationTable:(INSTomatoConfiguration *)tomatoConfiguration {
    if ([INSTomatoConfigurationTablePersistence readTomatoConfigurationTable]) {
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

@end
