//
//  INSBackgroundImageManager.m
//  INSTomato
//
//  Created by XueFeng Chen on 2021/2/10.
//

#import "INSBackgroundImageManager.h"

#import "INSBookmarkTableManager.h"
#import "INSBookmarkModel.h"

#import "UIImageEffects.h"

static INSBackgroundImageManager *backgroumdImageManager = nil;

@interface INSBackgroundImageManager ()

@end

@implementation INSBackgroundImageManager

+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        backgroumdImageManager = [[super allocWithZone:NULL] init];
    });
    
    return backgroumdImageManager;
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
        INSBookmarkModel *bookmarkModel = [[INSBookmarkTableManager sharedInstance] prepareBookmarkModel];
        _backgroundImage = [UIImageEffects imageByApplyingDarkEffectToImage:bookmarkModel.image];
    }
    
    return self;
}

- (void)configBackgroundImage:(UIView *)parentView {
    CGRect rect = parentView.frame;
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [parentView.layer renderInContext:context];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    _backgroundImage = [UIImageEffects imageByApplyingDarkEffectToImage:image];
}

@end
