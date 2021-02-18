//
//  INSTaskTableConfiguration.m
//  INSTomato
//
//  Created by XueFeng Chen on 2021/2/18.
//

#import "INSTaskTableConfiguration.h"

@implementation INSTaskTableConfiguration

//- (instancetype)init {
//    return [self initWithTaskModelArray:@[]];
//}

- (instancetype)initWithTaskModelArray:(NSArray<INSTaskModel *> *)taskModelArray {
    if (self = [super init]) {
        _taskModelArray = taskModelArray;
        _isAddTaskEnabled = NO;
        _taskTableTitle = @"";
        _taskTableDescription = @"";
        _taskTableIconData = [[NSData alloc] init];
    }
    
    return self;
}


@end
