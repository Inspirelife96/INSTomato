//
//  INSTomatoBundle.m
//  INSTomato-INSTomato
//
//  Created by XueFeng Chen on 2021/2/5.
//

#import "INSTomatoBundle.h"

@implementation INSTomatoBundle

+ (NSBundle *)bundle {
    NSString *bundlePath = [[NSBundle bundleForClass:[self class]].resourcePath
                                stringByAppendingPathComponent:@"/INSTomato.bundle"];
    return [NSBundle bundleWithPath:bundlePath];
}

@end
