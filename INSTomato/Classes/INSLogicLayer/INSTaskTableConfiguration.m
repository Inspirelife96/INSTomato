//
//  INSTaskTableConfiguration.m
//  INSTomato
//
//  Created by XueFeng Chen on 2021/2/18.
//

#import "INSTaskTableConfiguration.h"

#import "INSTomatoBundle.h"

@implementation INSTaskTableConfiguration

//- (instancetype)init {
//    return [self initWithTaskModelArray:@[]];
//}

- (instancetype)initWithTaskModelArray:(NSArray<INSTaskModel *> *)taskModelArray {
    if (self = [super init]) {
        _taskModelArray = taskModelArray;
        _isAddTaskEnabled = NO;
        _taskTableTitle = @"勤之时";
        _taskTableDescription = @"美好的励志时光";
        _taskTableIcon = [INSTomatoBundle imageNamed:@"iphone app 60"];
    }
    
    return self;
}


@end
