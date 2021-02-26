//
//  INSCopyScreenManager.m
//  INSTomato
//
//  Created by XueFeng Chen on 2021/2/10.
//

#import "INSCopyScreenManager.h"

#import "INSBookmarkTableManager.h"
#import "INSBookmarkModel.h"

#import "UIImageEffects.h"

static INSCopyScreenManager *copyScreenManager = nil;

@interface INSCopyScreenManager ()

@end

@implementation INSCopyScreenManager

+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        copyScreenManager = [[super allocWithZone:NULL] init];
    });
    
    return copyScreenManager;
}

+ (id)allocWithZone:(struct _NSZone *)zone {
    return [INSCopyScreenManager sharedInstance] ;
}

- (id)copyWithZone:(struct _NSZone *)zone {
    return [INSCopyScreenManager sharedInstance] ;
}

- (INSCopyScreenManager *)init {
    self = [super init];
    
    if (self) {
        INSBookmarkModel *bookmarkModel = [[INSBookmarkTableManager sharedInstance] prepareBookmarkModel];
        _copiedScreenImage = [UIImageEffects imageByApplyingDarkEffectToImage:bookmarkModel.image];
    }
    
    return self;
}

- (void)copyScreen:(UIView *)copiedView {
    CGRect rect = copiedView.frame;
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [copiedView.layer renderInContext:context];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    _copiedScreenImage = [UIImageEffects imageByApplyingDarkEffectToImage:image];
}

@end
