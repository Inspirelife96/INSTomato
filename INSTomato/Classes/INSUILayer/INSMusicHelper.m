//
//  INSMusicHelper.m
//  INSTomato
//
//  Created by XueFeng Chen on 2021/2/1.
//

#import "INSMusicHelper.h"

@implementation INSMusicHelper

+ (NSURL *)musicUrlByName:(NSString *)musicName {
    NSDictionary *musicDict = @{
                                @"纯然":@"纯然",
                                @"森林":@"森林",
                                @"心灵":@"心灵",
                                @"星夜":@"星夜",
                                @"云端":@"云端"
                                };
    
    
    
    NSString *musicFileName = musicDict[musicName];
    NSString *musicFileType = @"m4a";
    
    return [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:musicFileName ofType:musicFileType]];
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
