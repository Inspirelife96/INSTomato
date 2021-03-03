//
//  INSMusicHelper.m
//  INSTomato
//
//  Created by XueFeng Chen on 2021/2/1.
//

#import "INSMusicHelper.h"

@implementation INSMusicHelper

//+ (NSURL *)musicUrlByName:(NSString *)musicName {
//    NSDictionary *musicDict = @{
//                                @"纯然":@"纯然",
//                                @"森林":@"森林",
//                                @"心灵":@"心灵",
//                                @"星夜":@"星夜",
//                                @"云端":@"云端"
//                                };
//    
//    
//    
//    NSString *musicFileName = musicDict[musicName];
//    NSString *musicFileType = @"m4a";
//    
//    NSString *frameworkBundlePath = [[NSBundle bundleForClass:[self class]].resourcePath
//                                stringByAppendingPathComponent:@"/INSTomato.bundle"];
//    NSBundle *INSTomatoBundle = [NSBundle bundleWithPath:frameworkBundlePath];
//    
//    return [NSURL fileURLWithPath:[INSTomatoBundle pathForResource:musicFileName ofType:musicFileType]];
//}

+ (NSArray *)musicUrlPathArray {
    NSArray *musicNameArray = [INSMusicHelper musicNameArray];
    
    NSMutableArray *musicUrlPathArray = [[NSMutableArray alloc] init];
    
    [musicNameArray enumerateObjectsUsingBlock:^(NSString * _Nonnull musicNameString, NSUInteger idx, BOOL * _Nonnull stop) {
        NSString *resourcePath = [[NSBundle mainBundle] pathForResource:musicNameString ofType:@"m4a"];
        [musicUrlPathArray addObject:resourcePath];
    }];
    
    return [musicUrlPathArray copy];
}

+ (NSArray *)musicNameArray {
    return  @[
              @"纯然",
              @"森林",
              @"心灵",
              @"星夜",
              @"云端"
              ];
}

@end
