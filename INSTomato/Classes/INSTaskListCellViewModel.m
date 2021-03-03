//
//  INSTaskListCellViewModel.m
//  INSTomato
//
//  Created by XueFeng Chen on 2021/1/30.
//

#import "INSTaskListCellViewModel.h"

#import "INSTaskModel.h"

#import "INSTomatoBundle.h"

#import "UIImage+INS_ContentWithColor.h"
#import "INSColorHelper.h"

@implementation INSTaskListCellViewModel

- (instancetype)initWithTaskModel:(INSTaskModel *)taskModel {
    if (self = [super init]) {
        _taskModel = taskModel;
        _taskName = taskModel.name;
        _taskTomatoMinutes = [NSString stringWithFormat:@"%@分钟", taskModel.tomatoMinutes];
        
        UIImage *colorImage = nil;
        if (@available(iOS 13.0, *)) {
            colorImage = [UIImage imageNamed:@"ins_task_color" inBundle:[INSTomatoBundle bundle] withConfiguration:nil];
        } else {
            colorImage = [UIImage imageNamed:@"ins_task_color" inBundle:[INSTomatoBundle bundle] compatibleWithTraitCollection:nil];
        }
        
        _taskColorImage = [colorImage ins_contentWithColor:[INSColorHelper colorByName:taskModel.color]];
    }
    
    return self;
}

@end
