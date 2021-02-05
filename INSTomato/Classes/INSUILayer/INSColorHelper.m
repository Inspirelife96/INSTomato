//
//  INSColorHelper.m
//  INSTomato
//
//  Created by XueFeng Chen on 2021/1/30.
//

#import "INSColorHelper.h"

#import <ChameleonFramework/Chameleon.h>

@implementation INSColorHelper

+ (UIColor *)colorByName:(NSString *)colorName {
    NSDictionary *colorDictionary = @{
        @"赤色":FlatRed,
        @"橙色":FlatOrange,
        @"黄色":FlatYellow,
        @"绿色":FlatGreen,
        @"青色":FlatSkyBlue,
        @"蓝色":FlatBlue,
        @"紫色":FlatPurple,
    };
    
    return colorDictionary[colorName];
}

+ (NSArray *)colorNameList {
    return @[
        @"赤色",
        @"橙色",
        @"黄色",
        @"绿色",
        @"青色",
        @"蓝色",
        @"紫色",
    ];
}

@end
