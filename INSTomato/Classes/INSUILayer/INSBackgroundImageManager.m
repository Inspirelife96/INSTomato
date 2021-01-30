//
//  INSBackgroundImageManager.m
//  ChameleonFramework
//
//  Created by XueFeng Chen on 2021/1/30.
//

#import "INSBackgroundImageManager.h"
#import "UIImageEffects.h"

@implementation INSBackgroundImageManager

static INSBackgroundImageManager *backgroundImageManager = nil;

+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        backgroundImageManager = [[super allocWithZone:NULL] init];
    });
    
    return backgroundImageManager;
}

+ (id)allocWithZone:(struct _NSZone *)zone {
    return [INSBackgroundImageManager sharedInstance] ;
}

- (id)copyWithZone:(struct _NSZone *)zone {
    return [INSBackgroundImageManager sharedInstance] ;
}

- (INSBackgroundImageManager *)init {
    self = [super init];
    
    if (self) {
        _backgroundImage = [UIImageEffects imageByApplyingDarkEffectToImage:[UIImage imageNamed:@"default_background_1080x1920"]];
    }
    
    return self;
}

- (void)setBackgroundImage:(UIImage *)backgroundImage {
    _backgroundImage = [UIImageEffects imageByApplyingDarkEffectToImage:backgroundImage];
}

@end
