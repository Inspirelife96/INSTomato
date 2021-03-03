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

+ (UIImageView *)accessoryView {
    UIImageView *accessoryView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 10, 15, 15)];
    accessoryView.contentMode = UIViewContentModeScaleAspectFit;
    accessoryView.image = [INSTomatoBundle imageNamed:@"ins_disclosure_Indicator"];
    
    return accessoryView;
}

// 加载 叶根友蚕燕隶书 字体
// 如果已经加载了，则直接返回。
//+ (void)loadSpecialFont {
//    UIFont* specialFont = [UIFont fontWithName:self.specialFontName size:12.0];
//    
//    if (specialFont && [specialFont.fontName compare:@"-"] == NSOrderedSame) {
//        return;
//    } else {
//        NSString *fontPath = [[INSTomatoBundle bundle] pathForResource:@"叶根友蚕燕隶书" ofType:@"ttf"];
//        NSData *inData = [NSData dataWithContentsOfFile:fontPath];
//        CFErrorRef error;
//        CGDataProviderRef provider = CGDataProviderCreateWithCFData((__bridge CFDataRef)inData);
//        CGFontRef font = CGFontCreateWithDataProvider(provider);
//        if (! CTFontManagerRegisterGraphicsFont(font, &error)) {
//            CFStringRef errorDescription = CFErrorCopyDescription(error);
//            NSLog(@"Failed to load font: %@", errorDescription);
//            CFRelease(errorDescription);
//        }
//        CFRelease(font);
//        CFRelease(provider);
//    }
//}

@end
