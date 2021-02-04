//
//  INSTomatoBundle.m
//  INSTomato-INSTomato
//
//  Created by XueFeng Chen on 2021/2/5.
//

#import "INSTomatoBundle.h"

@implementation INSTomatoBundle

+ (NSBundle *)imageBundle {
    NSString *imageBundlePath = [[NSBundle bundleForClass:[self class]].resourcePath
                                stringByAppendingPathComponent:@"/INSTomatoImage.bundle"];
    return [NSBundle bundleWithPath:imageBundlePath];
}

+ (NSBundle *)musicBundle {
    NSString *musicBundlePath = [[NSBundle bundleForClass:[self class]].resourcePath
                                stringByAppendingPathComponent:@"/INSTomatoMusic.bundle"];
    return [NSBundle bundleWithPath:musicBundlePath];
}

@end
