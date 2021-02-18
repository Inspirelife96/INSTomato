//
//  INSTomatoBundle.m
//  INSTomato-INSTomato
//
//  Created by XueFeng Chen on 2021/2/5.
//

#import "INSTomatoBundle.h"

#import <CoreText/CoreText.h>

@implementation INSTomatoBundle

+ (NSBundle *)bundle {
    NSString *bundlePath = [[NSBundle bundleForClass:[self class]].resourcePath
                                stringByAppendingPathComponent:@"/INSTomato.bundle"];
    return [NSBundle bundleWithPath:bundlePath];
}


+ (UIImage *)imageNamed:(NSString *)name {
    if (@available(iOS 13.0, *)) {
        return [UIImage imageNamed:name inBundle:[INSTomatoBundle bundle] withConfiguration:nil];
    } else {
        return [UIImage imageNamed:name inBundle:[INSTomatoBundle bundle] compatibleWithTraitCollection:nil];
    }
}

+ (void)loadSpecialFont {
    NSString *fontPath = [[INSTomatoBundle bundle] pathForResource:@"叶根友蚕燕隶书" ofType:@"ttf"];
    NSData *inData = [NSData dataWithContentsOfFile:fontPath];
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

@end
